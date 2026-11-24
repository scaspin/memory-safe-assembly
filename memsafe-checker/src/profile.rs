use std::cell::RefCell;
use std::collections::BTreeSet;
use std::time::{Duration, Instant};
use z3::{SatResult, Solver, ast};

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum Phase {
    Parsing,
    Serialization,
    Execution,
    LoopResolution,
    Forking,
    Solver,
}

#[derive(Clone, Default, Debug)]
pub struct Profile {
    pub parsing: Duration,
    pub serialization: Duration,
    pub execution: Duration,
    pub loop_resolution: Duration,
    pub forking: Duration,
    pub solver_in_execution: Duration,
    pub solver_in_loops: Duration,
    pub solver_queries: u64,
    pub steps: u64,
    pub instructions: BTreeSet<usize>,
    pub loop_headers: BTreeSet<usize>,
}

struct Clock {
    phases: Vec<Phase>,
    since: Instant,
    profile: Profile,
}

impl Clock {
    fn charge(&mut self) {
        let now = Instant::now();
        let spent = now - self.since;
        self.since = now;
        let mut below = self.phases.iter().rev();
        let profile = &mut self.profile;
        match below.next() {
            None => {}
            Some(Phase::Parsing) => profile.parsing += spent,
            Some(Phase::Serialization) => profile.serialization += spent,
            Some(Phase::Execution) => profile.execution += spent,
            Some(Phase::LoopResolution) => profile.loop_resolution += spent,
            Some(Phase::Forking) => profile.forking += spent,
            Some(Phase::Solver) => match below.find(|phase| **phase != Phase::Solver) {
                Some(Phase::LoopResolution) => profile.solver_in_loops += spent,
                _ => profile.solver_in_execution += spent,
            },
        }
    }
}

thread_local! {
    static CLOCK: RefCell<Clock> = RefCell::new(Clock {
        phases: Vec::new(),
        since: Instant::now(),
        profile: Profile::default(),
    });
}

#[must_use]
pub struct Entered;

pub fn enter(phase: Phase) -> Entered {
    CLOCK.with_borrow_mut(|clock| {
        clock.charge();
        if phase == Phase::Solver && clock.phases.last() != Some(&Phase::Solver) {
            clock.profile.solver_queries += 1;
        }
        clock.phases.push(phase);
    });
    Entered
}

impl Drop for Entered {
    fn drop(&mut self) {
        CLOCK.with_borrow_mut(|clock| {
            clock.charge();
            clock.phases.pop();
        });
    }
}

pub fn executed(pc: usize) {
    CLOCK.with_borrow_mut(|clock| {
        clock.profile.steps += 1;
        clock.profile.instructions.insert(pc);
    });
}

pub fn loops_back_to(header: usize) {
    CLOCK.with_borrow_mut(|clock| {
        clock.profile.loop_headers.insert(header);
    });
}

pub fn take() -> Profile {
    CLOCK.with_borrow_mut(|clock| {
        clock.charge();
        std::mem::take(&mut clock.profile)
    })
}

pub trait TimedSolver {
    fn check_timed(&self, assumptions: &[ast::Bool]) -> SatResult;
}

impl TimedSolver for Solver {
    fn check_timed(&self, assumptions: &[ast::Bool]) -> SatResult {
        let _solving = enter(Phase::Solver);
        self.check_assumptions(assumptions)
    }
}
