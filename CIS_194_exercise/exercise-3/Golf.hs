module Golf where

everySecondElement :: [a] -> [a]
everySecondElement [] = []
everySecondElement [x] = [] -- Only one left, return nothing
everySecondElement (x:y:rest) = [y] ++ everySecondElement rest -- or take the se
                                                               -- cond element r
                                                               -- ecursively

splitIntoSingle :: [a] -> [[a]]
splitIntoSingle [] = []
splitIntoSingle [x] = [[x]] -- the edge situation
splitIntoSingle (x:xs) = [[x]] ++ splitIntoSingle xs -- make an element a list

skips :: [a] -> [[a]]
skips [] = []
skips [x] = [[x]]
skips l = [l] ++ [everySecondElement l] ++ (splitIntoSingle $ drop 2 l)

localMaxima :: [Integer] -> [Integer]
localMaxima [] = []
localMaxima [x] = []
localMaxima (x:y:[]) = []
localMaxima (x:y:z:rest)
  | y > x && y > z = [y] ++ (localMaxima (z:rest))
  | otherwise      = localMaxima (y:z:rest)

histogram :: [Integer] -> String
