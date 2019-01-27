(** [Hashtbl.t] 's specialization. (To deal with [Qexp.t]) *)

open Bedrock

(** {2 Types} *)

type ('a, 'b) t = ('a, 'b) Hashtbl.t
type configuration = (string, Qexp.t option) t

(**{2 Builder} *)

(** Build a [Table.t] from a [Qexp.t] *)
val from_qexp_gen :
     (Qexp.t -> Qexp.t list -> ('a * 'b) Result.t)
  -> Qexp.t
  -> ('a, 'b) t Result.t

(** Build a [Table.t] from a [Qexp.t] with k/v [Qexp.t]. *)
val from_qexp :
     (string -> Qexp.t list -> ('a * 'b) Result.t)
  -> Qexp.t
  -> ('a, 'b) t Result.t

(** Build a [Table.configuration] from a [Qexp.t]. *)
val configuration : Qexp.t -> configuration Result.t

(** {2 Fetch data from table} 
    
    A [Table.t] is fetchable to extract fields using predicates.
*)

module Fetch : sig
  type 'a t = configuration -> string -> 'a Validation.t

  val option : 'a t -> 'a option t
  val string : string t
  val bool : bool t
  val list : (Qexp.t -> 'a Validation.t) -> 'a list t
  val list_refutable : (Qexp.t -> 'a Validation.t) -> 'a list t
  val token : (string -> 'a Validation.t) -> 'a t
end

module Mapper : sig
  val string : Qexp.t -> string Validation.t

  val token :
    (string -> 'a Validation.t) -> Qexp.t -> 'a Validation.t

  val couple :
       (Qexp.t -> 'a Validation.t)
    -> (Qexp.t -> 'b Validation.t)
    -> Qexp.t
    -> ('a * 'b) Validation.t

  val triple :
       (Qexp.t -> 'a Validation.t)
    -> (Qexp.t -> 'b Validation.t)
    -> (Qexp.t -> 'c Validation.t)
    -> Qexp.t
    -> ('a * 'b * 'c) Validation.t
end