import Foundation
import InteractiveFictionFramework

// -----[ Super Class Character ]-----

class Character: Equatable, CustomStringConvertible {
  
   var type: String {return "Character"}
   var name: String
   var health : Int
   var damage: Int

   init(name: String, health: Int, damage: Int){

      self.name = name
      self.health = health
      self.damage = damage
   }

   var description: String {     // Changes print() output
      return
         "Type: \(type)\n" +
         "Name: \(name)\n" + 
         "Health: \(health)\n" +
         "Damage: \(damage)\n"
   }  

   func info() {
      print(self)
     
   }

   func getsAttacked(damage : Int) {
      self.health -= damage
   }

   func isAlive() -> Bool {
      return health > 0
   }

   //Function used in `Encounters` to compare bosses (in lifeCheck() and FightOrFlee() functions)
   static func == (lhs: Character, rhs: Character) -> Bool {
      return (lhs.name == rhs.name) && (lhs.type == rhs.type) && (lhs.damage == rhs.damage)
   }

}

//-----[ Characters ]-----

class Player: Character {     //Used to initialize any of the 3 choices for main character

   var bag : Bag
   var stars : Int = 3
   var maxHealth : Int
   var lives : Int = 3 {
      didSet {
         if(lives<oldValue) {
            print("Watch out! You just lost one life. Remaining lives: \(lives)")
            stars=lives
         }
      }
   }

   override init(name: String, health: Int, damage: Int) {
      self.maxHealth = health
      let bag:Bag = Bag()
      self.bag = bag
      g.items.append(bag)
      super.init(name: name, health: health, damage: damage)
   }

   override var type: String {return "Player" }

   override func getsAttacked(damage : Int) {
      super.getsAttacked(damage: damage)
      if(self.health <= 0) {
        self.health = self.maxHealth
        lives-=1
      }
   }

   override func isAlive() -> Bool {
      return lives != 0
   }

   func collectItem(item:Item, currentRoom:Room) {     //Verifies if item is in the room and adds it to the bag
     
     if(self.bag.contains(item: item)) {
        print("You already collected this item! Look inside your bag to see which objects you have.")
        return
     }
     if(item.location.name == currentRoom.name) {
        if let s = item as? Sculpture {
         if(s.collectable) {
            print("The sculpture is too high for you to pick it up. You need something to bring it down.")
            return;
         }
        }
         self.bag.addItem(item: item)
         print("The \(item.name) was added to your bag!")
     }
     else {
        print("Sorry, you tried to collect an item which can not be found in the current room.")
        
     }
  }

  func useItem(item:Item) {   //Allows player to use an item within his bag
     if(item is Bag) {
        bag.use()
     }
     else if(!bag.contains(item: item)) {
        print("There's no such item inside your bag!")
     }
     else {
        item.use()
     }
  }

}

class Boss: Character {    //Used to initialize both Khufu and Cobra bosses

   override var type: String {return "Boss" }
}

class Snake: Character {      //Initializes 'snake' enemy with fixed stats

   override var type: String {return "Enemy" }
   init() {
      super.init(name: "Snake", health: 100, damage: 20)
   }
}

class Spider: Character {     //Initializes 'spider' enemy with fixed stats

   override var type: String {return "Enemy" }
   init() {
      super.init(name: "Spider", health: 100, damage: 10)
   }
}
