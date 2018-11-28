module Actions where

import Lens.Micro.Platform
import Control.Monad

import Types
import Util

strike :: GameAction
strike = do
    logAction "striking"
    comment "units" "we are striking!"
    boss.health -= 10

fireBreath :: Point -> GameAction
fireBreath target = do
    logAction "fire breathing"
    comment "boss" "you wanna fuck on me?? I breath fire mothafucka!!"
    units.traverse.(around target 1.0).health -= 3

retreat :: GameAction
retreat = do
    logAction "retreating"
    comment "units" "No me gusta! They took our jerbs!!"
    zoom (units.traverse.position) $ do
        x += 10
        y += 10

battle :: GameAction
battle = do
    forM_ ["take that!" , "and that!", "and that!!"] $ \taunt -> do
        comment "units" taunt
        strike

    comment "boss" "you don't learn!"
    fireBreath $ Point 0.5 1.5

    replicateM_ 3 $ do
        comment "units" "GTFO!!"
        retreat
        comment "boss" "Not so fast!"
        zoom (boss.position) $ do
            x += 10
            y += 10
