{-# LANGUAGE OverloadedStrings #-}
module Evaluate
    (
        Expression(..),
        Error,
        evaluate
    )
    where

import Text.Read (readMaybe)

import State (Error)

data Expression = CurrentValue
                | Constant Integer
                | Add Expression Expression
                | Subtract Expression Expression
                | Multiply Expression Expression
                | Divide Expression Expression

evaluate :: String -> Either Error Expression
evaluate xs = tokenize xs >>= parse

data Token = TVerb String
           | TConstant Integer

tokenize :: String -> Either Error [Token]
tokenize xs = Right $ map f $ words xs
    where f xs' = case readMaybe xs' :: Maybe Integer of
                    Just i  -> TConstant i
                    Nothing -> TVerb xs'

parse :: [Token] -> Either Error Expression
parse ((TVerb v):xs)               = case parse xs of
                                      e@(Left _) -> e
                                      Right xs'  -> parseVerb v CurrentValue xs'
parse ((TConstant x):(TVerb v):xs) = case parse xs of
                                      e@(Left _) -> e
                                      Right xs'  -> parseVerb v (Constant x) xs'
parse ((TConstant x):[])           = Right $ Constant x
parse []                           = Right CurrentValue
parse _                            = Left "Unknown expression"

parseVerb :: String -> Expression -> Expression -> Either Error Expression
parseVerb v x y | v == "add"      = Right $ Add x y
                | v == "subtract" = Right $ Subtract x y
                | v == "multiply" = Right $ Multiply x y
                | v == "divide"   = Right $ Divide x y
                | otherwise       = Left $ "No such verb " ++ v
