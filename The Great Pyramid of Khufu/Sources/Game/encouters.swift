import Foundation
import InteractiveFictionFramework

class Encounters {

    //All encounters that should auto-start as soon as the player enters the room
    var entrance_encounter = false      
    var queensChamber_encounter = false 
    var kingsChamber_encounter = false
    var subterraneanChamber_encounter = false

    //Initializes every Boss with predefined stats
    let security = Boss(name: "Security guard", health: 100, damage: 20)
    let cobra = Boss(name: "Cobra", health: 500, damage: 50)
    let khufu = Boss(name: "Khufu", health: 800, damage: 80)

    //Initializes every lesser enemy
    let snake = Snake()
    let spider = Spider()

    //Initializes weapon damage that will be chosen later by player
    var weaponChosen_damage: Int = 0  
    var hasShield: Bool = false

    //Initializes currentBoss to a generic Boss that is then replace by another boss depending on the room
    var currentBoss: Boss = Boss(name: "generic", health: 1000, damage: 100)

    //'p' acts as a "shortcut" simply to avoid writing too
    let p = g.player    

    //True if player has won the current battle (part of the respawn system)
    //If player loses battle he respawns at entrance and this var prevents the player from being asked for a command in this case
    var wonBattle = true


    //-----[ Encounters ]-----
    /*
        Once an encouter is completed the player can freely enter a room without
        being prompted to fight again.
        Depending on the room, code will verify if there is an uncompleted event.
    */
        

    func start_encounter(room: Room) {

        //----- [ Start Entrance Encounter ]-----
        if (room.name == "The Entrance" && entrance_encounter == false) {
            currentBoss = security
            wonBattle = false

            //Displays story mesages and dialogue related to this room
            print("""
            
            Encounter with security staff at Entrance
            As you get into the entrance you notice a couple guards blocking your way.
            \(p.name): If I want to go any further, I'll need to knock these guys out
            """)

            while (entrance_encounter == false) {
                
                FightOrFlee()
            }

            //Resets encounter status to false and restores boss health upon failed encounter
            if (wonBattle == false) {
                currentBoss.health = 100
                entrance_encounter = false
            }

        //----- [ Start Queen's Chamber Encounter ]-----
        } else if (room.name == "The Queens Chamber" && queensChamber_encounter == false) {
            currentBoss = cobra
            wonBattle = false

            //Displays story mesages and dialogue related to this room
            print("""
            
            Encounter with Cobra at Queens Chamber
            As soon as you enter the room, you hear a loud hissing.\nA ferocious cobra rises from its nest and you are shocked with its enormous size as the cobra slithers torwards you.
            \(p.name): Wha..What? How can it be so big? Oh no, it is coming...
            The Cobra tries to strike you but you move away on time. It hit its head against the wall and boulders are now blocking the way back.
            """)
            

            while (queensChamber_encounter == false) {

                FightOrFlee()
            }

            //Resets encounter status to false and restores boss health upon failed encounter
            if (wonBattle == false) {
                currentBoss.health = 500
                queensChamber_encounter = false

            }else {
                //Displays story messages upon successful encounter
                print("""
                With a lot of effort you remove a few smaller boulders from the passage.
                \(p.name): Alright, now I can go back if I need to.
                A rumbling sound comes from the other end of the room. A passage has just been revealed.
                \(p.name): Curious.. where could that lead to?
                """)
                
            }
            if (p.isAlive()) {
            wonBattle = true
        }

        //----- [ Start King's Chamber Encounter ]-----
        } else if (room.name == "The Kings Chamber" && kingsChamber_encounter == false) {
            currentBoss = khufu
            wonBattle = false

            //Displays story mesages and dialogue related to this room
            print("""
            Encounter with Khufu at Kings Chamber
            Entering a big room, you activate a trap that quickly closes the passage behind you.
            Angry noises come from all the other end of the room. All this commotion seems to have awaken a creature.
            Once the creature gets closer, you finally realize...
            \(p.name): IT'S KHUFU!! Thi...this can't be. He's alive!!
            Khufu isn't pleased with your presence and charges at you.
            """)

            while (kingsChamber_encounter == false) {
                    
                FightOrFlee()
            }

            //Resets encounter status to false and restores boss health upon failed encounter
            if (wonBattle == false) {
                currentBoss.health = 800
                kingsChamber_encounter = false
            }else {
                //Displays story messages upon successful encounter
                print("""
                
                You circle around the room, looking for a way out when suddenly...
                The passage leading back starts to open.
                \(p.name): Oh good, I can go back now...
                """)
                
            }
            if (p.isAlive()) {
            wonBattle = true
            }
            
        } else if (room.name == "The Subterranean Chamber" && subterraneanChamber_encounter == false) {
            
            //Both are alive
            if (snake.isAlive() && spider.isAlive()) {
                let rand_creature = Int.random(in: 0..<2)
                switch rand_creature {
                case 0:
                    print("""
                    \(p.name): Ouchh!!
                    A spider just attacked you as you entered the room.
                    """)
                    p.getsAttacked(damage: spider.damage)

                case 1:
                    print("""
                    \(p.name): Ouchh!!
                    A snake just attacked you as you entered the room.
                    """)
                    p.getsAttacked(damage: snake.damage)
                    
                default:
                    break
                }
                
            }else if (snake.isAlive() && (spider.isAlive() == false)) { //snake is alive and spider is dead
                print("""
                    \(p.name): Ouchh!!
                    A snake just attacked you as you entered the room.
                    """)
                p.getsAttacked(damage: snake.damage)
            }else if ((snake.isAlive() == false) && spider.isAlive()) { //spider is alive and snake is dead
                print("""
                \(p.name): Ouchh!!
                A spider just attacked you as you entered the room.
                """)
                p.getsAttacked(damage: spider.damage)
            }else { //Both are dead
                
            }
        }

    }


