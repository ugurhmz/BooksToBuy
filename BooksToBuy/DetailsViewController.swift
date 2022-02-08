

import UIKit
import CoreData

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    // fields
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var authorField: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var pageField: UITextField!
    @IBOutlet weak var publishedField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        //RECOGNIZERS
                // hide keyboard when click in DetailsViewController
        let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                       action:  #selector(hideKeyboard))
        
                // add Recog to VIEW
        view.addGestureRecognizer(gestureRecognizer)
        
                // Select image in my photo lib.
        imageView.isUserInteractionEnabled = true
        let selectImageRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        
        imageView.addGestureRecognizer(selectImageRecognizer)
        
    }
    
    // select Image
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    
    // later when select image
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
    
    
    
    // Hide Keyboard
    @objc func hideKeyboard(){
        view.endEditing(true) // Açık olan klavye kapansın.
    }
    
    

    // Save BTN
    @IBAction func saveBtn(_ sender: Any) {
        
        let myappDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = myappDelegate.persistentContainer.viewContext
        
        let newSaveImage = NSEntityDescription.insertNewObject(forEntityName: "Book", into: context)
        
        
        // Entity fields
        newSaveImage.setValue(UUID(),            forKey: "id")
        newSaveImage.setValue(nameField.text!,   forKey: "name")
        newSaveImage.setValue(authorField.text!, forKey: "author")
        
        if let page = Int(pageField.text!) {
            newSaveImage.setValue(page, forKey: "page")
        }
        
        if let price = Double(priceField.text!) {
            newSaveImage.setValue(price, forKey: "price")
        }
        
        newSaveImage.setValue(publishedField.text!, forKey: "publishDate" )
        
            // convert image
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        newSaveImage.setValue(data, forKey: "image")
        
        
        do {
            try context.save()
            
            NotificationCenter.default.post(name: NSNotification.Name("bookData"), object: nil)
            self.navigationController?.popViewController(animated: true)
            
            print("Success..")
            
        } catch {
            print("ERR!")
        }
        
        
        
        
    }
    

}
