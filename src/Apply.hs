{-# LANGUAGE OverloadedStrings #-}
module Apply
    (
        apply
    )
    where

import Evaluate (Expression(..))

apply :: Expression -> Int -> Int
apply (Constant n) _ = n
apply _ _ = 0
