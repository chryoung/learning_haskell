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


parseMessageType :: String -> MessageType
parseMessageType (x:xs) = case x of
                          'I' -> Info
                          'W' -> Warning
                          'E' -> Error $ read $ unwords $ take 1 $ words xs

parseTimeStamp :: String -> TimeStamp
parseTimeStamp (x:xs) = case x of
                        'E' -> read $ unwords $ drop 1 $ take 2 $ words xs -- xs is 2 \"134\" It's time
                        _   -> read $ unwords $ take 1 $ words xs -- xs is \"135\" It's another time

parseLogText :: String -> String
parseLogText (x:xs) = case x of
                      'E' -> unwords $ drop 2 $ words xs
                      _   -> unwords $ drop 1 $ words xs

parseMessage :: String -> LogMessage
parseMessage s = LogMessage (parseMessageType s) (parseTimeStamp s) (parseLogText s)

parse :: String -> [LogMessage]
parse [] = []
parse s = (parseMessage $ unwords $ take 1  $ lines s) : (parse $ unlines $ drop 1 $ lines s)

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
