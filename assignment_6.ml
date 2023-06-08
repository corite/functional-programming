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
  type rat = Rat of int * int

  let rec gcd a b = if b = 0 then a else gcd b (a mod b)

  let cancel r =
    match r with
    | Rat (n, d) ->
        let num = gcd n d in
        Rat (n / num, d / num)

  let rec add r1 r2 =
    match (r1, r2) with
    | Rat (n1, d1), Rat (n2, d2) when d1 = d2 -> cancel (Rat (n1 + n2, d1))
    | Rat (n1, d1), Rat (n2, d2) ->
        add (Rat (n1 * d2, d1 * d2)) (Rat (n2 * d1, d2 * d1))

  let sub r1 r2 =
    match (r1, r2) with r1, Rat (n2, d2) -> add r1 (Rat (-n2, d2))

  let mul r1 r2 =
    match (r1, r2) with
    | Rat (n1, d1), Rat (n2, d2) -> cancel (Rat (n1 * n2, d1 * d2))

  let div r1 r2 =
    match (r1, r2) with r1, Rat (n2, d2) -> mul r1 (Rat (d2, n2))

  let toRat i1 i2 = Rat (i1, i2)
  let fromRat r = match r with Rat (n, d) -> (n, d)
end
