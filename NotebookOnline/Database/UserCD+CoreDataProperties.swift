
import Foundation
import CoreData


extension UserCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCD> {
        return NSFetchRequest<UserCD>(entityName: "UserCD")
    }

    @NSManaged public var age: Int16
    @NSManaged public var birthdayDate: String
    @NSManaged public var email: String
    @NSManaged public var firstName: String
    @NSManaged public var gender: String
    @NSManaged public var largePicture: URL
    @NSManaged public var lastName: String
    @NSManaged public var timeOffset: String

}

extension UserCD : Identifiable {

}
