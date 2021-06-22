# Readme
This file contains information about the game The Great Pyramid of Khufu.

# Build Instructions
No Third-Party API's were used.

# Known bugs & issues
There were some issues as of the initial submission:

1. [FIXED]: Inability to collect item **Khufu's Sculpture**, because it contains a space (c.f detailed explanation)
* Name changed to **Sculpture**

>**Detailed explanation**: Throughout the game the player has to collect items using the command: `collect <item>`. However one of our items which is crucial to get to the end has a space in it (Khufu's Sculpture) and because the Parser class (InteractiveFictionFramework) splits the input command into different tokens, it's impossible to get that item. The game expects you to type `collect Khufu's Sculpture` but since the Parser class is using the space character as a separator, it's not possible to get that item because it will result in `collect Khufu's` which doesn't correspond to the correct name. In our offline version, we changed the name to Sculpture to make it less confusing. Are we allowed to push that small fix, or at least use it in our live demo?

2. [FIXED]: Location of item **Khufu's Scultpure** differed from project description
* Location changed from **The Grand Gallery** to **The King's Room** to match project description

3. [FIXED]: No effect after item **Rope** getting caught in one of the cavities
* Rope is now removed from bag
* The game ends

As of the second submission (22/06/2021) there are no major bugs known

# Changes from initial Description

# Players stats: 
None of the players have defense stats neither good or bad vision

1. Herodotus and Perseus:
* Health : 200
* Damage : 20

Easy mode with the strongest player:

2. Ramesses:
* Health : 200
* Damage : 100


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
2. Khufu's sculpture was renamed to Sculpture

# Weapons
1. Shield was not implemented as a weapon.

# Puzzles/Missions
1. Chest puzzle

* The mission is more complex, the player needs to find the first 3 digits of the wall
  but then he needs to solve an ancient egypt method of maths with a multiplication 
  in form of a pyramid box.

2. Traps puzzle

* The first trap will not depend on the players vision since they don't have this stats. 
  And he will not need any rope to survive this misison.
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
* 3 stars is achieved with the following conditions: 
   - Game completed with 3 lives 
   - Every room discovered  
   - Every items collected  
   - Every mission commpleted

# Bonus features / Easter eggs
* We did some ascii art 
* Provided an hieroglyphs alphabet picture this can be used during the game for better visibility of the symbols
* Provided a UML diagram to visualise our object-oriented class design
* This game is based on the history of King Khufu and its pyramid during the Ancient Egypt but also about some general culture of the ancient egyptians.
  A great amount of researches were done to have enough knowledge to create the whole story as close as possible to the reality just with a few other inspirations.

# Automatic Game Mode
Not implemented

# Documentation with jazzy
Not implemented
we tried to use Jazzy to generate a documentation based on the comments.
Since none of us was working under MacOS and we didn't manage to install it on
Linux, we have just added comments to the code.