    func chooseWeapon() {   //This function allows the player to choose a weapon to fight the boss
        /*
            The objects on array 'items' within the bag are kept as type 'Item'. This
            next bit of code is a downcast that allows us to access the variables of 
            the subclass of an item everytime said item has a subclass of type 'Weapon'.
            This way we can filter which of the items in the bag interests us.
        */

        var weapons_available : [Weapon]
        weapons_available = []
        for i in p.bag.items {       //Goes through all the items in player's bag and filters every weapon available
            if let w = i as? Weapon {   
                weapons_available.append(w)
            }
        }

        if weapons_available.count == 0  {  //If player has no weapons
            print("\(p.name): Dammit, I have no weapons! This will be a hard fight.")
            weaponChosen_damage = p.damage
        }else {     //If player has at least one weapon
            print("You must choose a weapon if you don't want to die. These are the ones you have:")
        
            var n = 0
            for i in weapons_available {
                print("[\(n)]: \(i.name) | Damage: \(i.damage)")
                n+=1
            }

            print("Your choice: ", terminator:"")
            var weaponChoice_valid = false

            while(!weaponChoice_valid){     //Repeats until it gets a valid choice of weapon
                let weaponChoice = readLine()
                let temp = Int(weaponChoice!) ?? 999   //If input is not a number it will be converted to 999
                
                if temp >= 0 && temp < weapons_available.count {
                    weaponChosen_damage = weapons_available[temp].damage
                    weaponChoice_valid = true
                    print("\nYou have now equipped the \(weapons_available[temp].name)")
                    
                }else {
                    print("You must enter a valid choice! Your choice: ", terminator: "")
                }

            }
        }
    }

    //This function gives player a variaty of options he can select when attacking
    func player_Attack() {
        print("How will you attack?")
        print("\n1. Light Attack\n2. Medium Attack\n3. Heavy Attack\n4. Charge\n5. Change Weapon")
        print("Your choice: ", terminator:"")

        var attack_valid = false

        while (!attack_valid) {
            
            let attack_chance = Int.random(in: 0..<101) //Determines if player is able to strike successfully
            
            let attack = readLine()
            print("\n")
            
            switch attack {
            
            ///Light Attack -100% chance of dealing 100% of weapon/fist damage
            case "1":
                print("Light Attack!")
                print("You perform a fast attack inflicting \(weaponChosen_damage) damage on \(currentBoss.name)!")
                currentBoss.getsAttacked(damage: weaponChosen_damage)

                attack_valid = true

            ///Medium Attack -75% chance of dealing 150% of weapon/fist damage
            case "2":
                print("Medium Attack!")
                if (attack_chance <= 75) {
                    print("You perform an attack inflicting \(Double(weaponChosen_damage) * 1.5) damage on \(currentBoss.name)!")
                    currentBoss.getsAttacked(damage: Int(Double(weaponChosen_damage)*1.5))
                }else {
                    print("\(currentBoss.name) managed to avoid your attack.")
                }

                attack_valid = true

            ///Heavy Attack -30% chance of dealing 250% of weapon/fist damage
            case "3":
                print("Heavy Attack!")
                if (attack_chance <= 30) {
                    print("You perform a slow but strong attack inflicting \(Double(weaponChosen_damage) * 2.5) damage on \(currentBoss.name)!")
                    currentBoss.getsAttacked(damage: Int(Double(weaponChosen_damage)*2.5))
                }else {
                    print("You were too slow. \(currentBoss.name) evaded your strong attack.")
                }
                
                attack_valid = true

            ///Charge Attack -15% chance of dealing 500% of weapon/fist damage
            ///Additionnaly player loses health on failure making this a risky option with high reward
            case "4":
                print("Charge Attack!")
                if (attack_chance <= 15) {
                    print("You charge torwards \(currentBoss.name) inflicting \(weaponChosen_damage * 5) damage!")
                    currentBoss.getsAttacked(damage: weaponChosen_damage*5)
                }else {
                    print("\(currentBoss.name) easily avoids your attack and you crash against the wall.")
                    p.health = p.health - 20
                }
                
                attack_valid = true

            case "5":
                chooseWeapon()
                attack_valid = true
                
            default:
                print("You must enter a valid choice! Your choice: ", terminator: "")
            }
        }

    }


