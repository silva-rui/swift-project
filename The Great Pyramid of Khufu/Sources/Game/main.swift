import Foundation
import InteractiveFictionFramework


class MyGame:Game {
    
    /// A reference to a `Controller` instance
    lazy var controller = Controller(game: self)
    
    /// A reference to a `Parser` instance
    lazy var parser = Parser(controller: self.controller)
    
    /// The flag defined in the `Game` protocol
    var finished = false
    
    /// References to all rooms
    var rooms: [Room]

    /// The current location of the user in the game map
    var currentRoom:Room

    /**
     Creates an array of all the items available in the game
     
     - Returns: An array of items
     */
    var items: [Item]

    lazy var playMissions: Missions = Missions()
    lazy var enc: Encounters = Encounters()
    

    lazy var player:Player = choosePlayer()
    
    /// This initializer sets the room collection, the current room and adds commands to the parser.
    init() {
        self.rooms = MyGame.createMap()
        self.currentRoom = self.rooms.first!
        self.items = MyGame.createItems(rooms: self.rooms)
        self.addCommands()
    }

    /**
     Creates a game map comprising all (initially available) rooms and their connections. Used in the initializer.
     
     - Returns: An array of rooms
     */
    private class func createMap() -> [Room] {

        let entrance = Room(name: "The Entrance")
        let subterraneanChamber = Room(name: "The Subterranean Chamber")
        let queensChamber = Room(name: "The Queens Chamber")
        //let hiddenRoom = Room(name: "The Hidden Room") removed - not initially available
        let grandGallery = Room(name: "The Grand Gallery")
        //let kingsChamber = Room(name: "The Kings Chamber") removed - not initially available
        //let secretRoom = Room(name: "The Secret Room") removed - not initially available

        entrance.exits = [.South: subterraneanChamber, .West: queensChamber]
        subterraneanChamber.exits = [.North: entrance]
        queensChamber.exits = [.East: entrance, .North: grandGallery]//, .West: hiddenRoom]
        //hiddenRoom.exits = [.East: queensChamber]
        grandGallery.exits =  [.South: queensChamber]//, .North: kingsChamber]
        //kingsChamber.exits = [.South: grandGallery]//, .North: secretRoom]
        //secretRoom.exits = [.South: kingsChamber]
        
        return [entrance, subterraneanChamber, queensChamber, grandGallery]
    }
    
    func createHiddenRoom() {   //Called to reveal Hidden Room after defeating Cobra boss

        guard let queensChamber = getRoomByName(name: "The Queens Chamber") else {
            return
        }

        let hiddenRoom = Room(name: "The Hidden Room")
        
        let rope: Rope = Rope(location: hiddenRoom)
        let spear: Spear = Spear(location: hiddenRoom)

        hiddenRoom.exits = [.East: queensChamber]   // EXIT: Hidden Room -> Queens Chamber
        queensChamber.exits[.West] = hiddenRoom     // EXIT: Queens Chamber -> Hidden Room

        self.items.append(contentsOf:[rope, spear])
        self.rooms.append(hiddenRoom)

    }

    func createSecretRoom() {   //Called to reveal Secret Room after defeating Khufu

        guard let kingsChamber = getRoomByName(name: "The Kings Chamber") else {
            return
        }

        let secretRoom = Room(name: "The Secret Room")

        secretRoom.exits = [.South: kingsChamber]  // EXIT: Secret Room -> Kings Chamber
        kingsChamber.exits[.North] = secretRoom      // EXIT: Kings Chamber -> Secret Room

        self.rooms.append(secretRoom)

    }

    func createKingsRoom() {    //Called to reveal King's Room after completing mission on Grand Gallery

        guard let grandGallery = getRoomByName(name: "The Grand Gallery") else {
            return
        }

        let kingsRoom = Room(name: "The Kings Chamber")

        kingsRoom.exits = [.South: grandGallery]  // EXIT: Secret Room -> Kings Chamber
        grandGallery.exits[.North] = kingsRoom      // EXIT: Kings Chamber -> Secret Room

        self.rooms.append(kingsRoom)

    }
  
    func createChest() {    //Upon completing the mission on subterranean Chamber a chest is made accessible to loot its contents

        guard let subterraneanChamber = getRoomByName(name: "The Subterranean Chamber") else {
            return
        }

        let chest:Chest = Chest(location: subterraneanChamber)
        
        self.items.append(chest)
    }

    func createScultpure() {    //Upon defeating Khufu boss, sculpture is revealed and becomes collectable

        guard let kingsChamber = getRoomByName(name: "The Kings Chamber") else {
            return
        }

        let sculpture:Sculpture = Sculpture(location: kingsChamber)
        
        self.items.append(sculpture)
    }

