

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    // fields
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var authorField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var pageField: UITextField!
    @IBOutlet weak var publishedField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // hide keyboard when click in DetailsViewController
        let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                       action:  #selector(hideKeyboard))
        
        // add Recog to VIEW
        view.addGestureRecognizer(gestureRecognizer)
        
        
    }
    
    
    // Hide Keyboard
    @objc func hideKeyboard(){
        view.endEditing(true) // Açık olan klavye kapansın.
    }
    
    

    // Save BTN
    @IBAction func saveBtn(_ sender: Any) {
        print("save clicked...")
    }
    

}