    func boss_counterAttack() {     //Details the counter attack of the current boss you are fighting
        
        for i in p.bag.items {    //Determines if player has shield
            let s = i as? Shield
            if s != nil {   
                hasShield = true
            }
        }
        
        print("\n\(currentBoss.name) is about to attack you! What are you going to do?")

        print("\n1. Dodge\n2. Block\n")
        print("Your choice: ", terminator:"")
        
        var defenseChoice_valid = false

        while(!defenseChoice_valid){     //Repeats until it gets a valid choice of weapon
            let defense_chance = Int.random(in: 0..<101) //Determines if player is able to dodge or block efficiently
            let defenseChoice = readLine()
            switch defenseChoice {

            //Like the attack function successful defense is also rng based
            ///Dodge - 50% chance of avoiding 100% of enemy damage -- On failure: enemy hits but incoming damage is reduced 50%
            case "1":
                if (defense_chance < 50) {
                    print("You managed to completely avoid the attack!")
                    if (p.health < 200 && (p.health + 15) > 200) {
                        p.health = 200
                        print("Health fully restored")
                        
                    }else if (p.health < 200){
                        p.health = p.health + 15
                        print("Small amount of health restored")
                        
                    }

                }else {
                    print("You dodged a bit late and \(currentBoss.name) managed to hit you lightly")
                    print("\(currentBoss.name) deals \(Int(Double(currentBoss.damage)*0.5)) damage")
                    p.health = p.health - Int(Double(currentBoss.damage)*0.5)
                }
                
                defenseChoice_valid = true

            ///Block - 75% chance of avoiding 100% of enemy damage if player has shield -- On failure: enemy hits but incoming damage is reduced 80%
            ///Additionnaly if player has no shield: 60% chance of blocking 20% of incoming damage -- On failure: enemy damage is 100%
            case "2":
                if (hasShield == true) {    //If player has shield
                    if (defense_chance < 75) {
                        print("You block the attack almost completely!")
                        print("\(currentBoss.name) deals \(Int(Double(currentBoss.damage)*0.2)) damage")
                        p.health = p.health - Int(Double(currentBoss.damage)*0.2)

                    }else {     //If player does not have shield
                        print("The block was not very efficient and \(currentBoss.name) still managed to hurt you a little!")
                        print("\(currentBoss.name) deals \(Int(Double(currentBoss.damage)*0.4)) damage")
                        p.health = p.health - Int(Double(currentBoss.damage)*0.4)
                        
                    }
                }else {
                    if (defense_chance < 60) {
                        print("You try to block the attack but \(currentBoss.name) is too strong. You only weaken the attack by a small amount")
                        print("\(currentBoss.name) deals \(Int(Double(currentBoss.damage)*0.8)) damage")
                        p.health = p.health - Int(Double(currentBoss.damage)*0.8)
                        
                    }else {
                        print("\(currentBoss.name) hit you really hard. If only you had a shield to protect yourself.")
                        print("\(currentBoss.name) deals \(currentBoss.damage) damage")
                        p.health = p.health - currentBoss.damage
                        
                    }
                }

                defenseChoice_valid = true
                
            default:
                print("You must enter a valid choice! Your choice: ", terminator: "")
            }

        }

    }

    func lifeCheck() -> Bool {          //Verifies if both player and boss are still alive
        if (currentBoss.health <= 0) {  //If Boss dies
            print("\n\(currentBoss.name) has died! You have won this Battle")
            wonBattle = true
            //Using the `Equatable` protocol we define a function to compare the Bosses
            if (currentBoss == cobra) {
                //Creates Hidden Room if the boss killed is the Cobra
                g.createHiddenRoom()    
            }else if (currentBoss == khufu) {
                //Creates Sculpture if the boss killed is Khufu
                g.createScultpure()     
            }
            return false
        }else if (p.health <= 0) {  //If player dies
            print("\nYOU DIED!! \(currentBoss.name) has managed to kill you!")
            if (p.lives > 0) {
                p.lives = p.lives - 1   //Number of player's lives reduced by 1
                if (p.lives > 0) {  //If player has any lives left
                    p.health = 200  //Player health fully restored
                    g.currentRoom = g.rooms.first!  //Respawns player at entrance
                    print("You have respawned at the entrance with full health")
                }

                
            }
            return false
        }else {
            return true
        }
    }

