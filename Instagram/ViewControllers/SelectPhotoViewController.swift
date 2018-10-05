//
//  SelectPhotoViewController.swift
//  Instagram
//
//  Created by Chris Martinez on 10/2/18.
//  Copyright © 2018 Chris Martinez. All rights reserved.
//

import UIKit
import Photos

class SelectPhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var selectPhotoImage: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var captionTextField: UITextField!
    
    let vc = UIImagePickerController()
    
    @IBAction func onImageSelect(_ sender: Any) {
        self.vc.allowsEditing = true
        self.vc.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(self.vc, animated: true, completion: nil)
        
    }
    
    @IBAction func onSubmit(_ sender: Any) {
        let caption = captionTextField.text ?? ""
        let image = selectPhotoImage.image
        
        
        print("Caption: " + caption)
        
        
        let group = DispatchGroup()
        group.enter()
        Post.postUserImage(image: image, withCaption: caption) { (success, error) in
            if (error != nil) {
                print("Error!")
                print(error.debugDescription)
            }
            else{
                print("Success!")
            }
        }
        group.leave()
        group.wait()
        
        //wait function until post is done for closure
        performSegue(withIdentifier: "submitSegue", sender: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        vc.delegate = self
        super.viewDidLoad()
    }

    // Delegate Protocols
   func imagePickerController(_ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Get the image captured by the UIImagePickerController
    
        let editedImage = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        
        selectPhotoImage.image = editedImage
    
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true, completion: nil)
    }

}
