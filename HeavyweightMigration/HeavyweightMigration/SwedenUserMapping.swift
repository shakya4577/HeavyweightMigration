
import UIKit
import CoreData

class SwedenUserMapping: NSEntityMigrationPolicy
{
    override func createDestinationInstances(forSource sInstance: NSManagedObject,
                                             in mapping: NSEntityMapping,
                                             manager: NSMigrationManager) throws
    {
       if sInstance.entity.name == "InternationalUser"
        {
            let userName = sInstance.primitiveValue(forKey: "userName") as! String
            let userAge = sInstance.primitiveValue(forKey: "userAge") as! Int
            let userSex = sInstance.primitiveValue(forKey: "userSex") as! String
            let userCity = sInstance.primitiveValue(forKey: "userCity") as! String
            let userCountry = sInstance.primitiveValue(forKey: "userCountry") as! String
            
            if userCountry == "Sweden"
            {
                let swedenUser = NSEntityDescription.insertNewObject(forEntityName: "SwedenUser",
                                                                      into: manager.destinationContext)
                swedenUser.setValue(userName, forKey: "userName")
                swedenUser.setValue(userAge, forKey: "userAge")
                swedenUser.setValue(userSex, forKey: "userSex")
                if userCity == "Trosa"
                {
                    swedenUser.setValue("Nora", forKey: "userCity")
                }
                else
                {
                     swedenUser.setValue(userCity, forKey: "userCity")
                }
            }
        }
    }
}
