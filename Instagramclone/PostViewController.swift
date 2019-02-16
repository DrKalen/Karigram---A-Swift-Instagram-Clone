//
//  PostViewController.swift
//  Instagramclone
//
//  Created by Kalen Hammann on 2/15/19.
//  Copyright © 2019 Human Family. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageToPost: UIImageView!
    @IBOutlet weak var comment: UITextField!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageToPost.image = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func displayAlert(_ title: String, _ message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            print("The OK Button was pressed.")
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alertController,  animated: true, completion: nil)
    }
    
    @IBAction func postImage(_ sender: Any) {
        if let image = imageToPost.image {
            let post = PFObject(className: "Post")
            post["message"] = comment.text
            post["userid"] = PFUser.current()?.objectId
            if let imageData = image.pngData() {
                let imageFile = PFFileObject(name: "image.png", data: imageData)
                post["imageFile"] = imageFile
            }
            let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = UIActivityIndicatorView.Style.gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            post.saveInBackground { (success, error) in
                activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                if success {
                    self.displayAlert("Image Posted!", "Your image was posted successfully.")
                    self.comment.text = ""
                    self.imageToPost.image = nil
                } else {
                        if let error = error {
                            let errorString = error._userInfo?["error"] as? NSString
                            self.displayAlert("Image Could Not Be Posted", errorString! as String)
                        }
                }
            }
        }
    }
    
    @IBAction func chooseImage(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
