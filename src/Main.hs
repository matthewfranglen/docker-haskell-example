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
readToken = do
    token <- readFile "token"
    return $ lines token !! 0

makeConfig :: String -> SlackConfig
makeConfig token = SlackConfig { _slackApiToken = token }

echoBot :: SlackBot State
echoBot (Message cid _ msg _ _ _) = do
    let expr = evaluate $ T.unpack msg
    num <- userState . value <%= case expr of
                                    Left _  -> \_ -> 0
                                    Right x -> apply x
    let response = T.pack . show $ num
    sendMessage cid response

echoBot _                         = return ()
