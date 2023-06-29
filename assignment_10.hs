isInt x = x == fromInteger (round x)

pyths :: Int -> [(Int, Int, Int)]
pyths n = map (\(x, y) -> (x, y, x ^ 2 + y ^ 2)) [(x, y) | x <- [1 .. n], y <- [1 .. n], x < y, isInt (sqrt ( fromIntegral ((x ^ 2) + (y ^ 2))))]

factors :: Int -> [Int]
factors n = [x | x <- [1 .. n -1], n `mod` x == 0]

perfects :: Int -> [Int]
perfects n = [x | x <- [2 .. n], sum (factors x) == x]

scalarprod :: [Int] -> [Int] -> Int
scalarprod xs ys = sum (map (\(x, y) -> x * y) (zip xs ys))
