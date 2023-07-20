# OCaml

## Basic Syntax

```ocaml
let var = 1
let list = [1;2;4]
let inc i : int -> int = i + 1
let inc = fun i -> i + 1
let head l = match l with h::t -> h
let rec firstDigit x = if x < 10 then x else firstDigit (x / 10)
```

## Tuples, Records

```ocaml
(* tuples *)
let instant : int*int = (1,1)
(* records *)
type eutime = { minutes : int; hours : int }
let instant = {minutes=1;hours=1}
```

## Algebraic Datatypes

```ocaml
type peano = Zero | Succ of peano
type bintree = Leaf of int | Node of bintree * bintree
type ('a, 'b) trie = Node of 'b option * (('a, 'b) trie * 'a) list

let rec count peano : peano -> int = match peano with
| Zero -> 0
| Succ x -> 1 + count x
```

## Higher Order List Functions

```ocaml
let incList l = List.map (fun i -> i+1)
let nonZeroElements l = List.filter (fun i -> i <> 0)
let containsZero l = List.mem 0 
let findFirstNegative l = List.find (fun i -> i < 0 )
let sum l = List.fold_left ( + ) 0
let map f l = List.fold_right (fun e a -> f e :: a) l []
```

## References

```ocaml
let cnt = ref 0
let inc c = c := !c +1
```

## Modules and Signatures

```ocaml
module type RatNumSig = sig
  type rat
  val add : rat -> rat -> rat
  val sub : rat -> rat -> rat
  val mul : rat -> rat -> rat
  val div : rat -> rat -> rat
  val toRat : int -> int -> rat
  val fromRat : rat -> int * int
end

module RatNum : RatNumSig = struct
(* implementation*)
end
```

## Exceptions

```ocaml
exception Fail
exception FailWithCodeAndMessage of int*string
raise (FailWithCodeAndMessage 1, "error")
```
