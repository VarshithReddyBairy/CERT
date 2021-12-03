//
//  CreateReportViewController.swift
//  CERT
//
//  Created by JayaShankar Mangina on 12/2/21.
//

import UIKit
import MapKit
import FirebaseAuth
import Firebase

protocol HandleMapSearch: AnyObject {
    func dropZoomIn(placemark: MKPlacemark)
}

class CreateReportViewController: UIViewController {
    
    var selectedPin: MKPlacemark?
    var resultSearchController: UISearchController!
    let locationManager = CLLocationManager()
    
    let fireHazardlevel = ["--Select Level--","Minor","Major","Medium","Spread Threat","Moderate","High","None"]
    let hazmotImpactLevel = ["--Select Type--","Gas","Fluid","Solid","Other Type"]
    let structureDamageLevel = ["--Select Damage Level--","High","Medium","Low"]
    let casualitiesType = ["--Select Casuality--","Walking wounded (Minor)","Broken Arm/Leg (Delay)","Medical care (Immediate)","Deceased"]
    
    //MapView
    @IBOutlet weak var mapView: MKMapView!
    
    //PickerViews
    var fireDamagePickerView = UIPickerView()
    var hazmotDamagePickerView = UIPickerView()
    var structureDamagePickerView = UIPickerView()
    var casualityDamagePickerView = UIPickerView()
    
    //Error labels to show when the user left any field
    @IBOutlet weak var casualityLabel: UILabel!
    @IBOutlet weak var fireHazardLabel: UILabel!
    @IBOutlet weak var strucDamageLabel: UILabel!
    @IBOutlet weak var hazmotDamageLabel: UILabel!
    
    //UITextFields
    @IBOutlet weak var casualityImpactField: UITextField!
    @IBOutlet weak var fireHazardImpactField: UITextField!
    @IBOutlet weak var strucDamageImpactField: UITextField!
    @IBOutlet weak var hazmotDamageImpactField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var lattitudeField: UITextField!
    @IBOutlet weak var longitudeField: UITextField!
    @IBOutlet weak var zipcodeField: UITextField!
    
    //submit Button Outlet
    @IBOutlet weak var submitRprtBtnOutlt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide the Labels on Boot
        casualityLabel.isHidden = true
        fireHazardLabel.isHidden = true
        strucDamageLabel.isHidden = true
        hazmotDamageLabel.isHidden = true
        
        //
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        let locationSearch = storyboard?.instantiateViewController(withIdentifier: "LocationSearch") as! LocationSearch
        resultSearchController = UISearchController(searchResultsController: locationSearch)
        resultSearchController.searchResultsUpdater = locationSearch
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search"
        
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.obscuresBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearch.mapView = mapView
        locationSearch.handleMapSearchDelegate = self
        
        //
        fireDamagePickerView.delegate = self
        fireDamagePickerView.dataSource = self
        fireDamagePickerView.tag = 1
        fireHazardImpactField.inputView = fireDamagePickerView
        fireHazardImpactField.textAlignment = .center
        
        //
        hazmotDamagePickerView.delegate = self
        hazmotDamagePickerView.dataSource = self
        hazmotDamagePickerView.tag = 2
        hazmotDamageImpactField.inputView = hazmotDamagePickerView
        hazmotDamageImpactField.textAlignment = .center
        
        //
        structureDamagePickerView.delegate = self
        structureDamagePickerView.dataSource = self
        structureDamagePickerView.tag = 3
        strucDamageImpactField.inputView = structureDamagePickerView
        strucDamageImpactField.textAlignment = .center
        
        //
        casualityDamagePickerView.delegate = self
        casualityDamagePickerView.dataSource = self
        casualityDamagePickerView.tag = 4
        casualityImpactField.inputView = casualityDamagePickerView
        casualityImpactField.textAlignment = .center
        
    }
    
    @IBAction func SubmitTapped(_ sender: UIButton) {
        let address = addressField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let state = stateField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let latitude = lattitudeField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let longitude = longitudeField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let zipcode = zipcodeField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let casuality = casualityImpactField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let fireHazard = fireHazardImpactField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let structureHazard = strucDamageImpactField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let hazmotType = hazmotDamageImpactField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let db = Firestore.firestore()
        db.collection("reports").addDocument(data: ["Address": address,
                                                    "State": state,
                                                    "Latitude": latitude,
                                                    "Longitude": longitude,
                                                    "Zipcode": zipcode,
                                                    "Casuality": casuality,
                                                    "Fire Hazard": fireHazard,
                                                    "Structure Hazard": structureHazard,
                                                    "Hazmot Type": hazmotType]) { (error) in
            if error != nil {
                self.messageAlert(title: "Data fetch Error", message: "We have experienced an error while fetching your data. Please try again.")
            }
            
        }
        
    }
    
    func messageAlert(title:String, message:String) {
        let errorAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        errorAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { (ACTION) in
            errorAlert.dismiss(animated: true, completion: nil)
        }))
        self.present(errorAlert, animated: true, completion: nil)
    }
    
    @objc func getInfo(){
        let a:Double? = (locationManager.location?.coordinate.latitude)
        let b:Double? = (locationManager.location?.coordinate.longitude)
        let c:String? = selectedPin?.thoroughfare
        let d:String? = selectedPin?.administrativeArea
        let e:String? = selectedPin?.postalCode
        
        if let lat = a {
            if a! < 0 {
                lattitudeField.text = "\(a!)"
            }
            lattitudeField.text = a?.description
        }
        
        if let longt = b {
            if b! < 0 {
                longitudeField.text = "\(b!)"
            } else {
                longitudeField.text = b?.description
            }
            
        }
        
        if let zipcode = e{
            zipcodeField.text = zipcode
        }
        
        if let state = d{
            stateField.text = state
        }
        
        if let address = c{
            addressField.text = address
        }

    }

}

extension CreateReportViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {return nil}
        let reUseID = "Pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reUseID) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reUseID)
        }
        pinView?.pinTintColor = UIColor.green
        pinView?.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        let button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
        button.setBackgroundImage(UIImage(named: "location Info"), for: .normal)
        button.addTarget(self, action: #selector(getInfo), for: .touchUpInside)
        pinView?.leftCalloutAccessoryView = button
        return pinView
    }
    
}

extension CreateReportViewController: HandleMapSearch {
    func dropZoomIn(placemark: MKPlacemark) {
        //
        selectedPin = placemark
        
        //
        mapView.removeAnnotations(mapView.annotations)
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        
        if let city = placemark.locality,
           let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        
        mapView.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    
    
}

extension CreateReportViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
    
}

extension CreateReportViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return fireHazardlevel.count
        case 2:
            return hazmotImpactLevel.count
        case 3:
            return structureDamageLevel.count
        case 4:
            return casualitiesType.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return fireHazardlevel[row]
        case 2:
            return hazmotImpactLevel[row]
        case 3:
            return structureDamageLevel[row]
        case 4:
            return casualitiesType[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            fireHazardImpactField.text = fireHazardlevel[row]
            fireHazardImpactField.resignFirstResponder()
        case 2:
            hazmotDamageImpactField.text = hazmotImpactLevel[row]
            hazmotDamageImpactField.resignFirstResponder()
        case 3:
            strucDamageImpactField.text = structureDamageLevel[row]
            strucDamageImpactField.resignFirstResponder()
        case 4:
            casualityImpactField.text = casualitiesType[row]
            casualityImpactField.resignFirstResponder()
        default: break
        }
    }
    
}
