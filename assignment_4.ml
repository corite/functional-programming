let number x l =
  let f a x = if a = x then a + 1 else a in
  List.fold_left f 0 l

let heads l = List.map (fun x -> List.hd x) l
let pair l m = List.map2 (fun el em -> (el, em)) l m

type const = BoolConst of bool | IntConst of int
type monOp = Neg | Not
type logOp = And | Or
type relOp = Eq | Ne | Lt | Le | Gt | Ge
type artOp = Pls | Mns | Tms | Div | Mod
type binOp = Art of artOp | Rel of relOp | Log of logOp
type brOpn = BrOpen
type brCls = BrCls

type expre =
  | Expr of expre
  | BrExpr of brOpn * expre * brCls
  | BinOp of expre * binOp * expre
  | MonOp of monOp * expre
  | Const of const

type ('a,'b) trie = Node of 'b option * (('a,'b) trie * 'a) list
let mytrie = Node (Some 1, [Node(Some 2,[]) , 'b'])
let existsNode k l = List.exists (fun x -> match x with _, k-> true|a,b->false) l
let rec insert : ('a, 'b) trie -> 'a list -> 'b -> ('a, 'b) trie = fun t k v -> match k,t with 
hk::tk,Node(tv,tl) when existsNode hk tl -> Node(tv, List.map (fun x -> match x with n,hk -> insert n tk v,hk |_->x) tl) |
hk::[],Node(tv,tl) -> Node(tv, (Node(Some v,[]),hk)::tl) |
_ -> failwith "case not supported"

