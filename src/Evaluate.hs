{-# LANGUAGE OverloadedStrings #-}
module Evaluate
    (
        Expression(..),
        evaluate
    )
    where

data Expression = Constant Int
                | Add Expression Expression
                | Subtract Expression Expression
                | Multiply Expression Expression
                | Divide Expression Expression

evaluate :: String -> Expression
evaluate _ = Constant 1
