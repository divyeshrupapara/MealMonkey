import UIKit
import MapKit
import CoreLocation

class AddressViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var txtSearchAddress: UITextField!
    @IBOutlet weak var imgStar: UIImageView!
    @IBOutlet weak var btnRedirectCurrentLocation: UIButton!
    @IBOutlet weak var btnSavedAddress: UIButton!
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    var selectedAddressTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftAlignedTitleWithBack("Change Address", target: self, action: #selector(btnBackTapped))
        
        viewStyle(cornerRadius: txtSearchAddress.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [txtSearchAddress])
        viewStyle(cornerRadius: imgStar.frame.size.height / 2, borderWidth: 0, borderColor: .systemGray, textField: [imgStar])
        setPadding.setPadding(left: 34, right: 34, textfield: [txtSearchAddress])
        
        mapView.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
        mapView.addGestureRecognizer(tapGesture)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        mapView.showsUserLocation = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let coordinate = location.coordinate
            
            // Center map on user
            let region = MKCoordinateRegion(center: coordinate,
                                            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
            
            // Reverse geocode to get address and add pin
            reverseGeocodeAndAddPin(at: coordinate)
            
            // Stop continuous updates to save battery
            locationManager.stopUpdatingLocation()
        }
    }
    
    func reverseGeocodeAndAddPin(at coordinate: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            guard let self = self else { return }
            
            var title = "Unknown Location"
            if let placemark = placemarks?.first {
                title = [placemark.name, placemark.locality, placemark.country]
                    .compactMap { $0 }
                    .joined(separator: ", ")
            }
            
            self.selectedAddressTitle = title // store for later use
            self.addCustomPin(at: coordinate, title: title)
        }
    }
    
    func addCustomPin(at coordinate: CLLocationCoordinate2D, title: String) {
        // Remove old pins (optional)
        mapView.removeAnnotations(mapView.annotations.filter { !($0 is MKUserLocation) })
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        mapView.addAnnotation(annotation)
    }
    
    // MARK: - Custom Pin Image
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil } // Keep blue dot for user
        
        let identifier = "CustomPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "ic_current_position") // Your pin image in Assets
        annotationView?.frame.size = CGSize(width: 30, height: 30)
        
        return annotationView
    }
    
    func searchAddress(_ address: String) {
        geocoder.geocodeAddressString(address) { [weak self] placemarks, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            
            if let placemark = placemarks?.first,
               let location = placemark.location {
                
                let coordinate = location.coordinate
                
                // Create a clean, formatted address
                let formattedName = [
                    placemark.name,
                    placemark.locality,
                    placemark.administrativeArea,
                    placemark.country
                ]
                .compactMap { $0 }
                .joined(separator: ", ")
                
                // Store & update pin
                self.selectedAddressTitle = formattedName
                self.addCustomPin(at: coordinate, title: formattedName)
                
                // Update map
                let region = MKCoordinateRegion(center: coordinate,
                                                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let address = textField.text, !address.isEmpty {
            searchAddress(address)
        }
        
        return true
    }
    
    @objc func handleMapTap(_ gestureRecognizer: UITapGestureRecognizer) {
        let locationInView = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)
        
        // Reverse geocode to get address and update pin
        reverseGeocodeAndAddPin(at: coordinate)
    }
    
    @objc func btnBackTapped() {
        let finalAddress = selectedAddressTitle ?? "No Address Selected"
        
        // Save to UserDefaults
        UserDefaults.standard.set(finalAddress, forKey: "lastSelectedAddress")
        UserDefaults.standard.synchronize()
        
        if let checkoutVC = self.navigationController?.viewControllers.first(where: { $0 is CheckoutViewController }) as? CheckoutViewController {
            checkoutVC.addressText = finalAddress
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnRedirectCurrentLocationClick(_ sender: Any) {
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func btnSavedAddressClick(_ sender: Any) {
    }
}
