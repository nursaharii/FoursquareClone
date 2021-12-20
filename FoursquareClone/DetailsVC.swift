//
//  DetailsVC.swift
//  FoursquareClone
//
//  Created by Nurşah on 18.12.2021.
//

import UIKit
import MapKit
import Parse

class DetailsVC: UIViewController, MKMapViewDelegate{

    @IBOutlet weak var map: MKMapView!
    
    @IBOutlet weak var placeTypeLbl: UILabel!
    
    @IBOutlet weak var placeNameLbl: UILabel!
    
    @IBOutlet weak var img: UIImageView!
    
    var choosenPlaceId = ""
    var choosenLatitude = Double()
    var choosenLongitude = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataFromParse()
        map.delegate = self
    }
    
    func getDataFromParse() {
        let query = PFQuery(className: "Places")
        query.whereKey("objectId", equalTo: choosenPlaceId)
        query.findObjectsInBackground { objects, error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription ?? "Error", preferredStyle: UIAlertController.Style.alert)
                let OkBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(OkBtn)
                self.present(alert, animated: true, completion: nil)
            }
            else {
                let choosenPlaceObj = objects![0]
                
                if let placeName = choosenPlaceObj.object(forKey: "name") as? String {
                        self.placeNameLbl.text = placeName
                }
                if let placeType = choosenPlaceObj.object(forKey: "type") as? String {
                    self.placeTypeLbl.text = placeType
                }
                if let placeLatitude = choosenPlaceObj.object(forKey: "latitude") as? String {
                    if let placeLatitudeDouble = Double(placeLatitude) {
                        self.choosenLatitude = placeLatitudeDouble
                    }
                }
                if let placeLongitude = choosenPlaceObj.object(forKey: "longitude") as? String {
                    if let placeLongitudeDouble = Double(placeLongitude) {
                        self.choosenLongitude = placeLongitudeDouble
                    }
                }
                if let imgData = choosenPlaceObj.object(forKey: "img") as? PFFileObject {
                    imgData.getDataInBackground { data, error in
                        if error == nil {
                            if data != nil {
                                self.img.image = UIImage(data: data!)
                            }
                            
                        }
                    }
                }
                //Maps
                let location = CLLocationCoordinate2D(latitude: self.choosenLatitude, longitude: self.choosenLongitude)
                let span = MKCoordinateSpan(latitudeDelta: 0.035, longitudeDelta: 0.035)
                let region = MKCoordinateRegion(center: location, span: span)
                self.map.setRegion(region, animated: true)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = location
                annotation.title = self.placeNameLbl.text!
                annotation.subtitle = self.placeTypeLbl.text!
                self.map.addAnnotation(annotation)
            }
        }
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        var reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        }
        else{
            pinView?.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if self.choosenLatitude != 0.0 && self.choosenLongitude != 0.0 {
            let reqLoc = CLLocation(latitude: self.choosenLatitude, longitude: self.choosenLongitude)
            CLGeocoder().reverseGeocodeLocation(reqLoc) { placemarks, error in
                if let placemark = placemarks {
                    if placemark.count > 0 {
                        let mkPlaceMark = MKPlacemark(placemark: placemark[0])
                        let mapItem = MKMapItem(placemark: mkPlaceMark)
                        mapItem.name = self.placeNameLbl.text!
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                        mapItem.openInMaps(launchOptions: launchOptions)
                    }
                }
            }
        }
    }

}
