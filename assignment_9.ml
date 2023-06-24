type church = Zero | Succ of church

let rec add a b = match (a, b) with a, Zero -> a | a, Succ b -> add (Succ a) b
let two = Succ (Succ Zero)
let four = add two two

type monop = Neg | Not (* integer / Boolean negation *)

type binop =
  | Add
  | Sub
  | Mul
  | Div
  | Mod
  | (* arithmetic operators *)
    Eq
  | Ne
  | Lt
  | Le
  | Gt
  | Ge
  | (* relational operators *)
    And
  | Or (* logical operators *)

type expr =
  | Num of int (* integer constant *)
  | Bool of bool (* boolean constant *)
  | Var of string (* variable *)
  | MonApp of monop * expr (* unary operator application *)
  | BinApp of binop * expr * expr (* binary operator application *)
  | Cond of expr * expr * expr (* conditional expression *)
  | Lam of string * expr (* function abstraction *)
  | App of expr * expr (* function application *)
  | Let of string * expr * expr (* variable binding *)
  | LetRec of string * expr * expr (* recursive variable binding *)

let rec expr2string = function
  | Var s -> s
  | Num i -> Int.to_string i
  | Bool b -> Bool.to_string b
  | MonApp (m, e) -> (match m with Neg -> "-" | Not -> "!") ^ expr2string e
  | BinApp (b, e1, e2) ->
      let infix s = expr2string e1 ^ s ^ expr2string e2 in
      infix
        (match b with
        | Add -> "+"
        | Sub -> "-"
        | Mul -> "*"
        | Div -> "/"
        | Mod -> "%"
        | Eq -> "="
        | Ne -> "!="
        | Lt -> "<"
        | Le -> "<="
        | Gt -> ">"
        | Ge -> ">="
        | And -> "&"
        | Or -> "|")
  | Cond (e1, e2, e3) ->
      "if " ^ expr2string e1 ^ " then " ^ expr2string e2 ^ " else "
      ^ expr2string e3
  | Lam (s, e) -> "λ" ^ s ^ "." ^ expr2string e
  | App (e1, e2) -> "(" ^ expr2string e1 ^ " " ^ expr2string e2 ^ ")"
  | Let (s, e1, e2) ->
      "let " ^ s ^ "=" ^ expr2string e1 ^ " in " ^ expr2string e2
  | LetRec (s, e1, e2) ->
      "letrec " ^ s ^ "=" ^ expr2string e1 ^ " in " ^ expr2string e2
