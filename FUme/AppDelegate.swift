import UIKit
// Parse and ParseFacebookUtils imported in FUme-Bridging-Header.h

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Parse.enableLocalDatastore()
        Parse.setApplicationId("w1ZIivF1cjxqLnpwDPW2IC3lifzTlpL6RxJFS5VM", clientKey: "0N4TpsWNaCKZNn0JueQvz7Gm4F7A2Th0ofTmB0r1")
        // PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        
        if application.respondsToSelector(Selector("registerUserNotificationSettings:")) {
            let userNotificationTypes: UIUserNotificationType = ([UIUserNotificationType.Alert, UIUserNotificationType.Badge, UIUserNotificationType.Sound])
            
            let settings = UIUserNotificationSettings(forTypes: userNotificationTypes, categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        }
        
        //UIImage.
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "yourImage.png"))

        //
//        UINavigationBar.appearance().barTintColor = UIColor(red: 234.0/255.0, green: 46.0/255.0, blue: 73.0/255.0, alpha: 0.0)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]

//        UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
//        UINavigationBar.appearance().shadowImage = UIImage()
//        UINavigationBar.appearance().translucent = true
        
        //UIView.appearance().backgroundColor = UIColor.purpleColor()
//        UINavigationBar.appearance().setBackgroundImage(UIImage(named: "LaunchBG"),forBarMetrics: .Default)
        
       // UIView.appearance().backgroundColor = UIColor.purpleColor()
        
       // UIImage(named: "navbar"

   
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    // Mark - Push Notification methods
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let installation = PFInstallation.currentInstallation()
        installation.setDeviceTokenFromData(deviceToken)
        installation.saveInBackgroundWithBlock { (succeeed: Bool, error: NSError!) -> Void in
            if error != nil {
                print("didRegisterForRemoteNotificationsWithDeviceToken")
                print(error)
            }
        }
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("didFailToRegisterForRemoteNotificationsWithError")
        print(error)
    }
    
    // TODO: Rewrite this method with notifications
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
//        let delay = 4.0 * Double(NSEC_PER_SEC)
//        var time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
//        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
//            MessagesViewController.refreshMessagesView()
//        }
        
        NSNotificationCenter.defaultCenter().postNotificationName("reloadMessages", object: nil)
    }

}

