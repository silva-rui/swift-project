import InteractiveFictionFramework

extension Room:Equatable {

    public static func ==(lhs: Room, rhs: Room) -> Bool {
        return (lhs.name == rhs.name) && (lhs.exits == rhs.exits)
    }

}