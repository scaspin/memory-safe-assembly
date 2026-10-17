use bums::common::*;
use z3::SatResult;

const REMAINDER_BITS_AND_LOOP_BOUND: &str = r#"
(declare-fun MAX () Int)
(declare-fun x_len () Int)
(declare-fun inc_x () Int)
(declare-fun n () Int)
(declare-fun x () Int)
(declare-fun loop17_? () Int)
(assert (>= MAX 9223372036854775807))
(assert (>= x_len 0))
(assert (>= inc_x 1))
(assert (<= (* inc_x n) x_len))
(assert (not (<= n 0)))
(assert (not (<= inc_x 0)))
(assert (not (not (= inc_x 1))))
(assert (not (<= n 8)))
(assert (not (= (mod x 8) 0)))
(assert (not (<= (div (+ (- 1) n) 16) 0)))
(assert (not (<= (div (+ (- 1) n) 16) 1)))
(assert (<= (+ (div (+ (- 1) n) 16) (* (- 1) loop17_?)) 3))
(assert (let ((a!1 (+ (div (+ n (- 1)) (to_int (^ 2 4))) (- 2) (* loop17_? (- 1)) 0)))
  (> a!1 0)))
(assert (let ((a!1 (<= (+ (div (+ (- 1) n) 16) (* (- 1) loop17_?)) 3)))
  (not (not a!1))))
(assert (not (<= (mod (+ 15 n) 16) 0)))
(assert (let ((a!1 (mod (div (mod (+ 15 n) 16) 8) 2)))
  (= a!1 0)))
(assert (let ((a!1 (mod (div (mod (+ 15 n) 16) 4) 2)))
  (not (= a!1 0))))
(assert (let ((a!1 (mod (div (mod (+ 15 n) 16) 2) 2)))
  (= a!1 0)))
(assert (let ((a!1 (= (mod (mod (+ 15 n) 16) 2) 0)))
  (not a!1)))
(assert (let ((a!1 (>= (- (+ x (* inc_x 8) 256 (* loop17_? 128) 160 8) 1)
               (+ x (* x_len 8)))))
  (and (> 8 0) a!1)))
"#;

#[test]
fn a_query_the_default_engine_gives_up_on_is_still_decided() {
    let before = z3::get_global_param("smt.arith.solver");
    let solver = z3::Solver::new();
    solver.from_string(REMAINDER_BITS_AND_LOOP_BOUND);
    assert_eq!(check(&solver, &[]), SatResult::Unsat);
    assert_eq!(z3::get_global_param("smt.arith.solver"), before);
}
