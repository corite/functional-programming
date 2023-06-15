type expr =
  | Var of string (* variable *)
  | Lambda of string * expr (* function abstraction *)
  | App of expr * expr (* function application *)
  | Let of string * expr * expr (* variable binding *)
  | LetRec of string * expr * expr (* recursive variable binding *)

let rec expr2string = function
  | Var v -> v
  | Lambda (v, e) -> "λ" ^ v ^ "." ^ expr2string e
  | App (e1, e2) -> expr2string e1 ^ expr2string e2
  | Let (n, e1, e2) -> n ^ expr2string e1 ^ expr2string e2
  | LetRec (n, e1, e2) -> n ^ expr2string e1 ^ expr2string e2

let rec subst e v s = match e with
| Var v -> s
| Lambda (v, e) -> Lambda (v, subst e v s)
| App (e1, e2) -> App (subst e1 v s, subst e2 v s)
| Let (n, e1, e2) -> Let (n, subst e1 v s, subst e2 v s)
| LetRec (n, e1, e2) -> LetRec (n, subst e1 v s, subst e2 v s)
