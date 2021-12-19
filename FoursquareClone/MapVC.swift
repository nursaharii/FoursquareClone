//
//  MapVC.swift
//  FoursquareClone
//
//  Created by Nurşah on 18.12.2021.
//

import UIKit
import MapKit
import Parse
class MapVC: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var map: MKMapView!
    var locationManager = CLLocationManager()
    let placeModel = PlacesModel.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Save", style: UIBarButtonItem.Style.plain, target: self, action: #selector(saveBtn))
        
        navigationController?.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(backBtn))
        
        
        map.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        recognizer.minimumPressDuration = 3
        map.addGestureRecognizer(recognizer)
    }
    
    @objc func chooseLocation(gestureRecognizer : UIGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizer.State.began {
            let touches = gestureRecognizer.location(in: self.map)
            let coordinates = self.map.convert(touches, toCoordinateFrom: self.map)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinates
            annotation.title = PlacesModel.sharedInstance.placeName
            annotation.subtitle = PlacesModel.sharedInstance.placeType
            
            self.map.addAnnotation(annotation)
            
            placeModel.placeLatitude = String(annotation.coordinate.latitude)
            placeModel.placeLongitude = String(annotation.coordinate.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.stopUpdatingLocation()
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
    }
    
    @objc func saveBtn(){
        let object = PFObject(className: "Places")
        object["name"] = placeModel.placeName
        object["type"] = placeModel.placeType
        object["latitude"] = placeModel.placeLatitude
        object["longitude"] = placeModel.placeLongitude
        
        if let imgData = placeModel.placeImg.jpegData(compressionQuality: 0.5){
            object["img"] = PFFileObject(name: "img.jpg",data: imgData)
        }
        object.saveInBackground { success, error in
            if error != nil{
                self.Alert(title: "Error!", message: error?.localizedDescription ?? "Error!")
            }
            else{
                self.performSegue(withIdentifier: "fromMapVC", sender: nil)
            }
        }
    }
    
    @objc func backBtn(){
        self.dismiss(animated: true, completion: nil)
        
    }
    func Alert(title: String,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

}
