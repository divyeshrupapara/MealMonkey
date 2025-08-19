import CoreLocation
import MapKit
import UIKit

extension AddressViewController: CLLocationManagerDelegate {
    
    /// Called when location updates are available
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let coordinate = location.coordinate
            
            // Center map on user location
            let region = MKCoordinateRegion(center: coordinate,
                                            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
            
            // Reverse geocode to display address pin
            reverseGeocodeAndAddPin(at: coordinate)
            
            // Stop further updates to save battery
            locationManager.stopUpdatingLocation()
        }
    }
}

extension AddressViewController: MKMapViewDelegate {
    
    /// Returns a custom annotation view for pins
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        
        let identifier = "CustomPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "ic_current_position")
        annotationView?.frame.size = CGSize(width: 30, height: 30)
        
        return annotationView
    }
}

extension AddressViewController: UITextFieldDelegate {
    
    /// Called when return key is pressed on the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let address = textField.text, !address.isEmpty {
            searchAddress(address)
        }
        
        return true
    }
}
