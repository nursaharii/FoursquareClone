//
//  ViewController.swift
//  FoursquareClone
//
//  Created by Nurşah on 11.12.2021.
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*
        let parseobj = PFObject(className: "Fruits")
        parseobj["name"] = "Banana"
        parseobj["calories"] = 200
        parseobj.saveInBackground { bool, error in
            if error != nil {
                print(error?.localizedDescription)
            }
            else{
                print("success")
            }
        }
        let query = PFQuery(className: "Fruits")
       // query.whereKey("name", contains: "Apple")
        query.whereKey("calories", greaterThan: 99)
        query.findObjectsInBackground { obj, error in
            if error != nil{
                print(error?.localizedDescription)
            }
            else{
                print(obj)
            }
        }*/
    }

   
    @IBAction func SignIn(_ sender: Any) {
    }
    
    @IBAction func SignUp(_ sender: Any) {
        if email.text != "" && password.text != ""{
            
        }
    }
}

