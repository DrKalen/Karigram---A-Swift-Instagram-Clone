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

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signupOrLoginButton: UIButton!
    @IBOutlet weak var switchLoginModeButton: UIButton!
    
    @IBAction func signupOrLogin(_ sender: Any) {
    }
    
    @IBAction func switchLoginMode(_ sender: Any) {
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

