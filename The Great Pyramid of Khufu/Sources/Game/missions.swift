import Foundation
import InteractiveFictionFramework


class Missions {
  
    var chestSolved = false
    var hieroglyphsSolved = false
    var trapsSolved = false
    

  func hieroglyphsPuzzle() {

    let hieroglyphSymbols = ["chick vulture lion lion", "cloth cup chick lion stool loaf chick mouth feather", "sieve chick viper chick", "cloth, feather, cup, mouth, feather, loaf, cloth", "loaf mouth feather vulture cloth chick mouth feather"]
    let hieroglyphs = ["WALL", "SCULPTURE", "KHUFU", "SECRETS", "TREASURE"]
    var count = 1
    var i = 0

    print("""
    Wow! You just found ancient Egyptians hieroglyphs in a wall. The legend says that these are always important to decipher if you are searching for something. 
    Hopefully you are prepared for this adventure and you have your Hieroglyphs alphabet with you. Now it is the time for you to use it!
    These are the following hieroglyphs symbols, each line forms one word:
    """)

        for name in hieroglyphSymbols {
        print(name)
        }
        print("\n")

    while(hieroglyphsSolved == false){
        
        print("Enter the \(count) word of the hieroglyph puzzle: \(hieroglyphSymbols[i])")

        let input = readLine()?.uppercased()

        //Comparing strings
        if(input == hieroglyphs[i]){
        print("Congrats! You solved \(count) word of this mysterious hieroglpyh puzzle.\n")

            //If the 5 words are guessed, then the puzzle is solved
            if(count == hieroglyphs.count){
                hieroglyphsSolved = true 
                print("Congrats! You solved all the mysterious words of this hieroglpyh puzzle! Make sure to remember them during your journey in this Pyramid, they might be useful!\n")
                for name in hieroglyphs {
                    print(name)
                }
            }
        i += 1
        count += 1    
        } else {
           
            print("""
                Oh no, looks like you need to think more to solve the puzzle.
                Do you want to see the alphabet again? Y/N
                
                """)

                print("Select: ", terminator: "")
                if let input = readLine(){

                    switch input {
                        case "N":
                            print("Okay let's continue.")
                            break;

                        case "Y":
                            //possibility to see the alphabet
                            print("There you have: ")
                            g.findItemByName(pName: "Alphabet of Hieroglyphs")!.use()
                            break;

                        default: 
                            print("Invalid answer")
                    }
                }
        }
    }
  }

  func chestPuzzle() {
 
    let firstRow = [96, 192, 384, 768, 1536]
    let secondRow = [32, 48]
    let thirdRow = [4, 8, 6]
    let multiplier = [2, 4, 8, 16, 32]
   
    //var chestSolved = false
    var count = 1
    var i = 0
    var validAnswer = false
    var quitMission = false

    //First part of the puzzle
    print("""
    You just found a chest and your mission is now to open it, if you analyze the chest first you can see there are 3 walls drawn with blurred numbers. 
    Maybe this hint means that you need to find these digits in some rooms of this pyramid. 
    Then you also have a pyramid box, seems like you need to do some maths to figure out the password.
    """)
    print("""
             ___      
           _|___|_
         _|___|___|_  
        |___|___|___|\n
        """)

    print("""
    Do you want to solve the puzzle or leave the mission to explore some walls of the pyramid?
    1.Solve   q.Quit
    """)
    print("Select: ", terminator: "")
            
        while(!validAnswer){
                if let input = readLine(){
                    switch input {
                        case "1":
                           
                        chestSolved = false
                        validAnswer = true

                        case "q":

                        quitMission = true
                        validAnswer = true

                        default: 
                        print("Invalid answer")
                    }
            }
        }

    if(!quitMission){

      while(!chestSolved){

        print("Guess the column \(count) of the third row:")
  
        let passwordInput = Int (readLine()!)

        //If the player guesses a digit then proceed
        if let passwordInput = passwordInput {
            if (thirdRow[i] == passwordInput){
                print("You solved the column \(count) of the third row")

                 if(count == thirdRow.count){
                chestSolved = true
                print("Congrats you solved the third row")
                print("""
                      ___      
                    _|___|_
                  _|___|___|_  
                 |_\(thirdRow[0])_|_\(thirdRow[1])_|_\(thirdRow[2])_|\n
                """)
                } 
                //Creates the chest after completing the puzzle
                g.createChest()


            i += 1
            count += 1   

            }else {
                print("Your answer is wrong, try better")
                }
          
        }
    }

    //Second part of the puzzle
    count = 1
    i = 0
    chestSolved = false

    while(!chestSolved){

        print("Compute the column \(count) of the second row:")
  
        let passwordInput = Int (readLine()!)

        //If the player guesses a digit then proceed
        if let passwordInput = passwordInput {
            if (secondRow[i] == passwordInput){
                print("You solved the column \(count) of the second row")

                 if(count == secondRow.count){
                chestSolved = true
                print("Congrats you solved the second row")
                print("""
                       ___     
                    __|___|__
                  _|_\(secondRow[0])_|_\(secondRow[1])_|_
                  |_4_|_8_|_6_|\n
                """)
                } 
            i += 1
            count += 1   

            }else {
                print("Your answer is wrong, try better")
                }
        }    
    }

    //Third part of the puzzle
    count = 1
     i = 0
     chestSolved = false
     
    print("Now for the final row, you will need to apply the ancient egyptians multiplication method, hopefully you have found any information about it in this pyramid.\n")
    print("Multiplier: \(count) \tResult: \(secondRow[1])")

    while(!chestSolved){
    print("Multiplier: \(multiplier[i]) \tResult:")
        
        let passwordInput = Int (readLine()!)

        //If the player guesses a digit then proceed
        if let passwordInput = passwordInput {
            if (firstRow[i] == passwordInput){
                print("""

                Multiplier: \(multiplier[i]) \tResult: \(firstRow[i])
                """)

                 if(count == firstRow.count){
                chestSolved = true
                print("Congrats you solved the final row which is the password of this chest.")
                print("""
                       ____   
                    __|\(firstRow[i])|_
                  _|_32_|_48_|_
                  |_4_|_8_|_6_|\n
                """)
                }



            i += 1
            count += 1   

            }else {
                print("Your answer is wrong, try better")
                }
        } 
    }
   }
  }

