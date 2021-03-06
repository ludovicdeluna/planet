(** Deal with Planet's project *)

open Bedrock
open Baremetal

(** Get the database *)
val database : Shapes.Project.t Database.t

(** Read a project from a file *)
val read
  :  Shapes.Context.Projects.t
  -> File.name
  -> (Shapes.Project.t
     * Paperwork.Timetable.Day.t option
     * Shapes.Context.Projects.context option)
     Validation.t
     * File.name

(** Get a list of potential projects *)
val inspect
  :  ?rctx:Shapes.Context.t
  -> unit
  -> (Shapes.Context.Projects.t
     * ((Shapes.Project.t
        * Paperwork.Timetable.Day.t option
        * Shapes.Context.Projects.context option)
        Validation.t
       * File.name)
       list)
     Validation.t

(** Get list of project *)
val all
  :  ?rctx:Shapes.Context.t
  -> unit
  -> (Shapes.Context.Projects.t
     * (Shapes.Project.t
       * Paperwork.Timetable.Day.t option
       * Shapes.Context.Projects.context option)
       list)
     Validation.t

(** Get list of project as [Json.t] *)
val to_json : unit -> Paperwork.Json.t Validation.t

(** Convert project to Hakyll file *)
val to_hakyll_string
  :  Shapes.Project.t
     * Paperwork.Timetable.Day.t option
     * Shapes.Context.Projects.context option
  -> (Shapes.Project.t * File.name * string * string) Validation.t
