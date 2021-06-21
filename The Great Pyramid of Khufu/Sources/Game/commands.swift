import InteractiveFictionFramework

class CollectCommand:Command {

    public func run(game: Game, arguments: [String]) {

        if let myGame = game as? MyGame {

            guard let collectedItem = arguments.first else {
                print("Please indicate the item you would like to collect.")
                return
            }

            guard let item = myGame.findItemByName(pName: collectedItem) else {
                print("The object you mentioned doesn't exist.")
                return
            }

            myGame.player.collectItem(item: item, currentRoom: myGame.currentRoom)

        }
    }
}

class UseCommand:Command {      //Allows player to use items contained in the bag

    public func run(game: Game, arguments: [String]) {

        if let myGame = game as? MyGame {

            guard let useItem = arguments.first else {
                print("Please indicate the item you would like to use")
                return
            }

            guard let item = myGame.findItemByName(pName: useItem) else {
                print("The object you mentioned doesn't exist.")
                return
            }

            myGame.player.useItem(item: item)

        }
    }
}

public class StoryCommand:Command {     //Displays the current room's story
    public init() {}

    public func run(game: Game, arguments: [String]){

        if let mygame = game as? MyGame {
            
             switch mygame.currentRoom.name {                
                case "The Entrance":
                print("""

                    The entrance room is the starting room from your adventure of The Great Pyramid of Khufu. 
                    You should be very cautious from the beginning to the end because remember what the legend states... 
                    Whoever once entered here has never come back. Battles, puzzles but also traps that will lead to your death 
                    can be some of the challenges that you can encounter inside of The Great Pyramid of Khufu

                """)

                case "The Subterranean Chamber":
                print("""

                    The Ancient Egyptians developed an interesting method to multiply numbers.It is an algorithm entitled 
                    Egyptian Multiplication. Usually, they used addition to get the answer to a multiplication problem with the help of 
                    one multiplication table, which is a 2 times table. This table has a multiplier that increases two times for every step 
                    and the result gets doubled by two every time as well till the desired multiplicand.

                """)

                case "The Queens Chamber":
                print("""
                
                    Some of the stories of Khufu claim that he had possibly 2 wives. 
                    Meritites I as his first wife and Henutsen as his second Wife. 
                    The Queen's Meritites I and Queen's Henutsen Pyramids are also located in Giza like the Great Pyramid of Khufu.
                    
                """)

                case "The Hidden Room":
                print("""

                    Egyptian hieroglyphs are the formal writing system of the Ancient Egyptians. 
                    These combine logographic,  syllabic and alphabetic elements with a total of some 1,000 distinct characters. 
                    There are also some signs which look the same but the meaning of it is according to the context and can be interpreted in diverse ways.
                    It also makes it harder to decipher some hieroglyphs but sometimes it can be worth it the time spent to decipher the complete message 
                    to gather relevant information. 
                    
                """)

                case "The Grand Gallery":
                print("""
                
                    This room is very long and the legends state that this is one of the most dangerous rooms to get across without dying. 
                    However, this is the crucial room as well that leads you to The Kings Chamber, so you would need to survive possible 
                    dangerous traps to enter the King's Chamber. Good luck you will need it!
                    
                """)

                case "The Kings Chamber":
                print("""
                
                    Pharaoh's Khufu chamber contains his more precious sculpture made of ivory. 
                    It has a goldish color and it's surprisingly only 7.5cm high x 2.9cm long and 2.6cm deep. 
                    It is a very small sculpture but still a very valuable sculpture honored to Khufu. 
                    The legend states that sculpture is one of the most important items to access a 
                    really valuable room with treasure and secrets revealed.
                
                """)

                case "The Secret Room":
                print("""
                
                    Finally, you entered the secret and most valuable room of The Great Pyramid of Khufu! 
                    There are still so many treasures left, which means no one ever could reach this room to rob it. 
                    But also the secrets of Khufu are still readable from the huge Westcar Papyrus. 
                    Apparently, this Pyramid took about 23 years to be built by workers rather than slaves. 
                    This Pyramid contains 2.3M of blocks and it is the first Pyramid at Giza. 
                    Khufu was a good Pharaoh to his reign, he was a traditional oriental monarch of good-natured, 
                    amiable to his inferiors, and interested in the nature of human existence and magic.
                    
                    Congratulations to be the first one who survived all the challenges of this Pyramid!
                
                """)
                print("You managed to finish the game with \(g.calcStars())/3 stars!")
                g.finished = true
                

                default:
                print("Invalid room")            
            }
        }
    }
}

public class LookCommand:Command {
    public init() {}

