{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module Main
    (
        main
    )
    where

import qualified Data.Text as T (pack, unpack)

import Web.Slack (runBot, SlackBot, Event( Message ), userState )
import Web.Slack.Config
import Web.Slack.Message (sendMessage)

import Evaluate (evaluate)
import Apply (apply)
import State (State(..), value)

import Control.Lens

main :: IO ()
main = do
    token <- readToken
    runBot (makeConfig token) echoBot startState
    where startState = State 0

readToken :: IO String
readToken = head <$> lines <$> readFile "token"

makeConfig :: String -> SlackConfig
makeConfig token = SlackConfig { _slackApiToken = token }

echoBot :: SlackBot State
echoBot (Message cid _ msg _ _ _) = do
    let expr = evaluate $ T.unpack msg
    case expr of
        Left  err   -> sendMessage cid $ T.pack err
        Right expr' -> do
            num <- userState . value <%= apply expr'
            sendMessage cid $ T.pack $ show num

echoBot _                         = return ()
