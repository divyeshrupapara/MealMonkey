import UIKit

/// Controller to manage user profile details
class ProfileViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var imgProfile: UIImageView! /// Profile image view
    @IBOutlet weak var txtName: UITextField! /// Text field for user's name
    @IBOutlet weak var txtEmail: UITextField! /// Text field for user's email
    @IBOutlet weak var txtMobileNo: UITextField! /// Text field for user's mobile number
    @IBOutlet weak var txtAddress: UITextField! /// Text field for user's address
    @IBOutlet weak var btnSave: UIButton! /// Button to save profile changes
    @IBOutlet weak var btnSignOut: UIButton! /// Button to sign out
    @IBOutlet weak var lblUserName: UILabel! /// Label showing user greeting
    @IBOutlet weak var btnEditProfile: UIButton! /// Button to enable profile editing
    
    // MARK: - Properties
    var currentUser: User? /// Stores the current logged-in user
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        
        /// Adds tap gesture to profile image for image picker
        let imgPicker = UITapGestureRecognizer(target: self, action: #selector(imgTap))
        imgProfile.addGestureRecognizer(imgPicker)
        
        /// Applies corner radius and styles to UI elements
        viewStyle(cornerRadius: imgProfile.frame.size.width/2, borderWidth: 0, borderColor: .systemGray, textField: [imgProfile])
        viewStyle(cornerRadius: 28, borderWidth: 0, borderColor: .systemGray, textField: [txtName, txtEmail, txtAddress, txtMobileNo, btnSave])
        setPadding(textfield: [txtName, txtEmail, txtAddress, txtMobileNo])
        
        /// Sets navigation title and adds cart button
        setLeftAlignedTitle("Profile")
        setCartButton(target: self, action: #selector(btnCartTapped))
        
        /// Loads user data from Core Data
        loadUserData()
        
        btnSaveEnable(isEnabled: false)
    }
    
    // MARK: - Load Data
    /// Fetches user data from CoreData and populates the UI
    func loadUserData() {
        if let email = UserDefaults.standard.string(forKey: "loggedInEmail"),
           let user = CoreDataManager.shared.fetchUser(byEmail: email) {
            
            currentUser = user
            
            /// Populates text fields with user details
            lblUserName.text = "Hi there \(user.name ?? "")!"
            txtName.text = user.name
            txtEmail.text = user.email   /// Email field is likely read-only
            txtMobileNo.text = user.mobile
            txtAddress.text = user.address
            
            /// Sets profile image if available
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
        let storyboard = UIStoryboard(name: Main.StoryBoard.MenuStoryboard, bundle: nil)
        if let VC = storyboard.instantiateViewController(withIdentifier: Main.ViewController.CartViewController) as? CartViewController {
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    /// Adds padding to text fields
    func setPadding(textfield: [UITextField]){
        for item in textfield {
            item.setPadding(left: 34, right: 34)
        }
    }
    
    /// Enables or disables Save button and text fields
    func btnSaveEnable(isEnabled: Bool) {
        btnSave.isHidden = !isEnabled
        txtName.isUserInteractionEnabled = isEnabled
        txtEmail.isUserInteractionEnabled = isEnabled
        txtAddress.isUserInteractionEnabled = isEnabled
        txtMobileNo.isUserInteractionEnabled = isEnabled
    }
    
    /// Saves updated user profile data to Core Data
    @IBAction func btnSaveClick(_ sender: Any) {
        guard let user = currentUser else { return }
        
        let newEmail = txtEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if newEmail.isEmpty {
            UIAlertController.showAlert(
                title: Main.Alert.ProfileViewController.EmailMissing.title,
                message: Main.Alert.ProfileViewController.EmailMissing.message,
                viewController: self
            )
            return
        }
        
        if let existingUser = CoreDataManager.shared.fetchUser(byEmail: newEmail), existingUser != user {
            UIAlertController.showAlert(
                title: Main.Alert.ProfileViewController.EmailExists.title,
                message: Main.Alert.ProfileViewController.EmailExists.message,
                viewController: self
            )
            return
        }
        
        user.name = txtName.text
        user.mobile = txtMobileNo.text
        user.address = txtAddress.text
        user.email = newEmail
        
        if let image = imgProfile.image {
            user.profileImage = image.jpegData(compressionQuality: 0.8)
        }
        
        CoreDataManager.shared.saveContext()
        btnSaveEnable(isEnabled: false)
        
        UIAlertController.showAlert(
            title: Main.Alert.ProfileViewController.UpdateSuccess.title,
            message: Main.Alert.ProfileViewController.UpdateSuccess.message,
            viewController: self
        )
    }
    
    /// Enables profile editing mode
    @IBAction func btnEditProfileClick(_ sender: Any) {
        btnSaveEnable(isEnabled: true)
    }
    
    /// Signs out the user and navigates to Login screen
    @IBAction func btnSignOutClick(_ sender: Any) {
        /// Clears user login state
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        UserDefaults.standard.removeObject(forKey: "loggedInEmail") /// Removes stored email
        
        /// Navigates to Login screen
        let storyboard = UIStoryboard(name: Main.StoryBoard.UserStoryboard, bundle: nil)
        if let loginVC = storyboard.instantiateViewController(withIdentifier: Main.ViewController.LoginViewController) as? LoginViewController {
            
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
    
    /// Handles selected profile image and saves to Core Data
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
