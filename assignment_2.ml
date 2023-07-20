let eu_of_us_time : int * int -> int * int * string =
 fun (h, m) -> if h > 12 then (h - 12, m, "pm") else (h, m, "am")

let us_of_eu_time : int * int * string -> int * int =
 fun (h, m, x) -> if x = "am" then (h, m) else (h + 12, m)

let eu_time_comparator (h1, m1) (h2, m2) =
  if h1 != h2 then Int.compare h1 h2 else Int.compare m1 m2

let after_us_time : int * int * string -> int * int * string -> bool =
 fun (h1, m1, x1) (h2, m2, x2) ->
  -1
  = eu_time_comparator (us_of_eu_time (h1, m1, x1)) (us_of_eu_time (h2, m2, x2))

let before_eu_time : int * int -> int * int -> bool =
 fun (h1, m1) (h2, m2) -> 1 = eu_time_comparator (h1, m1) (h2, m2)

let string_of_eu_time (h, m) = Int.to_string h ^ ":" ^ Int.to_string m
let string_of_us_time (h, m, x) = Int.to_string h ^ ":" ^ Int.to_string m ^ x

let formalize (p, s, c) =
  let cn = c mod 12 in
  let sn = (s + (c / 12)) / 20 in
  (p + (s / 20), sn, cn)

let plus (p1, s1, c1) (p2, s2, c2) = formalize (p1, s1, c1)

(*incorrect*)
let ovmin x y b = ((x - y + b) mod b, Int.abs (x - y) mod b)

let minus (p1, s1, c1) (p2, s2, c2) =
  let cs, so = ovmin c1 c2 12 in
  let ss, po = ovmin s1 (s2 - so) 20 in
  (p1 - p2 - po, ss, cs)

  (* records *)
type eudate = { minutes : int; hours : int }
type usdate = { minutes : int; hours : int; mode : string }
type bc = { pence : int; shilling : int; pound : int }
