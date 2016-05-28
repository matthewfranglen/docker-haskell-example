{-# LANGUAGE OverloadedStrings #-}
module Main
    (
        main
    )
    where

import Web.Slack (runBot, SlackBot, Event( Message ) )
import Web.Slack.Config
import Web.Slack.Message (sendMessage)

main :: IO ()
main = do
    token <- readToken
    runBot (makeConfig token) echoBot ()

readToken :: IO String
readToken = do
    token <- readFile "token"
    return $ lines token !! 0

makeConfig :: String -> SlackConfig
makeConfig token = SlackConfig { _slackApiToken = token }

echoBot :: SlackBot ()
echoBot (Message cid _ msg _ _ _) = sendMessage cid msg
echoBot _                         = return ()
