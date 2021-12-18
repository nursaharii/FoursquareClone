//
//  ViewController.swift
//  FoursquareClone
//
//  Created by Nurşah on 11.12.2021.
//

import UIKit
import Parse

class SignVC: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
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
        if username.text != "" && password.text != ""{
            PFUser.logInWithUsername(inBackground: username.text!, password: password.text!) { user, error in
                if error != nil{
                    self.Alert(title: "Hata!", message: error?.localizedDescription as! String)
                }
                else{
                    //Segue
                   // if user?.username == self.username.text! && user?.password == self.password.text! { }
                       self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                        
                    
                    /*else {
                        self.Alert(title: "Hata!", message: "Kullanıcı adı veya şifre hatalı!")
                    }*/
                }
            }
            
            /*else{
                self.Alert(title: "Error!", message: "Kullanıcı Adı veya Şifreniz hatalı!")
            }*/
            
        }
        else {
            Alert(title: "Hata!", message: "Kullanıcı adı veya şifrenizi eksik girdiniz.")
        }
    }
    
    @IBAction func SignUp(_ sender: Any) {
        if username.text != "" && password.text != "" && username.text != nil {
            let user = PFUser()
            user.username = username.text!
            user.password = password.text!
            user.signUpInBackground { bool, error in
                if error != nil {
                    self.Alert(title: "Error", message: error?.localizedDescription as! String)
                }
                else{
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
                }
            }
        }
        else {
            Alert(title: "Hata!", message: "Kullanıcı adı veya şifrenizi eksik girdiniz.")
        }
    }
    func Alert(title: String,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