    public func run(game: Game, arguments: [String]){

        if let mygame = game as? MyGame {
            
             switch mygame.currentRoom.name {                
                case "The Entrance":
                print("""

                    In this room, there is normally security staff who block people from entering further into the Great Pyramid of Khufu. 
                    They have a small table to place the map of the Pyramid, a torch and their weapons such as the Khopesh.
                    Interestingly you observe one of the walls has the digit 4 engraved into it.

                """)

                case "The Subterranean Chamber":
                print("""

                    The subterranean chamber usually has spiders and snakes within it. It is better to try and kill them as fast as possible. 
                    One of the walls has the number 8 engraved. You also observe a chest that is normally locked, a password is needed to open it. 
                    Maybe it has important items that are important in this adventure

                """)

                case "The Queens Chamber":
                
                print("""
                 
                    The Queens Chamber is guarded by a large Cobra, often thought to be a sign of the Gods protecting the Pharaoh and his Queen.
                    This venomous Cobra is the most feared of the Egyptians. And there is a small digit 6 carved into a wall as well.
                 
                 """)
    

                case "The Hidden Room":
                print("""

                    Looks like the hidden room of The Queens chamber has hieroglyphs in one whole wall perhaps with important messages. 
                    There is normally also a spear and a rope on the floor.    
                
                """)

                case "The Grand Gallery":
                print("""

                    In the Grand Gallery, you notice the great length of this walkway, making your way slowly, you notice how some stones of the floor look different than the rest. 
                    Take precautions in trying to avoid these. You can also find a weapon in this Grand Gallery the mace-ax.
                
                """)

                case "The Kings Chamber":
                print("""

                    You can notice the tomb of Khufu, the legend of the curse of Khufu states that he gets awaken when someone enters his room to defend his treasures. 
                    You can also observe a small statue high on the wall. You must find a way to grab it with the help of an item. 
                    There is a spot in another wall with the same shape as the sculpture, this will surely give you access to Khufu's secret door.
                
                """)
                

                case "The Secret Room":
                print("""

                    You are amazed by what you see this secret room is, surrounded by treasures, you can also find a papyrus scroll on the wall. 
                    This has surely valuable information about his secrets and offers any enlightenment.
                    
                """)

                default:
                print("Invalid room")            
            }
        }
    }
}

public class PlayCommand:Command {
    public init() {}

    public func run(game: Game, arguments: [String]){

        if let mygame = game as? MyGame {

            switch mygame.currentRoom.name {                
                case "The Subterranean Chamber":

                    //Allows the player to play the chest mission once if he completed it already
                    if  !mygame.playMissions.chestSolved  {
                    
                        mygame.playMissions.chestPuzzle()

                     } else {
                         print("You completed the chest mission already!")
                     }

                case "The Hidden Room":
                    
                    //Allows the player to play the hieroglyphs mission once if he completed it already
                     if  !mygame.playMissions.hieroglyphsSolved  {  
             

                        //If the player does not contain a torch he can not play the mission                
                        guard let item = mygame.player.bag.getItemByName(name: "Torch")
                        else {
                            print("You dont have any torch in your bag")
                            return
                        }
                        //Then the player will only be able to play after having his torch turned on.
                        if let t = item as? Torch {
                           if (t.status == true ){
                                mygame.playMissions.hieroglyphsPuzzle()
                            } else if (t.status == false) {
                                print("Oh no its too dark, you better turn on a torch.")
                            }
                        }
                     } else {
                         print("You completed the hieroglyphs mission already!")
                     }
                    
                case "The Grand Gallery":

                    //Allows the player to play the traps mission once if he completed it already
                     if  !mygame.playMissions.trapsSolved  {
                    
                        mygame.playMissions.traps()

                     } else {
                         print("You completed the traps mission already!")
                     }


                default:
                    print("Invalid room") 
            
            } 
        } 
     } 
}        



public class InteractCommand:Command {
    public init() {}

    public func run(game: Game, arguments: [String]){

        if let mygame = game as? MyGame {
            
             switch mygame.currentRoom.name {                
                case "The Entrance":
                print("There is nothing else you can do here.")
                
                case "The Subterranean Chamber":
                print("""
                There's a snake and a spider in this room. Watch out for these little guys they might try to bite you.
                Here's what you could do:
                1. Kill Snake
                2. Kill Spider
                3. Quit
                """)
                mygame.enc.subterranean_Interactions()

                case "The Queens Chamber":
                print("There is nothing else you can do here.")

                case "The Hidden Room":
                print("There is nothing else you can do here.")

                case "The Grand Gallery":
                print("There is nothing else you can do here.")

                case "The Kings Chamber":
                print("There is nothing else you can do here.")

                case "The Secret Room":
                print("There is nothing else you can do here.")

                default:
                print("Invalid room")            
            }
        }
    }
}
