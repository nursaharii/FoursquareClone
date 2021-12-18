//
//  addPlacesVC.swift
//  FoursquareClone
//
//  Created by Nurşah on 18.12.2021.
//

import UIKit

class addPlacesVC: UIViewController {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var placeType: UITextField!
    @IBOutlet weak var placeName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "toMapVC", sender: nil)
    }
}
