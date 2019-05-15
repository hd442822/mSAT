(** Exception raised if an atom cannot be created *)
exception Bad_atom

(** Atoms are represented as integers. [-i] begin the negation of [i].
    Additionally, since we nee dot be able to create fresh atoms, we
    use even integers for user-created atoms, and odd integers for the
    fresh atoms. *)
type t = int

let max_lit = max_int

(* Counters *)
let max_index = ref 0
let max_fresh = ref (-1)

(** Internal function for creating atoms.
    Updates the internal counters *)
let _make i =
  if i <> 0 && abs i < max_lit then (
    max_index := max !max_index (abs i);
    i )
  else
    raise Bad_atom

let to_int i = i

(** *)
let neg a = -a

let norm a =
  ( abs a,
    if a < 0 then
      Solver_intf.Negated
    else
      Solver_intf.Same_sign )

let abs = abs

let sign i = i > 0

let apply_sign b i = if b then i else neg i

let set_sign b i = if b then abs i else neg (abs i)

let hash (a : int) = a land max_int
let equal (a : int) b = a = b
let compare (a : int) b = Pervasives.compare a b

let make i = _make (2 * i)

let fresh () =
  incr max_fresh;
  _make ((2 * !max_fresh) + 1)

(*
let iter: (t -> unit) -> unit = fun f ->
  for j = 1 to !max_index do
    f j
  done
*)

let pp fmt a =
  Format.fprintf fmt "%s%s%d"
    (if a < 0 then "~" else "")
    (if a mod 2 = 0 then "v" else "f")
    (abs a / 2)
