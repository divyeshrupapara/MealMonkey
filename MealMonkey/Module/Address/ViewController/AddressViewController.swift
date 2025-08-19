import UIKit
import MapKit
import CoreLocation

/// ViewController to allow users to select, search, and manage addresses using MapKit
class AddressViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    /// Map view displaying user location and pins
    @IBOutlet weak var mapView: MKMapView!
    
    /// TextField to search addresses
    @IBOutlet weak var txtSearchAddress: UITextField!
    
    /// Star icon (used for saved/favorite addresses)
    @IBOutlet weak var imgStar: UIImageView!
    
    /// Button to redirect to current location
    @IBOutlet weak var btnRedirectCurrentLocation: UIButton!
    
    /// Button for accessing saved addresses
    @IBOutlet weak var btnSavedAddress: UIButton!
    
    // MARK: - Properties
    
    /// Core Location manager for user location updates
    let locationManager = CLLocationManager()
    
    /// CLGeocoder for converting between addresses and coordinates
    let geocoder = CLGeocoder()
    
    /// Stores the currently selected address as a string
    var selectedAddressTitle: String?
    
    // MARK: - Lifecycle Methods
    
    /// Called after the view has loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup navigation title with back button
        setLeftAlignedTitleWithBack("Change Address", target: self, action: #selector(btnBackTapped))
        
        // Apply corner radius and padding styles
        viewStyle(cornerRadius: txtSearchAddress.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [txtSearchAddress])
        viewStyle(cornerRadius: imgStar.frame.size.height / 2, borderWidth: 0, borderColor: .systemGray, textField: [imgStar])
        setPadding.setPadding(left: 34, right: 34, textfield: [txtSearchAddress])
        
        // Map and location setup
        mapView.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(_:)))
        mapView.addGestureRecognizer(tapGesture)
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        mapView.showsUserLocation = true
    }
    
    // MARK: - Map Pin Handling
    
    /// Reverse geocodes a coordinate and adds a pin on the map
    /// - Parameter coordinate: CLLocationCoordinate2D to reverse geocode
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
            
            self.selectedAddressTitle = title
            self.addCustomPin(at: coordinate, title: title)
        }
    }
    
    /// Adds a custom pin annotation on the map
    /// - Parameters:
    ///   - coordinate: CLLocationCoordinate2D for the pin
    ///   - title: Title displayed for the pin
    func addCustomPin(at coordinate: CLLocationCoordinate2D, title: String) {
        mapView.removeAnnotations(mapView.annotations.filter { !($0 is MKUserLocation) })
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        mapView.addAnnotation(annotation)
    }
    
    // MARK: - Address Search
    
    /// Searches for an address string and updates map pin
    /// - Parameter address: Address string to search
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
                let formattedName = [
                    placemark.name,
                    placemark.locality,
                    placemark.administrativeArea,
                    placemark.country
                ]
                .compactMap { $0 }
                .joined(separator: ", ")
                
                self.selectedAddressTitle = formattedName
                self.addCustomPin(at: coordinate, title: formattedName)
                
                let region = MKCoordinateRegion(center: coordinate,
                                                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                self.mapView.setRegion(region, animated: true)
            }
        }
    }
    
    // MARK: - Gesture Handling
    
    /// Handles tap gestures on the map to update pin
    @objc func handleMapTap(_ gestureRecognizer: UITapGestureRecognizer) {
        let locationInView = gestureRecognizer.location(in: mapView)
        let coordinate = mapView.convert(locationInView, toCoordinateFrom: mapView)
        reverseGeocodeAndAddPin(at: coordinate)
    }
    
    // MARK: - Button Actions
    
    /// Handles back button tap, saves selected address, and updates CheckoutViewController
    @objc func btnBackTapped() {
        let finalAddress = selectedAddressTitle ?? "No Address Selected"
        UserDefaults.standard.set(finalAddress, forKey: "lastSelectedAddress")
        UserDefaults.standard.synchronize()
        
        if let checkoutVC = self.navigationController?.viewControllers.first(where: { $0 is CheckoutViewController }) as? CheckoutViewController {
            checkoutVC.addressText = finalAddress
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    /// Starts updating the user's location
    @IBAction func btnRedirectCurrentLocationClick(_ sender: Any) {
        locationManager.startUpdatingLocation()
    }
    
    /// Placeholder for saved address button action
    @IBAction func btnSavedAddressClick(_ sender: Any) {
    }
}
