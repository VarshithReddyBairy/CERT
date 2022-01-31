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
import FirebaseStorage
import PhotosUI

// MARK: 1 -  Defined a protocol to Implement dropZoomIn method
protocol HandleMapSearch: AnyObject {
    func dropZoomIn(placemark: MKPlacemark)
}

class CreateReportViewController: UIViewController {
    
// MARK: 2 - Defined Variables & Arrays
    var selectedPin: MKPlacemark?
    var resultSearchController: UISearchController!
    let locationManager = CLLocationManager()
    
    let fireHazardlevel = ["--Select Level--","Minor","Major","Medium","Spread Threat","Moderate","High","None"]
    let hazmotImpactLevel = ["--Select Type--","Gas","Fluid","Solid","Other Type"]
    let structureDamageLevel = ["--Select Damage Level--","High","Medium","Low"]
    let casualitiesType = ["--Select Casuality--","Walking wounded (Minor)","Broken Arm/Leg (Delay)","Medical care (Immediate)","Deceased"]
    
// MARK: 3 - Defined Outlets for various UI Controls
    
    //MapView
    @IBOutlet weak var mapView: MKMapView!
    
    //PickerViews
    var fireDamagePickerView = UIPickerView()
    var hazmotDamagePickerView = UIPickerView()
    var structureDamagePickerView = UIPickerView()
    var casualityDamagePickerView = UIPickerView()
    
    //ImageView
    @IBOutlet weak var photoView: UIImageView!
    
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
        
// MARK: 4 - Added Tap gestures to dismiss keyboard & Present gallery
        //Adding tapGesture to UIView
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        
        //Adding tapGesture to ImageView
        photoView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageUploadPrompt))
        photoView.addGestureRecognizer(gestureRecognizer)

// MARK: 5 - Declared values to the UI Controls
        
        //Assigned Delegates and methods to the object
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        //Action to carry out when user gives input into searchBar for location
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

// MARK: 6 - Initializing PickerViews
        //Fire Damage PickerView
        fireDamagePickerView.delegate = self
        fireDamagePickerView.dataSource = self
        fireDamagePickerView.tag = 1
        fireHazardImpactField.inputView = fireDamagePickerView
        fireHazardImpactField.textAlignment = .center
        
        //Hazmot damage PickerView
        hazmotDamagePickerView.delegate = self
        hazmotDamagePickerView.dataSource = self
        hazmotDamagePickerView.tag = 2
        hazmotDamageImpactField.inputView = hazmotDamagePickerView
        hazmotDamageImpactField.textAlignment = .center
        
        //Structure Damage PickerView
        structureDamagePickerView.delegate = self
        structureDamagePickerView.dataSource = self
        structureDamagePickerView.tag = 3
        strucDamageImpactField.inputView = structureDamagePickerView
        strucDamageImpactField.textAlignment = .center
        
        //Casuality damage PickerView
        casualityDamagePickerView.delegate = self
        casualityDamagePickerView.dataSource = self
        casualityDamagePickerView.tag = 4
        casualityImpactField.inputView = casualityDamagePickerView
        casualityImpactField.textAlignment = .center
        
    }
    
