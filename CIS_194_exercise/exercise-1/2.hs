doubleEveryOther :: [Integer] -> [Integer]
doubleEveryOther []         = []
doubleEveryOther (x:[])     = [x]
doubleEveryOther (x:(y:xs)) = x : 2 * y : doubleEveryOther xs

oddArray = [1, 2, 3, 4, 5]
evenArray = [1, 2, 3, 4, 5, 6]
main = print(doubleEveryOther evenArray)
