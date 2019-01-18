open Bedrock
open Error
open Util

type name = string
type children = File.name list

let exists dirname =
  match File.is_directory dirname with Ok x -> x | Error _ -> false
;;

let children ?(filter = const true) dirname =
  if not (exists dirname)
  then Error (Unreadable dirname)
  else
    Ok (dirname |> Sys.readdir |> Array.to_list |> List.filter filter)
;;

let current = Sys.getcwd

let make ?(chmod = 0o777) dirname =
  try Ok (Unix.mkdir dirname chmod) with
  | Unix.(Unix_error (EEXIST, _, _)) ->
    Error (Already_exists dirname)
  | _ ->
    Error (Unreadable dirname)
;;
