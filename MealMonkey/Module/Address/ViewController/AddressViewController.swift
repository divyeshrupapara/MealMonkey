import UIKit
import MapKit
import CoreLocation

class AddressViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var txtSearchAddress: UITextField!
    @IBOutlet weak var imgStar: UIImageView!
    @IBOutlet weak var btnRedirectCurrentLocation: UIButton!
    @IBOutlet weak var btnSavedAddress: UIButton!
    @IBOutlet weak var tblSavedAddress: UITableView!
    let LocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftAlignedTitleWithBack("Change Address",
                                    target: self,
                                    action: #selector(btnBackTapped)
        )
        
        LocationManager.delegate = self
        LocationManager.desiredAccuracy = kCLLocationAccuracyBest
        LocationManager.requestWhenInUseAuthorization()
        
        mapView.delegate = self
        
        viewStyle(cornerRadius: txtSearchAddress.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [txtSearchAddress])
        
        viewStyle(cornerRadius: imgStar.frame.size.height / 2, borderWidth: 0, borderColor: .systemGray, textField: [imgStar])
        
        setPadding.setPadding(left: 34, right: 34, textfield: [txtSearchAddress])
        
        tblSavedAddress.isHidden = true
    }

    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnRedirectCurrentLocationClick(_ sender: Any) {
        LocationManager.requestLocation()
    }
    
    @IBAction func btnSavedAddressClick(_ sender: Any) {
        tblSavedAddress.isHidden = false
    }
}

class LocationAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}

class CustomLocationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let customAnnotation = newValue as? LocationAnnotation else { return }
            
            // Load custom bubble view from XIB or build programmatically
            let bubble = UILabel()
            bubble.text = "\(customAnnotation.title ?? "")\n\(customAnnotation.subtitle ?? "")"
            bubble.numberOfLines = 0
            bubble.backgroundColor = .orange
            bubble.textColor = .white
            bubble.layer.cornerRadius = 8
            bubble.layer.masksToBounds = true
            bubble.font = .systemFont(ofSize: 14)
            
            addSubview(bubble)
            // Adjust frame & position to match your design
        }
    }
}
