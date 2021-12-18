//
//  MapVC.swift
//  FoursquareClone
//
//  Created by Nurşah on 18.12.2021.
//

import UIKit
import MapKit
class MapVC: UIViewController{

    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveBtn))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backBtn))
    }
    
    @objc func saveBtn(){
        
    }
    
    @objc func backBtn(){
        self.dismiss(animated: true, completion: nil)
        
    }

}