    //Hardest mission
    func traps() {

        let player = g.player 

        let boulderTrap = ["left", "right", "forwards", "backwards"]
        let randomBoulder = boulderTrap.randomElement()!
        var validAnswer = false 
        var death = false

        //First trap
        
        //This print was just for testing purposes
        //print("boulder:  \(randomBoulder)")

        print("""
                       _.-------._
                     ,'           `.
                   ,'               `.
                  /                   \\
                 /                     \\
                (                       )                              
                |                       |
                \\                       /
                 \\                     /
                  `.                 ,'
                    `.             ,'
                      `-._______.-'

        """)

        print("""
        Oh no! You just step into a wire which triggered a boulder to fall down react fast which direction do you want to move to survive!
        
        1. left     2. right    3. forwards     4.backwards
        """)
    
        while(!validAnswer){
            print("Select: ", terminator: "")
        
            if let input = readLine(){
                switch input{
                    case "1":

                        if(randomBoulder == "left"){
                            print("Oh no! The boulder just fell over you. You died") 
                            death = true


                                player.lives -= 1
                                
                                if(player.lives == 0){
                                    print("Game over!")
                                    g.finished = true
                                    
                                } else {
                                    player.health = 200
                                    g.currentRoom = g.rooms.first!
                                    print("You lost one life and you have respawned at the entrance with full health")
                                }  
                            

                        } else {
                            print("It is your lucky day, you just survived from this trap!")
                        }
                        validAnswer = true

                    case "2":
                        if(randomBoulder == "right"){
                            print("Bad luck, you just moved to the same side as the boulder and you died.")
                            death = true


                            player.lives -= 1
                            
                            if(player.lives == 0){
                                print("Game over!")
                                g.finished = true
                                
                            } else {
                                player.health = 200
                                g.currentRoom = g.rooms.first!
                                print("You lost one life and you have respawned at the entrance with full health")
                            }  
                        
                        }else {
                            print("Wow, this one was close congrats you survived!")
                        }
                        validAnswer = true

                    case "3":
                        if(randomBoulder == "forwards"){
                            print("Unfortunately it's not your lucky day today, you just died.")

                            death = true
                            
                            player.lives -= 1
                            
                            if(player.lives == 0){
                                print("Game over!")
                                g.finished = true
                                
                            } else {
                                player.health = 200
                                g.currentRoom = g.rooms.first!
                                print("You lost one life and you have respawned at the entrance with full health")
                            }  
                            
                       
                        }else {
                            print("Congrats you took a good decision and are still alive!")
                        }
                        validAnswer = true

                    case "4":
                        if(randomBoulder == "backwards"){
                            print("Rest in peace.")
                            death = true
                                
                            player.lives -= 1
                            
                            if(player.lives == 0){
                                print("Game over!")
                                g.finished = true
                                
                            } else {
                                player.health = 200
                                g.currentRoom = g.rooms.first!
                                print("You lost one life and you have respawned at the entrance with full health")
                            }                          
                        
                        }else {
                            print("Nice move, you managed to escape from this trap intact!")
                        }
                        validAnswer = true

                    default:
                        print("Invalid choice")  
                }
            }
        }

        //If the player is still alive then proceed to the second trap
         if(!death){
            validAnswer = false
         


            //Second trap
            var count = 1

            /*
            Safe pattern:
            A1 - The only one different from row 1
            B2 - The only one different from row 2
            C3 - The one which covers the most surface of B2.
            */

            print("""

            Careful two different stones of the floor behind you just broke down! 
            This seems like another trap, please choose wisely the next stones you want to step into without dying. 
            They have different shapes this can be meaningful for your decision.  
            
                  A     B     C
                 _______________              
                |   |    |      | 
            3   |   |    |      |            
                |___|____|______|
                |     |   |     |
            2   |     |   |     |
                |_____|___|_____|             
                |     |    |    |
            1   |     |    |    |
                |_____|____|____|

            """)

        //First row trap
        
        while(!validAnswer){
                print("""

                Enter the coordinates of the row \(count).
                Possible coordinates: A1, B1, C1
                """)
                print("Select: ", terminator: "")
            
                if let input = readLine(){
                    switch input{
                        case "A1":
                            
                            print("Congrats! You choosed the safe stone of row \(count).")
                            count += 1   

                            validAnswer = true

                        case "B1":

                            print("Oh no! The stone just brok down and you died")
                            death = true

                            player.lives -= 1
                            
                            if(player.lives == 0){
                                print("Game over!")
                                g.finished = true
                                
                            } else {
                                player.health = 200
                                g.currentRoom = g.rooms.first!
                                print("You lost one life and you have respawned at the entrance with full health")
                            } 
                            validAnswer = true

                        case "C1":

                            print("Oh no! The stone just brok down and you died")
                            death = true

                            player.lives -= 1
                            
                            if(player.lives == 0){
                                print("Game over!")
                                g.finished = true
                                
                            } else {
                                player.health = 200
                                g.currentRoom = g.rooms.first!
                                print("You lost one life and you have respawned at the entrance with full health")
                            } 
                            validAnswer = true 

                        default:
                            print("Invalid choice")

                    }
                }     
        }
            //If the player is still alive theen procced to next row trap
        if(!death){
            validAnswer = false 
             }
        
        //Second row trap
        while(!validAnswer){
                print("""

                Enter the coordinates of the row \(count).
                Possible coordinates: A2, B2, C2
                """)
                print("Select: ", terminator: "")
            
                if let input = readLine(){
                    switch input{
                        case "A2":

                            print("Oh no! The stone just brok down and you died")
                            death = true

                            player.lives -= 1
                            
                            if(player.lives == 0){
                                print("Game over!")
                                g.finished = true
                                
                            } else {
                                player.health = 200
                                g.currentRoom = g.rooms.first!
                                print("You lost one life and you have respawned at the entrance with full health")
                            } 
                            validAnswer = true 

                        case "B2":

                            print("Congrats! You choosed the safe stone of row \(count).")
                            count += 1   

                            validAnswer = true

                        case "C2":

                            print("Oh no! The stone just brok down and you died")
                            death = true

                            player.lives -= 1
                            
                            if(player.lives == 0){
                                print("Game over!")
                                g.finished = true
                                
                            } else {
                                player.health = 200
                                g.currentRoom = g.rooms.first!
                                print("You lost one life and you have respawned at the entrance with full health")
                            } 
                            validAnswer = true 

                        default:
                            print("Invalid choice")

                    }
                }     
        }

        //If the player is still alive theen procced to next row trap
        if(!death){
            validAnswer = false 
        }
        
            //Last row trap
            while(!validAnswer){
                    print("""

                    Enter the coordinates of the row \(count).
                    Possible coordinates: A3, B3, C3
                    """)
                    print("Select: ", terminator: "")
                
                    if let input = readLine(){
                        switch input{
                            case "A3":

                            print("Oh no! The stone just brok down and you died")
                            death = true

                            player.lives -= 1
                            
                            if(player.lives == 0){
                                print("Game over!")
                                g.finished = true
                                
                            } else {
                                player.health = 200
                                g.currentRoom = g.rooms.first!
                                print("You lost one life and you have respawned at the entrance with full health")
                            } 
                            validAnswer = true 

                            case "B3":

                                print("Congrats! You escape final row and survived the stones trap!")
                                count += 1   
                                validAnswer = true
                                trapsSolved = true
                                g.createKingsRoom()

                            case "C3":

                            print("Oh no! The stone just brok down and you died")
                            death = true

                            player.lives -= 1
                            
                            if(player.lives == 0){
                                print("Game over!")
                                g.finished = true
                                
                            } else  { 
                                player.health = 200
                                g.currentRoom = g.rooms.first!
                                print("You lost one life and you have respawned at the entrance with full health")
                            } 
                            validAnswer = true 
                            default:
                                print("Invalid choice")

                        }
                    }     
            }
         }
               
    }
}