    func FightOrFlee() {
        
        print("\n1. Fight\n2. Run Away\n")     //player is given two options (Fight or flee)
        print("Your choice: ", terminator:"")

        var choice_valid = false

        while(!choice_valid){     //Asks for input until a valid option is chosen
            let choice = readLine()

            switch choice {

        //--------------------------------
        //-----[ Choice to Fight ]--------
        //--------------------------------
            case "1":
                print("\nYou will fight!")

                chooseWeapon()  //Prompts player to select a weapon if he has any
                while (p.health > 0 && currentBoss.health > 0) {   //Fight keeps going until either player or boss dies
                    //Player's turn to attack
                    player_Attack()

                    //If either boss or player are dead then end encounter
                    var check = lifeCheck()
                    if check == false {  
                        break
                    }

                    //Displays current values of player and current Boss health
                    print("\nYour health: \(p.health)")
                    print("\(currentBoss.name)'s health: \(currentBoss.health)\n")

                    //Boss Counter Attack Section
                    boss_counterAttack()

                    //If either boss or player are dead then end encounter
                    check = lifeCheck()
                    if check == false {  
                        break
                    }
                    
                    //Displays current values of player and current Boss health
                    print("\nYour health: \(p.health)")
                    print("\(currentBoss.name)'s health: \(currentBoss.health)\n")
                    
                    choice_valid = true

                }
                //Once either the player or boss dies the loop breaks and the encounter is defined as complete
                //However since we want the encounter to replay if the player dies we update this further down the start_encounter function
                if (currentBoss == khufu) {
                    kingsChamber_encounter = true
                }else if (currentBoss == cobra) {
                    queensChamber_encounter = true
                }else if (currentBoss == security) {
                    entrance_encounter = true
                }

        //--------------------------------
        //-----[ Choice to Run Away ]-----
        //--------------------------------
            //Depending on the Boss different 'RunAway' messages are displayed
            case "2":
                if (currentBoss == khufu || currentBoss == cobra) {
                    print("You rush to the door!")
                }else if (currentBoss == security) {
                    print("You start walking away but...")
                    
                }
                
                let door_message = Int.random(in: 0..<3)
                switch door_message {
                case 0:
                    if (currentBoss == khufu || currentBoss == cobra) {
                        print("Your efforts are in vain, the passage is blocked.")   
                    }else if (currentBoss == security) {
                        print("\(p.name): NO!! I didn't come all this way to quit so soon!")
                    
                    }
                    
                case 1:
                    if (currentBoss == khufu || currentBoss == cobra) {
                        print("There's nothing you can do to open the passage. Fighting is the only option.")
                    }else if (currentBoss == security) {
                        print("\(p.name): I have to get inside no matter what. I can do this!!")
                    
                    }
                    
                case 2:
                    if (currentBoss == khufu || currentBoss == cobra) {
                        print("You are trapped here. The passage is blocked")
                    }else if (currentBoss == security) {
                        print("\(p.name): I refuse to go away! I'll get inside and uncover every secret!")
                    
                    }
                    
                default:
                    break
                }

            default:
                print("You must enter a valid choice! Your choice: ", terminator: "")
            }
            choice_valid = true

        }
    }

    func PrintExits() {
        print("\n\(g.currentRoom)\n")
        
    }


    //Function used within look when player is in the Subterranean Chamber
    func subterranean_Interactions() {
        print("Your choice: ", terminator:"")

        var interaction_valid = false

        while(!interaction_valid){     //Asks for input until a valid option is chosen
            let choice = readLine()
            switch choice {
            //You choose to kill snake
            case "1":
            if (snake.isAlive()) {
                print("You have crushed the snake with a rock.")
                snake.health = 0
            }else {
                print("Why do you kept hitting it!? The poor snake is already smashed to pieces")
                
            }
            interaction_valid = true

            //You choose to kill spider
            case "2":
            if (spider.isAlive()) {
                print("You have crushed the snake with a rock.")
                spider.health = 0
            }else {
                print("Why do you kept hitting it!? The poor snake is already smashed to pieces")
                
            }
            interaction_valid = true

            //You choose to quit options
            case "3":
                
                interaction_valid = true

            default:
                print("You must enter a valid choice! Your choice: ", terminator: "")
            }
        }
    }
}