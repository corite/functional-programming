let rec nth l n =
  match l with h :: t -> if n = 0 then h else nth t (n - 1) | [] -> None

let iota n =
  let rec inner i n = if i = n then [] else i :: inner (i + 1) n in
  inner 0 n

let rec number x l =
  match l with
  | h :: t -> if h = x then 1 + number x t else number x t
  | [] -> 0

let rec heads l = match l with (h :: t) :: r -> h :: heads r | none -> []

let rec pair (l, m) =
  match (l, m) with lh :: lt, mh :: mt -> (lh, mh) :: pair (lt, mt) | _ -> []

let rec isSublist l m =
  let rec startsWith l m =
    match (l, m) with
    | lh :: lt, mh :: mt -> lh = mh && startsWith lt mt
    | [], _ -> true
    | _, [] -> false
  in
  match m with h :: t -> startsWith l m || isSublist l t | [] -> [] = l

(*let revrev l;;*)
(*let rec tokenize d s = let rec s2cl s = if String.length s = 0 then [] else s.[0]::s2cl String.sub s 1 (String-length s -1) in
    if String.length s = 0 then [] else ;;*)

let quicksort l =
  let rec split l op p =
    match l with
    | h :: t -> if op h p then h :: split t op p else split t op p
    | [] -> []
  in
  match l with
  | h :: t ->
      if t != [] then split t ( <= ) h @ (h :: split t ( > ) h) else [ h ]
  | [] -> []

let rec split l = match l with h :: t -> [ h ] :: split t | [] -> []

let rec merge l1 l2 =
  match (l1, l2) with
  | h1 :: t1, h2 :: t2 ->
      if h1 <= h2 then h1 :: merge t1 l2 else h2 :: merge l1 t2
  | [], _ -> l2
  | _, [] -> l1

let rec mergem l ll = match ll with h :: t -> mergem (merge h l) t | [] -> l

let mergesort l =
  let sl = split l in
  match sl with h1 :: t1 -> mergem h1 t1 | [] -> []
