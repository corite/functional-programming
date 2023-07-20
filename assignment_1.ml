let rec firstDigit x = if x < 10 then x else firstDigit (x / 10)

let round f i =
  snd (modf (f *. Float.pow 10. (float_of_int i)))
  /. Float.pow 10. (float_of_int i)

let round2 f =
  let i = 2 in
  round f i

let isLeapYear x =
  x > 1582 && ((x mod 4 = 0 && not (x mod 100 = 0)) || x mod 400 = 0)

let isDate d m y =
  let isInRange a b c = a <= b && b <= c in
  isInRange 1 d 31 && isInRange 1 m 12 && y > 1582

let date2str d m y =
  let day = function
    | 1 -> "1st"
    | 2 -> "2nd"
    | 3 -> "3rd"
    | x -> string_of_int x ^ "th"
  in
  let month = function
    | 1 -> "January"
    | 2 -> "February"
    | 3 -> "March"
    | 4 -> "April"
    | 5 -> "May"
    | 6 -> "June"
    | 7 -> "July"
    | 8 -> "August"
    | 9 -> "September"
    | 10 -> "October"
    | 11 -> "November"
    | 12 -> "December"
    | _ -> failwith "new month discovered"
  in
  let year y = string_of_int y in
  month m ^ " " ^ day d ^ ", " ^ year y

let rec power f e = if e == 0 then 1. else f *. power f (e - 1)

let rec powers s i c =
  if i == 0 then s else s ^ Char.escaped c ^ powers s (i - 1) c

let rec digitalRoot n =
  let rec digitalSum n =
    if n < 10 then n else (n mod 10) + digitalSum (n / 10)
  in
  if n < 10 then n else digitalRoot (digitalSum n)

let rec isPalindrome s =
  if String.length s < 2 then true
  else
    s.[0] = s.[String.length s - 1]
    && isPalindrome (String.sub s 1 (String.length s - 2))
