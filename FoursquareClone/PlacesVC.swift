//
//  PlacesVC.swift
//  FoursquareClone
//
//  Created by Nurşah on 18.12.2021.
//

import UIKit
import Parse

class PlacesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeNameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = placeNameArr[indexPath.row]
        return cell
    }
    

    @IBOutlet weak var tableView: UITableView!
    var placeNameArr = [String]()
    var placeIdArr = [String]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addBtn))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logoutBtn))
        getDataFromParse()
        
    }
    
    @objc func addBtn() {
        self.performSegue(withIdentifier: "toAddPlacesVC", sender: nil)
    }
    
    @objc func logoutBtn(){
        PFUser.logOutInBackground { error in
            if error != nil{
                self.Alert(title: "Error!", message: error?.localizedDescription ?? "Hata")
            }
            else{
                self.performSegue(withIdentifier: "toSignVC", sender: nil)
            }
        }
    }
    
    func getDataFromParse() {
        let query = PFQuery(className: "Places")
        query.findObjectsInBackground { objects, error in
            if error != nil {
                self.Alert(title: "Error!", message: error?.localizedDescription ?? "Error")
            }
            else {
                if objects != nil {
                   self.placeIdArr.removeAll(keepingCapacity: false)
                   self.placeNameArr.removeAll(keepingCapacity: false)
                    for object in objects! {
                        if let placeName = object.object(forKey: "name") as? String {
                            if let placeId = object.objectId {
                                self.placeNameArr.append(placeName)
                                self.placeIdArr.append(placeId)
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    func Alert(title: String,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

}
