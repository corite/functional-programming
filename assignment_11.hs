-- 11.2

fibs :: [Int]
fibs = [0,1] ++ zipWith (+) fibs (tail fibs)

-- 11.3

take 3 fibs
takeWhile (\x -> x <= 100) fibs

-- 11.4

take :: Int -> [a] -> [a]
take 0 _ = []
take n (h:t) = h : (take (n-1) t)

sieve :: [Int] -> [Int]
sieve (p:xs) = p : sieve [x | x <- xs, mod x p /= 0]

primes :: [Int]
primes = sieve [2..]

take 3 primes
take 3 (2:..)
2 : take 2 (3:..)
2 : 3 : take 1 (5:..)
2 : 3 : 5 : take 0 _
2 : 3 : 5 : []
[2;3;5]