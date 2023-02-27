

import Foundation
import UIKit
import CoreLocation
import KRProgressHUD
let kAuthTokenKey   =  "AuthToken"
let kTranscationCode   =  "TranscationCode"
let kUpgrade   =  "upgrade"
let kWalkThrough   =  "WalkThrough"
let kUserDataKey = "UserModel"
let kUserId   =  "user_id"
let kDeviceToken = "device_token"
let kFcmToken = "fcmToken"
let kFirstName  =  "firstName"
let kLastName  =  "lastName"
let kRoleCode = "RoleCode"
var userCoordinate:CLLocationCoordinate2D!
var currentLocation:CLLocation!
let kAppname:String =  "My Alerts"
let kEmail   =  "Email"
let kPassword   =  "Password"

//constant Color
let primaryColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

let secondaryColor = #colorLiteral(red: 0.6412341595, green: 0.7523661256, blue: 0.09531899542, alpha: 1)

var mainStoryboard: UIStoryboard = {
    return UIStoryboard(name: "Main", bundle: Bundle.main)
}()

var homeStoryboard: UIStoryboard = {
    return UIStoryboard(name: "Home", bundle: Bundle.main)
}()
func showLoader(status:Bool = false){
    if status {
        DispatchQueue.main.async {
            KRProgressHUD.set(activityIndicatorViewColors: [secondaryColor,primaryColor])
            KRProgressHUD.show()
        }
    }else{
        DispatchQueue.main.async {
            KRProgressHUD.dismiss()
        }
        
    }
}

enum Server{
    case live
    case local
    var serverType:String{
        switch self {
        case .live:
            return "https://web.my-alerts.app/api/api?callApi="
        case .local:
            return "https://lipawudo.myhostpoint.ch/sichtbar-kpi/api/api?callApi="
        }
        // https://lipawudo.myhostpoint.ch/sichtbar-kpi/
    }
}

struct Platform {
    static let isSimulator: Bool = {
        var isSim = false
#if arch(i386) || arch(x86_64)
        isSim = true
#endif
        return isSim
    }()
    static var isPhone:Bool {
        return UIDevice.current.userInterfaceIdiom == .phone ? true :false
    }
}
//Base URl for the Application
public let baseURL  = Server.live.serverType


func showAlertWithSingleAction1(sender:UIViewController,message:String = "",onSuccess:@escaping()->Void)  {
    
    let alertController = UIAlertController(title: kAppname, message: message, preferredStyle: .alert)
    
    // Create the actions
    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
        UIAlertAction in
        onSuccess()
        
    }
    alertController.addAction(okAction)
    sender.present(alertController, animated: true, completion: nil)
}

func showAlertWithSingleAction(sender:UIViewController,message:String = "")  {
    
    let alertController = UIAlertController(title: kAppname, message: message, preferredStyle: .alert)
    
    // Create the actions
    let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
        UIAlertAction in
        
        
    }
    alertController.addAction(okAction)
    sender.present(alertController, animated: true, completion: nil)
}

func showAlertWithTwoActions(sender:UIViewController,message:String = "",title:String = "",onSuccess:@escaping()->Void)  {
    let alertController = UIAlertController(title: kAppname, message: message, preferredStyle: .alert)
    // Create the actions
    let okAction = UIAlertAction(title: title, style: .destructive) {
        UIAlertAction in
        onSuccess()
    }
    let cancelAction = UIAlertAction(title: "Abbrechen", style: .cancel) {
        UIAlertAction in
    }
    
    // Add the actions
    alertController.addAction(okAction)
    alertController.addAction(cancelAction)
    sender.present(alertController, animated: true, completion: nil)
}
var accessToken:String{
    get{
        guard let accessToken = UserDefaults.NTDefault(objectForKey: kAuthTokenKey) as? String else { return "" }
        return accessToken
    }
    set{
        UserDefaults.NTDefault(setObject: newValue, forKey: kAuthTokenKey )
    }
}

var transcationCode:String{
    get{
        guard let transcationCode = UserDefaults.NTDefault(objectForKey: kTranscationCode) as? String else { return "" }
        return transcationCode
    }
    set{
        UserDefaults.NTDefault(setObject: newValue, forKey: kTranscationCode)
    }
}

var upgradePlan:String {
    get{
        guard let accessToken = UserDefaults.NTDefault(objectForKey: kUpgrade) as? String else { return "" }
        return accessToken
    }
    set{
        UserDefaults.NTDefault(setObject: newValue, forKey: kUpgrade )
    }
}



var isWalkThrough:Bool {
    get{
        guard let accessToken = UserDefaults.NTDefault(objectForKey: kWalkThrough) as? Bool else { return false }
        return accessToken
    }
    set{
        UserDefaults.NTDefault(setObject: newValue, forKey: kWalkThrough )
    }
}

var userID:String {
    get{
        guard let userId = UserDefaults.NTDefault(objectForKey: kUserId) as? String else { return "" }
        return userId
    }
    set{
        UserDefaults.NTDefault(setObject: newValue, forKey: kUserId )
    }
}

var deviceTokenNew:String {
    get{
        guard let userId = UserDefaults.NTDefault(objectForKey: kDeviceToken) as? String else { return "" }
        return userId
    }
    set{
        UserDefaults.NTDefault(setObject: newValue, forKey: kDeviceToken )
    }
}

var fcmToken:String {
    get{
        guard let userId = UserDefaults.NTDefault(objectForKey: kFcmToken) as? String else { return "" }
        return userId
    }
    set{
        UserDefaults.NTDefault(setObject: newValue, forKey: kFcmToken )
    }
}

var firstName:String {
    get{
        guard let userId = UserDefaults.NTDefault(objectForKey: kFirstName) as? String else { return "" }
        return userId
    }
    set{
        UserDefaults.NTDefault(setObject: newValue, forKey: kFirstName )
    }
}

var lastName:String {
    get{
        guard let userId = UserDefaults.NTDefault(objectForKey: kLastName) as? String else { return "" }
        return userId
    }
    set{
        UserDefaults.NTDefault(setObject: newValue, forKey: kLastName )
    }
}


var userModel:UserModel?{
    get{
        guard let model = UserDefaults.NTDefault(UserModel.self, forKey: kUserDataKey) else { return nil }
        return model
    }
    set{
        guard let obj = newValue else { return  }
        UserDefaults.NTDefault(set: obj, forKey: kUserDataKey)
    }
}

