import InteractiveFictionFramework

class Item:Equatable, CustomStringConvertible {
    
    // Particular room for objects that don't have a specific location
    static let common:Room = Room(name: "common")
    // Room where the item is located
    var location:Room
    // Name of the item
    var name:String

    init(location:Room, name:String) {
        self.location = location
        self.name = name
    }
    
    var description: String { 
        return "Name: \(self.name) | Location: \(self.location)"
    }

    func use() {
    
    }
    
    // Textual information output
    func printInfo() {
        print("[*] \(self.name)")
    }

    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name && lhs.location == rhs.location
    }
    
}

class Torch:Item {
    
    // Variable representing the status of the attribute (on = true | off = false)
    private(set) var status = false

    init(location:Room) {
        super.init(location: location, name: "Torch")
    }

    override func use() {
        
        //Inverts the status (on -> off | off -> on)
        self.status = !self.status
        
        if(self.status == true) {
            print("You lit up the torch!\n")
            
        }
        else {
            print("You shut off the torch!\n")
        }

    }

    override func printInfo() {
        super.printInfo()
        print("Status: \(self.status)")
    }
    
}

class Potion:Item {

    // Variable to keep track of the item's usage
    private(set) var used:Bool

    init(location:Room) {
        self.used = false
        super.init(location: location, name: "Potion")
    }
    
    // Gives the player one extra life
    override func use() {
        
        // Allows player to only use the item once
        if(!used) {
            g.player.lives+=1
            print("You just used a potion, which contained one extra life!")
            used = true
        }
        else {
            print("The bottle is empty. You can't have more of that potion!")
        }
    }

    override func printInfo() {
        super.printInfo()
        print("Used: \(self.used)")
    }

}

class Map:Item {

    init(location:Room) {
        super.init(location: location, name: "Map")
    }
    
    // Outputs a textual representation of the map
    override func use() {
        
        // Map without hidden rooms, the hidden rooms the player will need to remember their positions as he finds them
        print("""

                        _________________ 
                       |                 |
                       |    The Kings    |_________________
                       |     Chamber                       |
                       |                  __________       |
                       |_________________|         |  The  |
                                                   |       |
                                                   |       |
                                                   | Grand |
                                                   |       |
                                    _______________|       |
                                    |        Gallery       |
                                    |      ________________|
                                    |      |
                              ______|      |_____       ____________________
                              |                  |     |                    |
                              |     The Queens   |_____|         The        |
                              |                   _____                     |
                              |     Chamber      |     |      Entrance      |__
                              |__________________|     |                     __
                                                       |____   _____________| 
                                                           |   |
                                                           |   |
                                                           |   |
                                                           |   |
                                                          /   /
                                       __________________/   /___ 
                                      |                          |                   
                                      |           The            |
                                      |       Subterranean       |
                                      |          Chamber         |
                                      |__________________________|
                                                        
        """)
    
    }
    
}

class Rope:Item {

    init(location:Room) {
        super.init(location: location, name: "Rope")
    }
    
    // Throws the rope to get the Khufu's Sculpture
    override func use() {
        
        // Chooses a random number in the [0-10] interval
        let throwChance = Int.random(in: 0..<11)

        // Produces different behaviours depending on the randomized number
        switch(throwChance) {
            case 0..<5:
                print("You threw the rope but with too little strength to reach the sculpture.. Try again!")
            case 5..<10:
                print("You looped the rope around the sculpture, pulled and grabbed it with your hands. Put it in your bag, it may come in handy later")
                let item = g.findItemByName(pName: "Khufu's Sculpture")
                if let s = item as? Sculpture {
                    s.collectable = true
                }
            default:
                print("You ended up throwing the rope too hard and it got stuck in one of the cavities.")
                //remove rope from bag
        }
    }
}

class Sculpture:Item {
    
    // Variable to ensure that the item is collectable
    var collectable:Bool

    init(location:Room) {
        collectable = false
        super.init(location: location, name: "Khufu's Sculpture")
    }

    // Provides access to a new room
    override func use() {
            g.createSecretRoom()

            print("""
            You just use the precious sculpture of Khufu that will give you access to open the secret door that you can see in front of you. 
            Hopefully, this room contains the secrets and the treasure of Khufu, as the legend states!
            """)
    }
}

class Hieroglyphs:Item {

    init() {
        super.init(location: Item.common, name: "Alphabet of Hieroglyphs")
    }
    
    // Outputs a textual representation of the alphabet of hieroglyphs
    override func use() {
        print("""
          ____________________________________________________________
         |                                                            |
         |                  ALPHABET OF HIEROGLYPHS                   |
         |                                                            |
         |      A = vulture         L = lion                          | 
         |      B = leg             M = owl                           |
         |      C = cup             N = water       W = chick         |
         |      D = hand            O = chick       X = cloth         |
         |      E = feather         P = stool       Y = feathers      |
         |      F = viper           Q = hill        Z = bolt          |
         |      G = pot             R = mouth       CH = tether       |
         |      H = wick            S = cloth       KH = sieve        |
         |      I = feather         T = loaf        SH = basin        |
         |      J = cobra           U = chick                         |
         |      K = cup             V = viper                         |
         |____________________________________________________________|
         

        """)
    }
}

class Bag:Item {

    var items : [Item]

    init() {
        self.items = []
        super.init(location: Item.common, name: "Bag")
        let hieroglyphs:Hieroglyphs = Hieroglyphs()
        self.addItem(item: hieroglyphs)
        g.items.append(hieroglyphs)
    }
    
    /// Adds an item to the bag
    public func addItem(item: Item) {
        self.items.append(item)
    }
    
    /// Checks whether some item is contained in the bag
    public func contains(item: Item) -> Bool {
        return self.items.contains(item)
    }

    /// Returns an item when provided its name
    /// Returns nil if there is no match
    public func getItemByName(name: String) -> Item? {
        var found:Item? = nil

        for i in self.items {
            if (name.lowercased == i.name.lowercased) {
                found = i
            }
        }

        return found
    }

    /// Output textual representation of the bag's content
    override func use() {

        print("Your bag has \(self.items.count) item(s) :")

        for i in self.items {
            i.printInfo()
        }
    }
}

class Shield: Item {

   var defense = 80
   init(location:Room) {
      super.init(location: location, name: "Shield")
   }
   
   /// Adds 'Defense' stat to print statement
   override var description: String {
    return super.description + (" | Defense: \(self.defense)")
   }
  
}

class Chest: Item {

    // Reference to two items contained inside the Chest
    private(set) var shield:Shield
    private(set) var potion:Potion

    // Variable to keep track of the item's usage
    private(set) var used:Bool

   init(location:Room) {
       shield = Shield(location: location)
       potion = Potion(location: location)
       used = false
       super.init(location: location, name: "Chest")
   }

   /// Adds a shield and a potion to the player's bag
   override func use() {
       if(!used) {
            g.player.bag.addItem(item: shield)
            g.player.bag.addItem(item: potion)
            g.items.append(shield)
            g.items.append(potion)
            print("You have opened the chest which had the folowing items inside of it: Shield, Potion\nBoth of them were added to your bag.")
            used = true
        }
        else {
            print("You have already collected everything that was inside that chest!")
        }
    }

}
