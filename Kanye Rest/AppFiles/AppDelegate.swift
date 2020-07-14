import UIKit
import UserNotifications
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let center = UNUserNotificationCenter.current()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        ParseJson().parseQuote(of: "https://api.kanye.rest/", complitionHandler: {
            guard let quote = kanyeQuote.last?.quote else{return}
            NotificationK().sendNatification(of: quote)
        })
        NotificationK().sendNatification(of: "")
        center.requestAuthorization(options: [.alert, .sound]) { (granded, error) in
            if granded{
                print(granded)
            }else{
                guard let error = error else{return}
                print(error.localizedDescription)
            }
            }
        
        return true
    }

    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


