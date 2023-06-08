type expr =
  | Var of string (* variable *)
  | Lambda of string * expr (* function abstraction *)
  | App of expr * expr (* function application *)
  | Let of string * expr * expr (* variable binding *)
  | LetRec of string * expr * expr (* recursive variable binding *)
