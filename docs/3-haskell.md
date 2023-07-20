# Haskell

## Basic Syntax
```haskell
i = 1
inc :: Int -> Int
inc i = i+1
inc = \i -> i +1
list = [1,2,3]
a = b + c
  where
    b = 1
    c = 2
tup = (1,"two",3.0)
mult :: Int -> Int -> Int -> Int
mult x y z = x*y*z

length :: [a] -> Int
length [] = 0
length (_:xs) = 1 + length xs
```



## List Comprehensions

```ocaml
factors :: Int -> [Int]
factors n = [x | x <- [1..n], n `mod` x == 0]

prime :: Int -> Bool
prime n = factors n == [1,n]

primes :: Int -> [Int]
primes n = [x | x <- [2..n], prime x]
```

## Functions

```haskell
reverse :: [a] -> [a]
reverse [] = []
reverse (x:xs) = reverse xs ++ [x]

map
filter
foldr
foldl
```

## Types

```haskell
type Pos = (Int,Int)

origin :: Pos
origin = (0,0)

data Answer = Yes | No | Maybe
data Maybe a = Nothing | Just a
data Nat = Zero | Succ Nat
```

Type declarations cannot be recursive

## Type Classes

```haskell
class Eq a where
    (==) : a -> a -> Bool
    (/=) : a -> a -> Bool
isZero : (Eq a, Num a) -> Bool
isZero a = a == 0
-- implement on a new type "Point"
instance Eq Point where
    Pt x y == Pt u v = x == u && y == v
    Pt x y /= Pt u v = x /= u || y /= v
-- or short
data Point = Pt Float Float deriving (Eq, Ord, Show)
-- "inheritance"
class Eq a => Ord a where
    (<),(>),(<=),(>=):: a -> a -> Bool
    min,max :: a -> a -> a
```

## I/O

- Referential Transparency: you can always substitute a term by its definition without change in the meaning
  - No side effects
- Doesn't work when interacting with the "real" world (I/O)
- Actions with side-effects which return a value of type `a` are represented by IO `a`
- To Sequence `IO` actions, use `do` notation
  - under the hood get translated to nested `>>=`