    func getRoomByName(name: String) -> Room? {
        var result:Room? = nil
        for r in self.rooms {
            if(r.name==name) {
                result = r
            }
        }
        return result
    }

    private class func createItems(rooms:[Room]) -> [Item] {
       
       let torch:Torch = Torch(location: rooms[0])
       let map:Map = Map(location: rooms[0])
       //let potion:Potion = Potion(location: rooms[1]) removed - will be available after completing mission
       //let rope:Rope = Rope(location: rooms[2]) removed - room not initially available
       //let sculpture:Sculpture = Sculpture(location: rooms[4]) removed - will be available after winning battle
       let maceax:MaceAx = MaceAx(location: rooms[3])
       //let spear:Spear = Spear(location: rooms[2]) removed - room not initally available
       let khopesh:Khopesh = Khopesh(location: rooms[0])
       //let shield:Shield = Shield(location: rooms[1]) removed - will be available after completing mission
        
        return [torch, map, maceax, khopesh]
    }
    

    
    /// Adds commands mapped to their respective keywords to the controller.
    private func addCommands() {
        self.controller.register(keyword: "help", command: HelpCommand())
        self.controller.register(keyword: "go", command: GoCommand())
        self.controller.register(keyword: "stop", command: StopCommand())
        self.controller.register(keyword: "story", command: StoryCommand())
        self.controller.register(keyword: "look", command: LookCommand())
        self.controller.register(keyword: "collect", command: CollectCommand())
        self.controller.register(keyword: "use", command: UseCommand())
        self.controller.register(keyword: "interact", command: InteractCommand())
        self.controller.register(keyword: "play", command: PlayCommand())
    }

    func findItemByName(pName: String) -> Item? {
        
        var found:Item? = nil

            for i in self.items {
                if (pName.lowercased == i.name.lowercased) {
                    found = i
                }
            }
            
        return found
    }

    /// This would be the place to set the scene by introducing the player to his environment and mission.
    private func intro() {
        print("Welcome to the Great Pyramid of Khufu!\nYou are currently in the largest and most complex Egyptian pyramid ever built.\nIf you are here, then it is because you are probably interested in its mysteries or its precious value.\nBut don't forget the famous legend that whoever once entered here has never come back.\nAre you ready to risk this adventurous journey?\nGood luck and be prepared to confront all its mysterious challenges!\n")
        print("Type 'help' to see available commands.")
        player.info()
    }
    
    private func choosePlayer() -> Player {
        print("Please choose your character [1-3]")
        print("1.Greek historian\n2.Greek archeologist\n3.Tomb Raider")
        
        var player:Player? = nil

        if let choosenPlayer = readLine() {
            if let num = Int(choosenPlayer) {
                switch(num) {
                    case 1:
                        print("OK! Your name is Herodotus and you are a Greek historian.")
                        player = Player(name: "Herodotus", health: 200, damage: 20)
                    case 2:
                        print("OK! Your name is Perseus and you are a Greek archeologist.")
                        player = Player(name: "Perseus", health: 200, damage: 20)
                    case 3:
                        print("OK! Your name is Ramesses and you are a tomb raider.")
                        player = Player(name: "Ramesses", health: 200, damage: 100)
                    default:
                        print("Please choose a number [1-3]")
                }
            }
        }
        return player!
    }

    func calcStars() -> Int {
        // We assume that the player collected all the items
        var collectedEveryObject:Bool = true

        for i in self.items {
            // If the item is not in the bag, the player has not collected everything
            if(!player.bag.contains(item: i)) {
                collectedEveryObject = false
            }
        }
        
        // If the player didn't collect all of objects OR
        // If he didn't solve all the missions
        // Then remove one star
        
        // N.B: We only need to check one of the missions because collecting every possible object
        //      implies that the other two missions were completed. Furthermore, collecting every
        //      possible item also implies that every room was visited
        
        if(!collectedEveryObject || !playMissions.hieroglyphsSolved) {
            player.stars-=1
        }

        return player.stars

    }

    /// Concluding the story.
    private func outro() {
        print("\nThanks for playing! Bye!")
    }
    
    /// Main game loop.
    func play() {
        intro()
        
        while !self.finished {
            enc.start_encounter(room: self.currentRoom) //Verifies if currentRoom has an uncompleted encounter
            print("\n\(self.currentRoom)\n")

            if (enc.wonBattle == true) {
                    
                do {
                    try parser.readCommand()
                } catch ParserError.noInputGiven {
                    print("No input given")
                } catch CommandError.commandNotFound(let keyword) {
                    print("No command found for keyword '\(keyword)'")
                } catch {
                    print("Unexpected error: \(error)")
                }
            }
            if (!player.isAlive()) {
                finished = true
            }
        }
        outro()
    }
    
}

// create and run the game
let g = MyGame()
g.play()
