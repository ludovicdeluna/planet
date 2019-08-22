open Js_of_ocaml
open Paperwork

type timestamp = float
type date = Js.date Js.t

val now : unit -> date
val time_of : date -> timestamp
val from_day : Timetable.Day.t -> date
val from_month : Timetable.Month.t -> date
val from_year : Timetable.Year.t -> date
val from_moment : Timetable.Moment.t -> date

module Ago : sig
  type t =
    | Today
    | Yesterday
    | Days of int
    | Weeks of int

  type direction =
    | Past
    | Future

  val compute : ?reference:date -> date -> t * direction
  val stringify : t * direction -> string
end