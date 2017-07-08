toDigitsRev :: Integer -> [Integer]
toDigitsRev n
  | n <= 0    = []
  | otherwise = (mod n 10) : toDigitsRev (div n 10)

toDigits :: Integer -> [Integer]
toDigits n
  | n <= 0    = []
  | otherwise = toDigits (div n 10) ++ [mod n 10]

doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther []         = []
doubleEveryOther (x:[])     = [x]
doubleEveryOther (x:(y:xs)) = x : 2 * y : doubleEveryOther xs

sumDigits :: [Integer] -> Integer
sumDigits []     = 0
sumDigits (x:[]) = x
sumDigits (x:xs) = sumDigits (toDigits x) + (sumDigits xs)

validate :: Integer -> Bool
validate n
  | mod (sumDigits (doubleEveryOther (toDigitsRev n))) 10 == 0 = True
  | otherwise                                                  = False

-- 4012888888881881 is True
main = print(validate 4012888888881882) --False
