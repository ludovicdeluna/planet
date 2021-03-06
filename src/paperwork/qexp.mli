(** [Qexp] is a kind of [Sexp] with more semantics. It is used as a principal
    "serializable" format of [Planet].

    For example :

    {[ (foo {:bar #baz ( ; Comment (text "Hello World") (text `Hello World
    2`))}) ]} *)

open Bedrock

(** {2 Types} *)

(** Describe a quote. *)
type quote =
  | Double
  | Backtick

(** Describe a [Qexp] expression. *)
type t =
  | Atom of string (** Simple atom, like [foo], [bar].*)
  | Tag of string (** Atom with [:] as a prefix, like [:bar].*)
  | Keyword of string (** Atom with [#] as a prefix, like [#foo]. *)
  | String of (quote * string) (** A String, like ["foo"], [`bar`].*)
  | Node of t list (** A list of [Qexp], like [(foo "bar")].*)
  | Block of t list (** A list of [Qexp], like [{foo bar}] *)

(** {2 Build Qexp fragments} *)

(** Build an [atom]. *)
val atom : string -> t

(** Build a [tag]. *)
val tag : string -> t

(** Build a [keyword]. *)
val keyword : string -> t

(** Build a [string]. *)
val string : ?quote:quote -> string -> t

(** Build a [node]. *)
val node : t list -> t

(** Build a [block]. *)
val block : t list -> t

(** A double-quote. *)
val double_quote : quote

(** A back tick. *)
val back_tick : quote

(** K/V shortcut *)
val kv : ?k:(string -> t) -> ?v:(string -> t) -> string -> string -> t

(** {2 Deserialization} *)

(** From [char Stream.t] to [Qexp.t]. *)
val from_stream : char Stream.t -> t Result.t

(** From [string] to [Qexp.t]. *)
val from_string : string -> t Result.t

(** From [bytes] to [Qexp.t]. *)
val from_bytes : bytes -> t Result.t

(** {2 Serialization} *)

(** From [Qexp.t] to [string] *)
val to_string : t -> string

(** From [Qexp.t] to [bytes] *)
val to_bytes : t -> bytes

(** From [Qexp.t] to [char Stream.t] *)
val to_stream : t -> char Stream.t

(** Format for [printf] *)
val pp : Format.formatter -> t -> unit

(** {2 Utils} *)

val extract_root : t -> t list Result.t
