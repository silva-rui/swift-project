# Readme
This file contains information about the game The Great Pyramid of Khufu.

# Build Instructions
No Third-Party API's were used.

# Changes from initial Description

# Players stats: 
All the players have same stats and they do not have any defense stats neither good or bad vision
* Health : 200
* Damage : 20


# Common enemies
1. Only 1 spider 
   * Damage: 10
2. Only 1 snake 
   * Damage: 10 

Both are located in the Subterranean Chamber


# Rooms
Changed the names of the rooms to:
1. The Entrance
2. The Subterranean Chamber 
3. The Queens Chamber  
4. The Hidden Room 
5. The Grand Gallery 
6. The Kings Chamber 
7. The Secret Room 

Some of these roooms such as 
1. The Hidden Room 
2. The Secret Room 

Are visible only after defeating a boss.

3. The Kings Chamber

Is only visible after completing the traps mission.

# Items
1. Shield was implemented as an item.

# Weapons
1. Shield was not implemented as a weapon.

# Puzzles/Missions
1. Chest puzzle

* The mission is more complex, the player needs to find the first 3 digits of the wall
  but then he needs to solve an ancient egypt method of maths with a multiplication 
  in form of a pyramid box.

2. Traps puzzle

* The first trap will not depend on the players vision since they don't have this stats.
  The player will need to select wheter he wants to move right, left, backwards, forwards
  when the first trap is triggered since the boulder will fall randomly in one of these directons.

3. In general the player will only be able to play the mission once after he completed it.


# Interactions
The interactions are used as commmands the following commands were added:

1. use (It uses an item)
2. story (It prints a story)
3. look (It describes the rooms)
4. play (It allows to play the misisons)
5. interact (It allows to interact in one battle)
6. collect (It collects an item and weapons)

# Bosses battles
1. Security:
  * Health: 100
  * Damage:20

2. Cobra:
  * Health: 500
  * Damage:50

3. Khufu:
  * Health: 800
  * Damage:80

# Point systems
* 3 stars: Game completed with 3 lifes + all the rooms were discovered 
  + all the items were collected + all the missions were commpleted

# Bonus features / Easter eggs
* We did some ascii art and uploaded an hieroglyphs picture that can also be used 
 during the game for better visibility.

# Automatic Game Mode
Not implemented

# Documentation with jazzy
Not implemented
we tried to use Jazzy to generate a documentation based on the comments.
Since none of us was working under MacOS and we didn't manage to install it on
 Linux, we have just added comments to the code.