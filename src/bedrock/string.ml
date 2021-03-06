module S = Stdlib.String

let md5 = Util.md5

let start_with base suffix =
  let len_base = S.length base in
  let len_suff = S.length suffix in
  if len_base = len_suff && len_base = len_suff
  then true
  else if len_base < len_suff
  then false
  else (
    let rec loop i =
      if i >= len_suff
      then true
      else if S.get base i = S.get suffix i
      then loop (succ i)
      else false
    in
    loop 0)
;;

let end_with base suffix =
  let len_base = S.length base in
  let len_suff = S.length suffix in
  if len_base = len_suff && base = suffix
  then true
  else if len_base < len_suff
  then false
  else (
    let offset_i = len_base - len_suff in
    let rec loop i =
      if i >= len_suff
      then true
      else if S.get base (offset_i + i) = S.get suffix i
      then loop (succ i)
      else false
    in
    loop 0)
;;

let has_extension base extension = end_with base ("." ^ extension)
let lines = S.split_on_char '\n'

let super_trim x =
  let len = S.length x in
  let rec aux acc i =
    if i = len
    then acc
    else (
      match S.get x i with
      | '\n' | '\t' | '\r' | ' ' -> aux acc (succ i)
      | char -> aux (Format.sprintf "%s%c" acc char) (succ i))
  in
  aux "" 0
;;

let tokenize c subject = subject |> S.split_on_char c |> List.map S.trim

include S
