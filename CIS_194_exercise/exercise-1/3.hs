toDigits :: Integer -> [Integer]
toDigits n
  | n <= 0    = []
  | otherwise = toDigits (n `div` 10) ++ [n `mod` 10]

sumDigits :: [Integer] -> Integer
sumDigits [] = 0
sumDigits (x:[]) = x
sumDigits (x:xs) = sumDigits (toDigits x) + (sumDigits xs)

evenArray = [16, 7, 12, 5]

main = print(sumDigits evenArray)
