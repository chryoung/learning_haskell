type Peg = String
type Move = (Peg, Peg)
hanoi :: Integer -> Peg -> Peg -> Peg -> [Move]
-- Given the number of discs and names for the three pegs, hanoi
-- should return a list of moves to be performed to move the stack of
-- discs from the first peg to the second.
hanoi 1 _ _ _       == []
hanoi 2 "a" "b" "c" == [("a", "c"), ("a", "b"), ("c", "b")]
hanoi 2 "a" "c" "b" == [("a", "b"), ("a", "c"), ("b", "c")]
hanoi 2 "b" "a" "c" == [("b", "c"), ("b", "a"), ("c", "a")]
hanoi 2 "b" "c" "a" == [("b", "a"), ("b", "c"), ("a", "c")]
hanoi 2 "b" "c" "a" == [("b", "a"), ("b", "c"), ("a", "c")]
hanoi 2 "c" "a" "b" == [("c", "b"), ("c", "a"), ("b", "a")]
hanoi 2 "c" "b" "a" == [("c", "a"), ("c", "b"), ("a", "b")]