// MARK: 7 - Functions to carry out the task when user clicks on ImageView
    //Objective-C wrapper function to trigger the UIAlert Action
    @objc func imageUploadPrompt(){
        alertTrigger()
    }
    
    //Function that carry out the alert Action
    func alertTrigger(){
        let cameraIcon = UIImage(named: "camera")
        let galleryIcon = UIImage(named: "gallery")
        let deleteIcon = UIImage(named: "delete")
        
        let ac = UIAlertController(title: "Choose one", message: nil, preferredStyle: .actionSheet)
        let alert1 = UIAlertAction(title: "Open Camera", style: .default, handler: triggerCamera)
        alert1.setValue(cameraIcon, forKey: "image")
        ac.addAction(alert1)
        
        let alert2 = UIAlertAction(title: "Pick From Gallery", style: .default, handler: galleryImagePicker)
        alert2.setValue(galleryIcon, forKey: "image")
        ac.addAction(alert2)
        
        let alert3 = UIAlertAction(title: "Remove Picture", style: .destructive, handler: deletePicture)
        alert3.setValue(deleteIcon, forKey: "image")
        ac.addAction(alert3)
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
    //Function that carry out the subAction of UI alert action controller
    func triggerCamera(action:UIAlertAction){
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = false
        picker.delegate = self
        present(picker, animated: true)
    }
    
    //Function that carry out the subAction of UI alert action controller
    func galleryImagePicker(action:UIAlertAction){
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = self
        present(controller, animated: true)
        
    }
    
    //Function to remove picture
    func deletePicture(action:UIAlertAction){
        if photoView.image == nil{
            messageAlert(title: "Error", message: "No image is present in the imageView")
        }
        photoView.image = UIImage(named: "uploadImage")
        messageAlert(title: "Removed Image", message: "Uploaded Image is removed")
    }
    
    
    func uploadReportDetails(){
        guard let image = photoView.image, let imgData = image.jpegData(compressionQuality: 1.0) else{
            messageAlert(title: "Error", message: "Something terribly went wrong")
            return
        }
        let imageName = UUID().uuidString
        let imageRef = Storage.storage().reference().child("/imageReports").child(imageName)
        
        let uploadMeta = StorageMetadata()
        uploadMeta.contentType = "image/jpeg"
        
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
        
        imageRef.putData(imgData, metadata: uploadMeta){ (metadata, err) in
            if let err = err {
                self.messageAlert(title: "Error", message: err.localizedDescription)
                return
            }
            imageRef.downloadURL(completion: {(url, err) in
                if let err = err {
                    self.messageAlert(title: "Error", message: err.localizedDescription)
                    return
                }
                guard let url = url else {
                    self.messageAlert(title: "Error", message: "Something Went Wrong")
                    return
                }
                let urlString = url.absoluteString
            
                let dataRef = Firestore.firestore().collection("reports").document()
                //let docID = dataRef.documentID
                db.collection("reports").addDocument(data: ["Address": address,
                                                            "State": state,
                                                            "Latitude": latitude,
                                                            "Longitude": longitude,
                                                            "Zipcode": zipcode,
                                                            "Casuality": casuality,
                                                            "Fire Hazard": fireHazard,
                                                            "Structure Hazard": structureHazard,
                                                            "Hazmot Type": hazmotType,
                                                            "documentID": imageName,
                                                            "imageURL": urlString]) { (error) in
                    if error != nil {
                        self.messageAlert(title: "Data fetch Error", message: "We have experienced an error while fetching your data. Please try again.")
                    }
                    self.messageAlert(title: "Success", message: "Image Added and uploaded to Database Successfully")
                    
                }
            })
        }
    }

    
// MARK: 8 - IBAction that submits the data to firestore upon clicking the submit button
    @IBAction func SubmitTapped(_ sender: UIButton) {
        uploadReportDetails()
    }

// MARK: 9 - Function that triggers the UIAlert
    func messageAlert(title:String, message:String) {
        let errorAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        errorAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: { (ACTION) in
            errorAlert.dismiss(animated: true, completion: nil)
        }))
        self.present(errorAlert, animated: true, completion: nil)
    }

// MARK: 10 - Function that takes Location Co-ordinates from textFields and Converts them into Non-Optionals
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

// MARK: 11 - Extension to implement the MKMapViewDelegate method
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

// MARK: 12 - Extension to implement the HandleMapSearch protocol
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

// MARK: 13 - Extension to implement the CLLocationManagerDelegate method
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

// MARK: 14 - Extension to implement the UIPickerViewDelegate &  UIPickerViewDataSource methods
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

// MARK: 15 - Extension to implement the PHPickerViewControllerDelegate method
extension CreateReportViewController:PHPickerViewControllerDelegate{
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        if !results.isEmpty{
            let result = results.first!
            let itemProvider = result.itemProvider
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                    guard let image = image as? UIImage else{return}
                    DispatchQueue.main.async {
                        self?.photoView.image = image
                        self?.dismiss(animated: true, completion: nil)
                    }
                }
            }
        }
    }
}

// MARK: 16 - Extension to implement the UIImagePickerControllerDelegate & UINavigationControllerDelegate methods
extension CreateReportViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let img = info[.originalImage] as? UIImage else{
            self.messageAlert(title: "Error", message: "Something Went Wrong. Please try again")
            return
        }
        photoView.image = img
        dismiss(animated: true, completion: nil)
    }
}
