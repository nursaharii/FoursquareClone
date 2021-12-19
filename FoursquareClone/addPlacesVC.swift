//
//  addPlacesVC.swift
//  FoursquareClone
//
//  Created by Nurşah on 18.12.2021.
//

import UIKit

class addPlacesVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var placeType: UITextField!
    @IBOutlet weak var placeName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRegocnizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRegocnizer)
        img.isUserInteractionEnabled = true
        let imgTap = UITapGestureRecognizer(target: self, action: #selector(addImg))
        img.addGestureRecognizer(imgTap)
        
    }
    @objc func addImg(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker,animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        img.image = info[.originalImage] as? UIImage
        nextBtn.isEnabled = true
        self.dismiss(animated: true, completion: nil)
    }
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        
        if placeName.text != "" && placeType.text != "" {
            if let choosenImg = img.image {
                let placesModel = PlacesModel.sharedInstance
                placesModel.placeName = placeName.text!
                placesModel.placeType = placeType.text!
                placesModel.placeImg = choosenImg
            }
            self.performSegue(withIdentifier: "toMapVC", sender: nil)
        }
        else {
            Alert(title: "Error!", message: "Tüm alanları doldurup tekrar deneyiniz.")
        }
        
    }
    func Alert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okBtn)
        self.present(alert, animated: true, completion: nil)
    }
}

