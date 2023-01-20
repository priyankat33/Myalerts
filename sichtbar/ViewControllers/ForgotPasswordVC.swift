//
//  ForgotPasswordVC.swift
//  sichtbar
//
//  Created by Developer on 30/04/22.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    @IBOutlet weak fileprivate var email:CustomTextField!
    fileprivate var userViewModel:UserViewModel = UserViewModel()
    @IBOutlet weak var lbl:UILabel!
    //let font = UIFont(name: "AvenirNext-Italic", size: 24)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        
        if let font = UIFont(name: "SFUIDisplay-Bold", size: 26) {
            let yourAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: font]
            let yourOtherAttributes = [NSAttributedString.Key.foregroundColor: CustomColor.appThemeColorGreen, NSAttributedString.Key.font: font]
            let partOne = NSMutableAttributedString(string: "Passwort ", attributes: yourAttributes)
            let partTwo = NSMutableAttributedString(string: "vergessen", attributes: yourOtherAttributes)
            let combination = NSMutableAttributedString()
            combination.append(partOne)
            combination.append(partTwo)
            lbl.attributedText = combination
        }
        

        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onClickSubmit(_ sender: UIButton) {
        userViewModel.forgotPassword(sender: self, email: email.text ?? "", onSuccess: {
            
            showAlertWithSingleAction1(sender: self, message: "Das neue Passwort wurde an Ihre E-Mail-Adresse gesendet", onSuccess: {
                self.navigationController?.popViewController(animated: true)
            })
        }, onFailure: {
            
        })
    }
}
