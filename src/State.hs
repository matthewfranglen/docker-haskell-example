{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
module State
    (
        State(..),
        Error,
        value
    )
    where

import Control.Lens

type Error = String

data State = State {
        _value :: Integer
    }

makeLenses ''State
