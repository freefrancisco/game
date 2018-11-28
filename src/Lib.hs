module Lib
    ( playGame
    ) where

import Lens.Micro.Platform

import Types
import Actions
import Util
import Game

playGame :: IO ()
playGame = do
    putStrLn "RUNNING A GAME!!"
    putStrLn "\nCOMMAND LINE OUTPUT:"
    (game, log) <- runGame $ chainActions [battle, battle, battle]
    putStrLn "\nACTION LOG:"
    log^.actions & unlines & putStrLn
    putStrLn "\nCOMMENT LOG:"
    log^.comments & unlines & putStrLn
    putStrLn "\nINITIAL GAME STATE:"
    print initialState
    putStrLn "\nFINAL GAME STATE:"
    print game
