//
//  ViewController.swift
//  Instagramclone
//
//  Created by Kalen Hammann on 2/11/19.
//  Copyright © 2019 Human Family. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    var signupModeActive = true
    
    func displayAlert(_ title: String, _ message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            print("The OK Button was pressed.")
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alertController,  animated: true, completion: nil)
    }

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signupOrLoginButton: UIButton!
    @IBOutlet weak var switchLoginModeButton: UIButton!
    
    @IBAction func signupOrLogin(_ sender: Any) {
        if email.text == "" || password.text == "" {
            displayAlert("Error","You need to enter an email and password to proceed.")
        } else {
            let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            activityIndicator.center = self.view.center
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = UIActivityIndicatorView.Style.gray
            view.addSubview(activityIndicator)
            activityIndicator.startAnimating()
            UIApplication.shared.beginIgnoringInteractionEvents()
            
            if (signupModeActive) {
                print("Signing up...")
                let user = PFUser()
                user.username = email.text
                user.password = password.text
                user.email = email.text
                
                user.signUpInBackground { (success, error) in
                    activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if let error = error {
                        let errorString = error._userInfo?["error"] as? NSString
                        self.displayAlert("Could not sign you up", errorString as String? ?? "")
                    } else {
                        // Hooray! Let them use the app now.
                        print("Signed up!")
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                    }
                }
            } else {
                PFUser.logInWithUsername(inBackground: email.text!, password: password.text!) { (user, error) in
                    
                    activityIndicator.stopAnimating()
                    UIApplication.shared.endIgnoringInteractionEvents()
                    
                    if user != nil {
                        print("Login Successful")
                        self.performSegue(withIdentifier: "showUserTable", sender: self)
                    } else {
                        var errorText = "Unknown error: please try again"
                        if let error = error {
                            errorText = error.localizedDescription
                        }
                        self.displayAlert("Could not log you in", errorText)
                    }
                }
            }
        }
    }
    
    @IBAction func switchLoginMode(_ sender: Any) {
        if (signupModeActive) {
            signupModeActive = false
            signupOrLoginButton.setTitle("Log In", for: [])
            switchLoginModeButton.setTitle("Sign Up", for: [])
        } else {
            signupModeActive = true
            signupOrLoginButton.setTitle("Sign Up", for: [])
            switchLoginModeButton.setTitle("Log In", for: [])
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if PFUser.current() != nil {
            performSegue(withIdentifier: "showUserTable", sender: self)
        }
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Add, save, update a Comment
        let comment = PFObject(className: "Comment")
        
        comment["text"] = "Nice shot!"
        
        comment.saveInBackground { (success, error) in
            if (success) {
                print("Save successful")
            } else {
                print("Save failed")
            }
        }
  
        let query = PFQuery(className: "Comment")
        query.getObjectInBackground(withId: "kwhTtBKEmb") { (object, eror) in
            if let comment = object {
                if let text = comment["text"] {
                    print(text)
                }
            }
        }
 
        let query = PFQuery(className: "Comment")
        query.getObjectInBackground(withId: "kwhTtBKEmb") { (object, eror) in
            if let comment = object {
                comment["text"] = "Yuck!"
                comment.saveInBackground(block: { (success, error) in
                    if (success) {
                        print("Update succeeded")
                    } else {
                        print("Update failed")
                    }
                })
            }
        }
        */
    }


}

