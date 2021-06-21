import Foundation
import InteractiveFictionFramework

//-----[ Super Class Weapon ]----- 

class Weapon: Item {
   
   var damage: Int
   
   init(location:Room, name: String, damage: Int) {
      self.damage = damage
      super.init(location: location, name: name)
      
   }

   override func use() {
      print("""

      You swing the \(self.name) around a few times...
      \(g.player.name): Alright, enough fooling around, I should keep focused.

      """)
      
   }

   override func printInfo() {
      super.printInfo()
      print("Damage: \(self.damage)")

    }

   override var description: String {
    return super.description + " | Damage: \(self.damage)"
   }
}

//-----[ Weapons ]-----

class MaceAx: Weapon {

   init(location:Room) {
      super.init(location: location, name: "MaceAx", damage: 120)
   }
}

class Spear: Weapon {

   init(location:Room) {
      super.init(location: location, name: "Spear", damage: 90)
   }
}

class Khopesh: Weapon {

   init(location:Room) {
      super.init(location: location, name: "Khopesh", damage: 60)
   }
}


