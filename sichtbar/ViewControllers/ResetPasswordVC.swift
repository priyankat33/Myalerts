//
//  ResetPasswordVC.swift
//  sichtbar
//
//  Created by Developer on 30/04/22.
//

import UIKit

class ResetPasswordVC: UIViewController {

    @IBOutlet weak var lbl:UILabel!
    var userId:String = ""
    var isFromProfile:Bool = false
    
    @IBOutlet weak fileprivate var confirmPassword:CustomTextField!
    @IBOutlet weak fileprivate var password:CustomTextField!
    @IBOutlet weak fileprivate var backButton:UIButton!
    fileprivate var userViewModel:UserViewModel = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isFromProfile {
            backButton.isHidden = false
        }else {
            backButton.isHidden = true
        }
        
        if let font = UIFont(name: "SFUIDisplay-Bold", size: 26) {
            let yourAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: font]
            let yourOtherAttributes = [NSAttributedString.Key.foregroundColor: CustomColor.appThemeColorGreen, NSAttributedString.Key.font: font]
            let partOne = NSMutableAttributedString(string: "Passwort ", attributes: yourAttributes)
            let partTwo = NSMutableAttributedString(string: "zurücksetzen", attributes: yourOtherAttributes)
            let combination = NSMutableAttributedString()
            combination.append(partOne)
            combination.append(partTwo)
            lbl.attributedText = combination
        }
        

        
        // Do any additional setup after loading the view.
    }

    @IBAction func onClickResetPassword(_ sender: UIButton) {
        userViewModel.resetPassword(sender: self, userId: userId, password: password.text ?? "", confirmPassword: confirmPassword.text ?? "", onSuccess: {
            showAlertWithSingleAction1(sender: self, message: "Passwort erfolgreich zurückgesetzt", onSuccess: {
                if self.isFromProfile {
                    SceneDelegate().logout(self.view)
                }else {
                    self.navigationController?.popToRootViewController(animated: true)
                }
                
            })
        }, onFailure: {
            
        })
    }

}
