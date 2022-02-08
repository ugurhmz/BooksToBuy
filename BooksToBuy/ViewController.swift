

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    

    @IBOutlet weak var tableView: UITableView!
    var nameArr = [String]()
    var idArr = [UUID]()
    var imgArr = [UIImage]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // navigationBar (+)
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add,
            target: self,
            action: #selector(navigateAddBtn))
        
        
        
        // for tableView
        tableView.delegate = self
        tableView.dataSource = self
        
        
        getDatas()
    }
    
    
    // ADD BTN - Clicked navigate btn when to go detail-
    @objc func navigateAddBtn(){
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    
    
    // GET DATA
    func getDatas() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Book")
        fetchRequest.returnsObjectsAsFaults = false
        
        
        do {
            let bookDatas = try context.fetch(fetchRequest)
            
            if bookDatas.count > 0 {
                for book in bookDatas as! [NSManagedObject] {
                    
                    
                    if let name = book.value(forKey:"name") as? String {
                        self.nameArr.append(name)
                    }
                    
                    if let id = book.value(forKey: "id") as? UUID {
                        self.idArr.append(id)
                    }
                    
                    if let img = book.value(forKey: "image") as? UIImage {
                        self.imgArr.append(img)
                    }
                    
                    
                    self.tableView.reloadData() // Refresh Datas
                    
                }
            }
            
        } catch {
            print("Fetch ERR!")
        }
        
    }
    
    
    
    // numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArr.count
    }
    
    
    // cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath)
        
        cell.textLabel?.text = nameArr[indexPath.row]
      
        return cell
    }


}

