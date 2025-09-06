import CoreLocation
import MapKit
import UIKit

extension AddressViewController: CLLocationManagerDelegate {
    
    /// Called when location updates are available
    /// - Parameters:
    ///   - manager: The CLLocationManager instance providing updates.
    ///   - locations: An array of CLLocation objects representing recent location data.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last { /// Get the most recent location
            let coordinate = location.coordinate /// Extract latitude and longitude
            
            // Center map on user location with a small zoom level
            let region = MKCoordinateRegion(center: coordinate,
                                            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            mapView.setRegion(region, animated: true)
            
            // Reverse geocode to display address pin
            reverseGeocodeAndAddPin(at: coordinate)
            
            // Stop further updates to save battery life
            locationManager.stopUpdatingLocation()
        }
    }
}

extension AddressViewController: MKMapViewDelegate {
    
    /// Returns a custom annotation view for pins
    /// - Parameters:
    ///   - mapView: The MKMapView instance requesting the view.
    ///   - annotation: The annotation object to represent.
    /// - Returns: A customized MKAnnotationView for non-user annotations.
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil } /// Default user location - no customization
        
        let identifier = "CustomPin" /// Reuse identifier for annotation view
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil { /// If no reusable view available, create new
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true /// Allow callout when tapped
        } else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: Main.Image.ic_current_position) /// Custom pin image
        annotationView?.frame.size = CGSize(width: 30, height: 30) /// Resize pin image
        annotationView?.centerOffset = CGPoint(x: 0, y: -15) /// Adjust position to center
        
        return annotationView
    }
}

extension AddressViewController: UITextFieldDelegate {
    
    /// Called when return key is pressed on the keyboard
    /// - Parameter textField: The UITextField instance that triggered the event.
    /// - Returns: A Boolean indicating whether the text field should process the return button.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() /// Dismiss keyboard
        
        if let address = textField.text, !address.isEmpty { /// Validate non-empty input
            searchAddress(address) /// Perform address search
        }
        
        return true
    }
}
