toDigitsRev :: Integer -> [Integer]
toDigitsRev n
  | n <= 0    = []
  | otherwise = (n `mod` 10) : toDigitsRev (n `div` 10)

toDigits :: Integer -> [Integer]
toDigits n
  | n <= 0    = []
  | otherwise = toDigits (n `div` 10) ++ [n `mod` 10]
numSeq = toDigits 12345
main = print(numSeq)
