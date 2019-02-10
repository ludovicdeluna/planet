(** Deal with Planet's project *)

open Bedrock
open Baremetal

(** Get the database *)
val database : Shapes.Project.t Database.t

(** Read a project from a file *)
val read : File.name -> Shapes.Project.t Validation.t * File.name

(** Get a list of potential projects *)
val inspect :
  unit -> (Shapes.Project.t Validation.t * File.name) list Result.t

(** Get list of project *)
val all : unit -> Shapes.Project.t list Validation.t
