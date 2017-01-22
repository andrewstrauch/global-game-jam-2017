# GGJ2017

## Current Work
- FlareVulca - DISCOVERY: Enemy damage the player, figure out "death"
- JediSange - BUG: Pathfinding goes out of bounds of floor tiles, above and to the left only
- RamielRowe - Track down the light bug
- Zephyrum - Rotate tiles to have up/down/left/right walls

## TODO (Coding)
- Implemment player lose mechanic
- Level design Map 1
- Reduce bullet size
- BUG: Fix gravity of bullet, should behave as a kinematic body (requires removale of impulse and change to have bullet looping in direction)
- Shooting Reload UI

## TODO (Art)
- Level end graphic (Stairs)
- Iterate on wall graphics
- Finishing the tile set
- Finish player graphic? -- confirm with Zeph if still an issue
- Enemy graphics (see enemy types in folder)

## TODO (Music/Sound)
- Enemy sound effect -- breathing (happens as long as enemy is alive)
- Enemy sound effect -- walking (only play if moving, e.g. footsteps)

## Stretch Goals
- Expand on heartbeat to make heartbeat happening at all times
- Rethink fog of war (relates to light bug), can we remove FOW rather than adding white light? art suggestion
- DISCOVERY: Determine if we want traps (and what those would be)

## Collision Channels
- Top left (1) - Colision with tileset
- Bottom Left (1025) - Colision with enemies
