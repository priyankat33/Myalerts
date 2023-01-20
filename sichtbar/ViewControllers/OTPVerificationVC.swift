//
//  OTPVerificationVC.swift
//  sichtbar
//
//  Created by Developer on 30/04/22.
//

import UIKit

class OTPVerificationVC: UIViewController {
    @IBOutlet weak fileprivate var tf1:CustomTextField!
    @IBOutlet weak fileprivate var tf2:CustomTextField!
    @IBOutlet weak fileprivate var tf3:CustomTextField!
    @IBOutlet weak fileprivate var tf4:CustomTextField!
    @IBOutlet weak var lbl:UILabel!
    @IBOutlet weak var lblHeading:UILabel!
    var email:String = ""
    fileprivate var userViewModel:UserViewModel = UserViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
         
        
        if let font = UIFont(name: "SFUIDisplay-Bold", size: 26) {
            let yourAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: font]
            let yourOtherAttributes = [NSAttributedString.Key.foregroundColor: CustomColor.appThemeColorGreen, NSAttributedString.Key.font: font]
            let partOne = NSMutableAttributedString(string: "Code ", attributes: yourAttributes)
            let partTwo = NSMutableAttributedString(string: "überprüfen", attributes: yourOtherAttributes)
            let combination = NSMutableAttributedString()
            combination.append(partOne)
            combination.append(partTwo)
            lbl.attributedText = combination
        }
        lblHeading.text = "überprüfen Sie lhre E-Mail-Adresse, die wir gesendet haben Sie den Code an \(email)"
        

        
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
    
    @IBAction fileprivate func textFieldDidChanged(_ sender: CustomTextField) {
        let text = sender.text
        if text?.utf16.count == 1{
            switch sender{
            case tf1:
                tf2.becomeFirstResponder()
            case tf2:
                tf3.becomeFirstResponder()
            case tf3:
                tf4.becomeFirstResponder()
            case tf4:
                tf4.resignFirstResponder()
            default:
                break
            }
            
            
        }
        else if text?.utf16.count == 0{
            switch sender{
            case tf1:
                tf1.resignFirstResponder()
            case tf2:
                tf1.becomeFirstResponder()
            case tf3:
                tf2.becomeFirstResponder()
            case tf4:
                tf3.becomeFirstResponder()
            default:
                break
            }
           
        }
        else  {
            
        }
    }
    
    @IBAction func onClickVerification(_ sender: UIButton) {
        
        let data = tf1.text!  + tf2.text!  +  tf3.text!  + tf4.text!
        userViewModel.otpVerification(sender: self, email: email, otp: data, onSuccess: {
            showAlertWithSingleAction1(sender: self, message: "Email Verified Successfully", onSuccess: {
                self.navigationController?.popToRootViewController(animated: true)
            })
        }, onFailure: {
            
        })
    }
    
    @IBAction func onClickResend(_ sender: UIButton) {
        userViewModel.resendOtp(sender: self, email: email, onSuccess: {
            showAlertWithSingleAction1(sender: self, message: "OTP sent Successfully", onSuccess: {
                
            })
        }, onFailure: {
            
        })
    }

}
