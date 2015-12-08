import UIKit
import Alamofire

class WelcomeViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = true
//        self.navigationBar.barStyle = UIBarStyle.Black
//        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
//        self.navigationBar.tintColor = UIColor.whiteColor()
        // Do any additional setup after loading the view, typically from a nib.
        //self.view.backgroundColor = UIColor.purpleColor()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        
    func processFacebook(user: PFUser, userData: [String: AnyObject]) {
        let facebookUserId = userData["id"] as! String
        var link = "http://graph.facebook.com/\(facebookUserId)/picture"
        let url = NSURL(string: link)
        var request = NSURLRequest(URL: url!)
        let params = ["height": "200", "width": "200", "type": "square"]
        Alamofire.request(.GET, link, parameters: params).response() {
            (request, response, data, error) in
            
            if error == nil {
                var image = UIImage(data: data! as! NSData)!
                
                if image.size.width > 280 {
                    image = Images.resizeImage(image, width: 280, height: 280)!
                }
                var filePicture = PFFile(name: "picture.jpg", data: UIImageJPEGRepresentation(image, 0.6))
                filePicture.saveInBackgroundWithBlock({ (success: Bool, error: NSError!) -> Void in
                    if error != nil {
                        ProgressHUD.showError("Error saving photo")
                    }
                })
                
                if image.size.width > 60 {
                    image = Images.resizeImage(image, width: 60, height: 60)!
                }
                var fileThumbnail = PFFile(name: "thumbnail.jpg", data: UIImageJPEGRepresentation(image, 0.6))
                fileThumbnail.saveInBackgroundWithBlock({ (success: Bool, error: NSError!) -> Void in
                    if error != nil {
                        ProgressHUD.showError("Error saving thumbnail")
                    }
                })
                
                
                if (userData["email"] == nil ) {
                    user[PF_USER_EMAILCOPY] = NSNull();
                }else{
                    user[PF_USER_EMAILCOPY] = userData["email"];
                }
                user[PF_USER_FULLNAME] = userData["name"]
                user[PF_USER_FULLNAME_LOWER] = (userData["name"] as! String).lowercaseString
                user[PF_USER_FACEBOOKID] = userData["id"]
                user[PF_USER_PICTURE] = filePicture
                user[PF_USER_THUMBNAIL] = fileThumbnail
                user.saveInBackgroundWithBlock({ (succeeded: Bool, error: NSError!) -> Void in
                    if error == nil {
                        self.userLoggedIn(user)
                    } else {
                        PFUser.logOut()
                        let info = error!.userInfo
                        ProgressHUD.showError("Login error")
                        print(info["error"] as! String)
                        
                    }
                })
            } else {
                PFUser.logOut()
                let info = error!.userInfo 
                ProgressHUD.showError("Failed to fetch Facebook photo")
                print(info["error"] as! String)
                
            }
        }
    }
    
    func userLoggedIn(user: PFUser) {
        PushNotication.parsePushUserAssign()
        ProgressHUD.showSuccess("Welcome back, \(user[PF_USER_FULLNAME])!")
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
