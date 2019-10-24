(** Twtxt support: https://twtxt.readthedocs.io/en/stable/user/twtxtfile.html *)

open Bedrock
open Paperwork

type t =
  { date : Timetable.Moment.t
  ; message : string
  }

val make : Timetable.Moment.t -> string -> t
val to_qexp : t -> Qexp.t
val from_qexp : Qexp.t -> t Validation.t
val to_string : t -> string
