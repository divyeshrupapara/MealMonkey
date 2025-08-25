import UIKit

/// SceneDelegate is responsible for managing the app's UI lifecycle when multiple scenes (windows) are used.
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    /// The main window for displaying app content.
    var window: UIWindow?

    /// Called when a new scene (UI window) is being created and connected to the app.
    /// - Parameters:
    ///   - scene: The scene being connected.
    ///   - session: The session associated with this scene.
    ///   - connectionOptions: Additional options for configuring the scene.
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Configure and attach the UIWindow to the provided UIWindowScene.
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    /// Called when the scene is disconnected from the app (released by the system).
    /// This occurs shortly after the scene enters the background or its session is discarded.
    func sceneDidDisconnect(_ scene: UIScene) {
        // Release resources and prepare for scene reconnection if needed.
    }

    /// Called when the scene becomes active from an inactive state.
    /// Restart tasks that were paused (or not yet started) when the scene was inactive.
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Resume operations when scene becomes active.
    }

    /// Called when the scene will move from active to inactive state.
    /// This may happen during temporary interruptions (e.g., incoming call).
    func sceneWillResignActive(_ scene: UIScene) {
        // Pause ongoing tasks as the scene becomes inactive.
    }

    /// Called as the scene moves from background to foreground.
    /// Use this method to reverse changes made when entering the background.
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Prepare UI when coming back to the foreground.
    }

    /// Called as the scene transitions from foreground to background.
    /// Save data, release shared resources, and store enough state information for restoration.
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Save app state and resources when moving to background.
    }
}
