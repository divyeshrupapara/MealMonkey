import UIKit

/// Controller to manage user profile details
class ProfileViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMobileNo: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnSignOut: UIButton!
    @IBOutlet weak var lblUserName: UILabel!
    
    // MARK: - Properties
    var currentUser: User?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        
        // Enable tapping on profile image
        let imgPicker = UITapGestureRecognizer(target: self, action: #selector(imgTap))
        imgProfile.addGestureRecognizer(imgPicker)
        
        // Apply styles to UI elements
        viewStyle(cornerRadius: imgProfile.frame.size.width/2, borderWidth: 0, borderColor: .systemGray, textField: [imgProfile])
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [txtName, txtEmail, txtAddress, txtMobileNo, btnSave])
        setPadding(textfield: [txtName, txtEmail, txtAddress, txtMobileNo])
        
        setLeftAlignedTitle("Profile")
        setCartButton(target: self, action: #selector(btnCartTapped))
        
        // Load saved user data
        loadUserData()
    }
    
    // MARK: - Load Data
    /// Fetches user data from CoreData and populates the UI
    func loadUserData() {
        if let email = UserDefaults.standard.string(forKey: "loggedInEmail"),
           let user = CoreDataManager.shared.fetchUser(byEmail: email) {
            
            currentUser = user
            
            // Fill text fields
            lblUserName.text = "Hi there \(user.name ?? "")!"
            txtName.text = user.name
            txtEmail.text = user.email   // probably read-only
            txtMobileNo.text = user.mobile
            txtAddress.text = user.address
            
            // Load profile image if saved
            if let imageData = user.profileImage {
                imgProfile.image = UIImage(data: imageData)
            }
        }
    }
    
    // MARK: - Actions
    /// Opens image picker for changing profile picture
    @objc func imgTap() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = true
        present(pickerController, animated: true)
    }
    
    /// Opens Cart screen
    @objc func btnCartTapped() {
        let storyboard = UIStoryboard(name: "MenuStoryboard", bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    /// Adds padding to text fields
    func setPadding(textfield: [UITextField]){
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    
    /// Saves updated user profile data
    @IBAction func btnSaveClick(_ sender: Any) {
        guard let user = currentUser else { return }
           
           // Get the updated email from the text field
           let newEmail = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
           
           // Check if email is empty
           if newEmail.isEmpty {
               UIAlertController.showAlert(title: "Error", message: "Email cannot be empty.", viewController: self)
               return
           }
           
           // Check if this email is already registered with another user
           if let existingUser = CoreDataManager.shared.fetchUser(byEmail: newEmail), existingUser != user {
               UIAlertController.showAlert(title: "Email Exists", message: "This email is already registered with another account.", viewController: self)
               return
           }
           
           // Update the user details
           user.name = txtName.text
           user.mobile = txtMobileNo.text
           user.address = txtAddress.text
           user.email = newEmail
           
           // Update profile image
           if let image = imgProfile.image {
               user.profileImage = image.jpegData(compressionQuality: 0.8)
           }
           
           // Save changes to Core Data
           CoreDataManager.shared.saveContext()
           
        UIAlertController.showAlert(title: "Success", message: "Profile updated successfully!", viewController: self)
    }
    
    /// Signs out the user and returns to Login screen
    @IBAction func btnSignOutClick(_ sender: Any) {
        // Clear login state
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: "loggedInEmail") // clear stored email
        
        // Redirect to Login screen
        let storyboard = UIStoryboard(name: "UserStoryboard", bundle: nil)
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate {
                
                let navController = UINavigationController(rootViewController: loginVC)
                sceneDelegate.window?.rootViewController = navController
                sceneDelegate.window?.makeKeyAndVisible()
            }
        }
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /// Handles selected profile image
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.editedImage] as? UIImage {
            imgProfile.image = image
            currentUser?.profileImage = image.jpegData(compressionQuality: 0.8)
            CoreDataManager.shared.saveContext()
        }
        dismiss(animated: true)
    }
}
