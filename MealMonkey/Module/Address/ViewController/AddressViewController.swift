import UIKit
import MapKit
import CoreLocation

class AddressViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var txtSearchAddress: UITextField!
    @IBOutlet weak var imgStar: UIImageView!
    @IBOutlet weak var btnRedirectCurrentLocation: UIButton!
    @IBOutlet weak var btnSavedAddress: UIButton!
    
    let LocationManager = CLLocationManager()
    var onAddressSelected: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLeftAlignedTitleWithBack("Change Address", target: self, action: #selector(btnBackTapped))

           LocationManager.delegate = self
           LocationManager.desiredAccuracy = kCLLocationAccuracyBest
           LocationManager.requestWhenInUseAuthorization() // ask permission

           mapView.delegate = self
        
           viewStyle(cornerRadius: txtSearchAddress.frame.size.height/2, borderWidth: 0, borderColor: .systemGray, textField: [txtSearchAddress])
           viewStyle(cornerRadius: imgStar.frame.size.height / 2, borderWidth: 0, borderColor: .systemGray, textField: [imgStar])
           setPadding.setPadding(left: 34, right: 34, textfield: [txtSearchAddress])
    }

    @objc func btnBackTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnRedirectCurrentLocationClick(_ sender: Any) {
        LocationManager.startUpdatingLocation()
    }
    
    @IBAction func btnSavedAddressClick(_ sender: Any) {
        userSelectedAddress("My Home, Mumbai, India")
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
    private let bubble = UILabel()

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        setup()
    }
    required init?(coder: NSCoder) { super.init(coder: coder); setup() }

    private func setup() {
        bubble.numberOfLines = 0
        bubble.backgroundColor = .orange
        bubble.textColor = .white
        bubble.font = .systemFont(ofSize: 14)
        bubble.layer.cornerRadius = 8
        bubble.layer.masksToBounds = true
        addSubview(bubble)
        bubble.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bubble.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            bubble.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            bubble.bottomAnchor.constraint(equalTo: topAnchor, constant: -6) // bubble above pin
        ])
        // Optional custom pin image:
        image = UIImage(named: "ic_current_position") ?? UIImage(systemName: "mappin.circle.fill")
    }

    override var annotation: MKAnnotation? {
        willSet {
            if let a = newValue as? LocationAnnotation {
                bubble.text = "\(a.title ?? "")\n\(a.subtitle ?? "")"
            }
        }
    }
}
