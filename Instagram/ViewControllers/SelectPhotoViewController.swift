//
//  SelectPhotoViewController.swift
//  Instagram
//
//  Created by Chris Martinez on 10/2/18.
//  Copyright © 2018 Chris Martinez. All rights reserved.
//

import UIKit

class SelectPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBAction func onImageSelect(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(vc, animated: true, completion: nil)
        
 
    }
    @IBOutlet weak var selectPhotoImage: UIImageView!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var captionTextField: UITextField!
    
    var isSelected: Bool = false
    
    @IBAction func submitPost(_ sender: Any) {
        
        let caption = captionTextField.text ?? ""
        let image = selectPhotoImage.image
        
        if(!isSelected){
            print("error! Image not received.")
            print(caption)
            return
        }
        
        Post.postUserImage(image: image, withCaption: caption) { (success, error) in
            if (error != nil) {
                print("Error!")
                print(error.debugDescription)
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // Delegate Protocols
   @objc func imagePickerController(_ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let editedImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        
        selectPhotoImage.image = editedImage
    
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }

}
