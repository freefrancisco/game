{-# LANGUAGE Rank2Types, FlexibleContexts #-}
module Util where

import Lens.Micro.Platform
import Control.Monad.RWS

import Types

around :: Point -> Double -> Traversal' Unit Unit
around center radius = filtered $ \ unit ->
    sqDistance (unit^.position) center < radius^2

sqDistance :: Point -> Point -> Double
sqDistance p q = (p^.x - q^.x)^2 + (p^.y - q^.y)^2

partyHP :: Traversal' Game Int
partyHP = units.traverse.health

partyLoc :: Traversal' Game Point
partyLoc = units.traverse.position

-- util functions for logging
logAction :: (MonadIO m, MonadWriter Log m) => String -> m ()
logAction action = do
    liftIO $ putStrLn $ "action: " ++ action
    tell $ mempty & actions.~ [action]
    -- tell $ mempty {_actions = [action]}

comment :: (MonadIO m, MonadWriter Log m) => String -> String -> m ()
comment who blah = do
    let comment = who ++ ": " ++ blah
    liftIO $ putStrLn comment
    tell $ mempty {_comments = [comment]}

chainActions :: [GameAction] -> GameAction
chainActions = mconcat
