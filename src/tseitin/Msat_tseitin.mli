(*
MSAT is free software, using the Apache license, see file LICENSE
Copyright 2014 Guillaume Bury
Copyright 2014 Simon Cruanes
*)

(** Tseitin CNF conversion

    This modules implements Tseitin's Conjunctive Normal Form conversion, i.e.
    the ability to transform an arbitrary boolean formula into an equi-satisfiable
    CNF, that can then be fed to a SAT/SMT/McSat solver.
*)

(** The implementation of formulas required to implement Tseitin's CNF conversion. *)
module type Arg = Tseitin_intf.Arg

(** The exposed interface of Tseitin's CNF conversion. *)
module type S = Tseitin_intf.S

(** This functor provides an implementation of Tseitin's CNF conversion. *)
module Make (F : Arg) : S with type atom = F.t
