

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // navigationBar (+)
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add,
            target: self,
            action: #selector(navigateAddBtn))
    }
    
    
    // Clicked navigate btn when to go detail
    @objc func navigateAddBtn(){
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    


}

