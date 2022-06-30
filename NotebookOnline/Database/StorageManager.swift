
import UIKit
import CoreData

class StorageManager {
    
    static let shared = StorageManager()
    private init() {}
    
    var usersCD = [UserCD]()
    
    func saveUsers(users: [User]) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let usersCD: [UserCD] = users.map { item in
            let user = UserCD(context: context)
            user.gender = item.gender
            user.firstName = item.name.first
            user.lastName = item.name.last
            user.largePicture = item.picture.large
            user.email = item.email
            user.birthdayDate = item.dob.date
            user.age = Int16(item.dob.age)
            user.timeOffset = item.location.timezone.offset
            
            return user
            
        }
        self.usersCD.append(contentsOf: usersCD)
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func readUsers() -> [User] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<UserCD> = UserCD.fetchRequest()
        
        do {
            let usersCD = try context.fetch(fetchRequest)
            let users: [User] = usersCD.map { item in
                User(gender: item.gender,
                     name: Name(first: item.firstName,
                                last: item.lastName),
                     picture: Picture(large: item.largePicture),
                     dob: Birthday(date: item.birthdayDate,
                                   age: Int(item.age)),
                     email: item.email,
                     location: Location(timezone: Timezone(offset: item.timeOffset)))
            }
            return users
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func delete() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "UserCD")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch {
            print("error")
        }
    }
    
}
