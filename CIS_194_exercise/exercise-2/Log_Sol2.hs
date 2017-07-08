-- CIS 194 Homework 2

module Log where

import Control.Applicative

data MessageType = Info
                 | Warning
                 | Error Int
  deriving (Show, Eq)

type TimeStamp = Int

data LogMessage = LogMessage MessageType TimeStamp String
                | Unknown String
  deriving (Show, Eq)

data MessageTree = Leaf
                 | Node MessageTree LogMessage MessageTree
  deriving (Show, Eq)

parseMessage :: String -> LogMessage
parseMessage s = let strList = words s
                  in case strList of
                       "I":ts:ltxt       -> LogMessage Info (read ts) (unwords ltxt)
                       "W":ts:ltxt       -> LogMessage Warning (read ts) (unwords ltxt)
                       "E":errno:ts:ltxt -> LogMessage (Error (read errno)) (read ts) (unwords ltxt)
                       ltxt              -> Unknown (unwords ltxt)

parse :: String -> [LogMessage]
parse [] = []
parse s = map parseMessage (lines s)

-- | @testParse p n f@ tests the log file parser @p@ by running it
--   on the first @n@ lines of file @f@.
testParse :: (String -> [LogMessage])
          -> Int
          -> FilePath
          -> IO [LogMessage]
testParse parse n file = take n . parse <$> readFile file

-- | @testWhatWentWrong p w f@ tests the log file parser @p@ and
--   warning message extractor @w@ by running them on the log file
--   @f@.
testWhatWentWrong :: (String -> [LogMessage])
                  -> ([LogMessage] -> [String])
                  -> FilePath
                  -> IO [String]
testWhatWentWrong parse whatWentWrong file
  = whatWentWrong . parse <$> readFile file

insert :: LogMessage -> MessageTree -> MessageTree
insert logm@LogMessage{} Leaf = Node Leaf logm Leaf
insert newLogm@(LogMessage _ ts _) (Node left oldLogm@(LogMessage _ oldTs _) right)
  | ts < oldTs = Node (insert newLogm left) oldLogm right
  | otherwise = Node left oldLogm (insert newLogm right)
insert _ mtree = mtree

build :: [LogMessage] -> MessageTree
build [] = Leaf
build (x:xs) = insert x (build xs)

inOrder :: MessageTree -> [LogMessage]
inOrder Leaf = []
inOrder (Node left logm right) = inOrder left ++ [logm] ++ inOrder right

whatWentWrong :: [LogMessage] -> [String]
whatWentWrong ((LogMessage (Error errno) ts logm):xs)
  | errno > 50 = [logm] ++ whatWentWrong xs
  | otherwise = [] ++ whatWentWrong xs
whatWentWrong (_:xs) = whatWentWrong xs
whatWentWrong [] = []
