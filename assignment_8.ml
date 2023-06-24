type expr =
  | Var of string (* variable *)
  | Lambda of string * expr (* lambda v . e *)
  | App of expr * expr (* ( e1 e2 ) *)
  | Let of string * expr * expr (* let v = e1 in e2 *)

let rec expr2string = function
  | Var s -> s
  | Lambda (s, e) -> "λ" ^ s ^ "." ^ expr2string e
  | App (e1, e2) -> "(" ^ expr2string e1 ^ " " ^ expr2string e2 ^ ")"
  | Let (s, e1, e2) ->
      "let " ^ s ^ "=" ^ expr2string e1 ^ " in " ^ expr2string e2

(* todo something is wrong, function signature is messed up *)
let freevars e =
  let rec fv = function
    | Var s, bv -> if List.exists (( = ) s) bv then [] else [ s ]
    | Lambda (s, e), bv -> fv (e, s :: bv)
    | App (e1, e2), bv -> fv (e1, bv) @ fv (e2, bv)
    | Let (s, e1, e2), bv -> fv (e1, bv) @ fv (e2, s :: bv)
  in
  (fv e, [])

(* todo handle name collisions *)
let rec subst = function
  | Var s, x, y when s = x -> y
  | Lambda (s, e), x, y when s <> x -> Lambda (s, subst (e, x, y))
  | App (e1, e2), x, y -> App (subst (e1, x, y), subst (e2, x, y))
  | Let (s, e1, e2), x, y when s <> x ->
      Let (s, subst (e1, x, y), subst (e2, x, y))
  | e, x, y -> e

let rec beta = function
  | App (Lambda (s, e), a) -> subst (e, s, a)
  | App (e1, e2) -> App (beta e1, beta e2)
  | Lambda (s, e) -> Lambda (s, beta e)
  | e -> e

let rec remove_let = function
  | Let (s, e1, e2) -> App (Lambda (s, e2), e1)
  | Lambda (s, e) -> Lambda (s, remove_let e)
  | App (e1, e2) -> App (remove_let e1, remove_let e2)
  | e -> e
