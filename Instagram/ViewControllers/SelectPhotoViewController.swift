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
        selectPhoto()
    }
    @IBOutlet weak var selectPhotoImage: UIImageView!
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var captionTextField: UITextField!
    
    var isSelected: Bool = false
    
    @IBAction func submitPost(_ sender: Any) {
        let caption = captionTextField.text ?? ""
        let image = selectPhotoImage.image
        Post.postUserImage(image: image, withCaption: caption) { (success, error) in
            if (error != nil) {
                print(error.debugDescription)
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    func selectPhoto(){
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(vc, animated: true, completion: nil)
    }
    
    // Delegate Protocols
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Get the image captured by the UIImagePickerController
        // let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        
        selectPhotoImage.image = editedImage
        isSelected = true
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }

}
