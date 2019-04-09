
import UIKit
import CoreData
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
{
   @IBOutlet weak var userTableView: UITableView!
    var manageObjectContext: NSManagedObjectContext!
    var dataSource = [UserModel]()
    let cellReuseIdentifier = "userCell"
    override func viewDidLoad()
    {
        super.viewDidLoad()
        manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        userTableView.dataSource = self
        userTableView.delegate = self
        
        // insertIntitialData()
         //loadInitialData()

       loadSwedenUser()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return dataSource.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : UserCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! UserCell
        cell.lblName.text = dataSource[indexPath.row].userName
        cell.lblCity.text = dataSource[indexPath.row].userCity
        if dataSource[indexPath.row].userCountry == "Sweden"
        {
            cell.imgCtryFlag?.image = UIImage(named: "SwedenFlag")
        }
        else
        {
            cell.imgCtryFlag?.image = UIImage(named: "FinlandFlag")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 65;
    }
    
    func loadInitialData()
    {
        self.title = "International Users"
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "InternationalUser")
        request.returnsObjectsAsFaults = false
        do {
            let result = try manageObjectContext.fetch(request)
            for data in result as! [NSManagedObject]
            {
                let userModel = UserModel()
                userModel.userName = data.value(forKey: "userName") as! String
                userModel.userAge = data.value(forKey: "userAge") as! Int
                userModel.userSex = data.value(forKey: "userSex") as! String
                userModel.userCity = data.value(forKey: "userCity") as! String
                userModel.userCountry = data.value(forKey: "userCountry") as! String
                dataSource.append(userModel)
                print(data)
            }
        } catch {
            print("Failed")
        }
    }
    
    @objc func loadSwedenUser()
    {
        self.title = "Sweden Users"
        dataSource = [UserModel]();
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Finland", style: .plain, target: self, action: #selector(loadFinlandUser))
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "SwedenUser")
        request.returnsObjectsAsFaults = false
        do {
            let result = try manageObjectContext.fetch(request)
            for data in result as! [NSManagedObject]
            {
                let userModel = UserModel()
                userModel.userName = data.value(forKey: "userName") as! String
                userModel.userAge = data.value(forKey: "userAge") as! Int
                userModel.userSex = data.value(forKey: "userSex") as! String
                userModel.userCity = data.value(forKey: "userCity") as! String
                userModel.userCountry = "Sweden"
                dataSource.append(userModel)
                print(data)
            }
        } catch {
            
            print("Failed")
        }
        userTableView.reloadData()
    }
    
    @objc func loadFinlandUser()
    {
        self.title = "Finland Users"
        dataSource = [UserModel]();
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sweden", style: .plain, target: self, action: #selector(loadSwedenUser))
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FinlandUser")
        request.returnsObjectsAsFaults = false
        do {
            let result = try manageObjectContext.fetch(request)
            for data in result as! [NSManagedObject] {
                let userModel = UserModel()
                userModel.userName = data.value(forKey: "userName") as! String
                userModel.userAge = data.value(forKey: "userAge") as! Int
                userModel.userSex = data.value(forKey: "userSex") as! String
                userModel.userCity = data.value(forKey: "userCity") as! String
                userModel.userCountry = "Finland"
                dataSource.append(userModel)
                print(data)
            }
        } catch {
            print("Failed")
        }
        userTableView.reloadData()
    }
    
    func insertIntitialData()
    {
        let entity = NSEntityDescription.entity(forEntityName: "InternationalUser", in: manageObjectContext)
        
        let userOne = NSManagedObject(entity: entity!, insertInto: manageObjectContext)
        userOne.setValue("Alice", forKey: "userName")
        userOne.setValue("Finland", forKey: "userCountry")
        userOne.setValue("Female", forKey: "userSex")
        userOne.setValue(22, forKey: "userAge")
        userOne.setValue("Hanko", forKey: "userCity")
        
        let userTwo = NSManagedObject(entity: entity!, insertInto: manageObjectContext)
        userTwo.setValue("Mark", forKey: "userName")
        userTwo.setValue("Sweden", forKey: "userCountry")
        userTwo.setValue("Male", forKey: "userSex")
        userTwo.setValue(24, forKey: "userAge")
        userTwo.setValue("Flen", forKey: "userCity")
        
        let userThree = NSManagedObject(entity: entity!, insertInto: manageObjectContext)
        userThree.setValue("Perry", forKey: "userName")
        userThree.setValue("Finland", forKey: "userCountry")
        userThree.setValue("Female", forKey: "userSex")
        userThree.setValue(24, forKey: "userAge")
        userThree.setValue("Rauma", forKey: "userCity")
        
        let userFour = NSManagedObject(entity: entity!, insertInto: manageObjectContext)
        userFour.setValue("Alan", forKey: "userName")
        userFour.setValue("Sweden", forKey: "userCountry")
        userFour.setValue("Male", forKey: "userSex")
        userFour.setValue(21, forKey: "userAge")
        userFour.setValue("Trosa", forKey: "userCity")
        
        let userFive = NSManagedObject(entity: entity!, insertInto: manageObjectContext)
        userFive.setValue("Baker", forKey: "userName")
        userFive.setValue("Finland", forKey: "userCountry")
        userFive.setValue("Female", forKey: "userSex")
        userFive.setValue(25, forKey: "userAge")
        userFive.setValue("Vaasa", forKey: "userCity")
        
        
        do {
            try manageObjectContext.save()
        } catch {
            print("Failed saving")
        }
    }
    
}
