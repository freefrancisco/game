{-# LANGUAGE FlexibleInstances #-}

module Types.Action where

import Control.Monad.RWS

import Types.Data

type GameAction = RWST Env Log Game IO ()

execGameAction :: GameAction -> Env -> Game -> IO (Game, Log)
execGameAction = execRWST

instance Semigroup Log where
    (Log a b) <> (Log x y) = Log (a <> x) (b <> y)

instance Monoid Log where
    mempty = Log [] []

instance Semigroup GameAction where
    (<>) = (>>)
    
instance Monoid GameAction where
    mempty = return ()
