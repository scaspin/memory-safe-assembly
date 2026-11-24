use std::cell::UnsafeCell;
use std::hint::black_box;
use std::panic::{AssertUnwindSafe, catch_unwind};
use std::rc::Rc;
use std::time::{Duration, Instant};

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum Size {
    Min,
    Mid,
    Max,
}

impl Size {
    pub const ALL: [Size; 3] = [Size::Min, Size::Mid, Size::Max];

    pub fn label(self) -> &'static str {
        match self {
            Size::Min => "min",
            Size::Mid => "mid",
            Size::Max => "max",
        }
    }

    pub fn pick<T>(self, min: T, mid: T, max: T) -> T {
        match self {
            Size::Min => min,
            Size::Mid => mid,
            Size::Max => max,
        }
    }
}

pub struct Calls {
    pub annotated: Box<dyn FnMut()>,
    pub raw: Box<dyn FnMut()>,
    pub input_bytes: usize,
}

impl Calls {
    pub fn new<S: 'static>(
        state: S,
        input_bytes: usize,
        mut annotated: impl FnMut(&mut S) + 'static,
        mut raw: impl FnMut(&mut S) + 'static,
    ) -> Calls {
        let shared = Rc::new(UnsafeCell::new(state));
        let for_raw = shared.clone();
        Calls {
            annotated: Box::new(move || annotated(black_box(unsafe { &mut *shared.get() }))),
            raw: Box::new(move || raw(black_box(unsafe { &mut *for_raw.get() }))),
            input_bytes,
        }
    }
}

pub struct Case {
    pub function: &'static str,
    pub build: fn(Size) -> Calls,
}

pub struct Measurement {
    pub annotated_ns: f64,
    pub raw_ns: f64,
    pub annotated_spread: (f64, f64),
    pub raw_spread: (f64, f64),
    pub paired_ratio: f64,
    pub iterations: u64,
}

unsafe extern "C" {
    fn pthread_set_qos_class_self_np(class: u32, relative_priority: i32) -> i32;
}

const QOS_CLASS_USER_INTERACTIVE: u32 = 0x21;

pub fn prefer_performance_cores() {
    let status = unsafe { pthread_set_qos_class_self_np(QOS_CLASS_USER_INTERACTIVE, 0) };
    assert_eq!(status, 0, "pthread_set_qos_class_self_np");
}

fn batch(call: &mut dyn FnMut(), iterations: u64) -> Duration {
    let start = Instant::now();
    for _ in 0..iterations {
        call();
    }
    start.elapsed()
}

fn quantile(sorted: &[f64], q: f64) -> f64 {
    let position = q * (sorted.len() - 1) as f64;
    let low = position.floor() as usize;
    let high = position.ceil() as usize;
    sorted[low] + (sorted[high] - sorted[low]) * (position - low as f64)
}

pub fn satisfies_preconditions(calls: &mut Calls) -> Result<(), String> {
    let previous = std::panic::take_hook();
    std::panic::set_hook(Box::new(|_| {}));
    let outcome = catch_unwind(AssertUnwindSafe(|| (calls.annotated)()));
    std::panic::set_hook(previous);
    outcome.map_err(|payload| {
        payload
            .downcast_ref::<String>()
            .cloned()
            .or_else(|| payload.downcast_ref::<&str>().map(|s| s.to_string()))
            .unwrap_or_else(|| "panic".to_string())
    })
}

pub fn measure(calls: &mut Calls, rounds: usize, batch_target: Duration) -> Measurement {
    for _ in 0..3 {
        batch(&mut calls.raw, 64);
        batch(&mut calls.annotated, 64);
    }
    let mut iterations = 1u64;
    while batch(&mut calls.raw, iterations) < batch_target && iterations < 1 << 28 {
        iterations *= 2;
    }

    let mut annotated = Vec::with_capacity(rounds);
    let mut raw = Vec::with_capacity(rounds);
    let mut ratios = Vec::with_capacity(rounds);
    for round in 0..rounds {
        let (a, r) = if round % 2 == 0 {
            let a = batch(&mut calls.annotated, iterations);
            let r = batch(&mut calls.raw, iterations);
            (a, r)
        } else {
            let r = batch(&mut calls.raw, iterations);
            let a = batch(&mut calls.annotated, iterations);
            (a, r)
        };
        let a = a.as_nanos() as f64 / iterations as f64;
        let r = r.as_nanos() as f64 / iterations as f64;
        annotated.push(a);
        raw.push(r);
        ratios.push(a / r);
    }
    for v in [&mut annotated, &mut raw, &mut ratios] {
        v.sort_by(|x, y| x.partial_cmp(y).unwrap());
    }
    Measurement {
        annotated_ns: quantile(&annotated, 0.5),
        raw_ns: quantile(&raw, 0.5),
        annotated_spread: (quantile(&annotated, 0.25), quantile(&annotated, 0.75)),
        raw_spread: (quantile(&raw, 0.25), quantile(&raw, 0.75)),
        paired_ratio: quantile(&ratios, 0.5),
        iterations,
    }
}
