{-# LANGUAGE TemplateHaskell #-}
module Types.Data where

import Lens.Micro.Platform
import qualified Data.Map as M

-- Gane types
data Game = Game {
    _score :: !Int
  , _units :: ![Unit]
  , _boss  :: !Unit
} deriving (Show)

data Unit = Unit {
    _health   :: !Int
  , _position :: !Point
} deriving (Show)

data Point = Point {
    _x :: !Double
  , _y :: !Double
} deriving (Show)

-- Log and environment Types

data Log = Log {
    _actions  :: ![String]
  , _comments :: ![String]
} deriving (Show)

data Env = Env {
    _vars :: !(M.Map String String)
} deriving (Show)

makeLenses ''Game
makeLenses ''Unit
makeLenses ''Point
makeLenses ''Log
makeLenses ''Env
