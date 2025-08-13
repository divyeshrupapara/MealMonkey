import Foundation
import MapKit
import CoreLocation
import UIKit

extension AddressViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            mapView.showsUserLocation = true
            LocationManager.startUpdatingLocation()
        case .denied, .restricted:
            // Optional: show an alert guiding the user to Settings
            break
        case .notDetermined:
            break
        @unknown default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let coordinate = location.coordinate

        // Reverse geocode -> add/replace annotation
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, _ in
            guard let self = self, let placemark = placemarks?.first else { return }

            let addressLine = "\(placemark.name ?? ""), \(placemark.locality ?? ""), \(placemark.administrativeArea ?? "") \(placemark.postalCode ?? "")"

            // Remove previous annotations to avoid stacking
            self.mapView.removeAnnotations(self.mapView.annotations)

            let annotation = LocationAnnotation(
                coordinate: coordinate,
                title: "Your Current Location",
                subtitle: addressLine
            )
            self.mapView.addAnnotation(annotation)

            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            self.mapView.setRegion(region, animated: true)
        }

        // Stop to avoid continuous updates and repeated geocoding
        LocationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: \(error.localizedDescription)")
    }
}

extension AddressViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }

        let identifier = "LocationPin"
        var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKAnnotationView

        if view == nil {
            view = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view?.canShowCallout = true
        } else {
            view?.annotation = annotation
        }

        // Use your asset first; if missing, fall back to a SF Symbol
        view?.image = UIImage(named: "ic_current_position") ?? UIImage(systemName: "mappin.circle.fill")

        // Optional: lift the pin so its tip points at the coordinate
        if let size = view?.image?.size {
            view?.centerOffset = CGPoint(x: 0, y: -size.height/2)
        }

        return view
    }

    // keep your drop animation if you like
    func mapView(_ mapView: MKMapView, didAdd views: [MKAnnotationView]) { /* your existing animation code */ }
}

extension AddressViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let query = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        guard !query.isEmpty else {
            textField.resignFirstResponder()
            return true
        }
        searchAddress(query)
        textField.resignFirstResponder()
        return true
    }
    
    private func searchAddress(_ query: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(query) { [weak self] placemarks, error in
            guard let self = self,
                  let placemark = placemarks?.first,
                  let coordinate = placemark.location?.coordinate else { return }

            // Replace any existing pins
            self.mapView.removeAnnotations(self.mapView.annotations)

            let title = placemark.name ?? "Location"
            let subtitle = [
                placemark.locality,
                placemark.administrativeArea,
                placemark.postalCode
            ].compactMap { $0 }.joined(separator: ", ")

            let annotation = LocationAnnotation(coordinate: coordinate, title: title, subtitle: subtitle)
            self.mapView.addAnnotation(annotation)

            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
            self.mapView.setRegion(region, animated: true)
        }
    }
}

