//
//  LoginVC.swift
//  sichtbar
//
//  Created by Developer on 29/04/22.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var lbl:UILabel!
    //let font = UIFont(name: "AvenirNext-Italic", size: 24)!
    @IBOutlet weak fileprivate var email:CustomTextField!
    @IBOutlet weak fileprivate var password:CustomTextField!
    fileprivate var userViewModel:UserViewModel = UserViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpVC
        self.navigationController?.pushViewController(vc, animated: true)
//        if !isWalkThrough {
//            
//            let desiredStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            if let walkThroughVC = (desiredStoryboard.instantiateViewController(withIdentifier: "WalkThroughVC") as? WalkThroughVC) {
//                walkThroughVC.modalPresentationStyle = .fullScreen
//                self.present(walkThroughVC, animated: false, completion: nil)
//            }
//        }
        
        if let font = UIFont(name: "SFUIDisplay-Bold", size: 26) {
            let yourAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: font]
            let yourOtherAttributes = [NSAttributedString.Key.foregroundColor: CustomColor.appThemeColorGreen, NSAttributedString.Key.font: font]
            let partOne = NSMutableAttributedString(string: "Willkommen ", attributes: yourAttributes)
            let partTwo = NSMutableAttributedString(string: "zurück", attributes: yourOtherAttributes)

            let combination = NSMutableAttributedString()

            combination.append(partOne)
            combination.append(partTwo)
            lbl.attributedText = combination
        }
        

        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickLogin(_ sender: UIButton) {
        userViewModel.login(sender: self, email: email.text ?? "", password: password.text ?? "", onSuccess: {
            SceneDelegate().setUpHome(self.view)
            
        }, onFailure: {
//            if self.userViewModel.message == "Your account is not active" {
//                let vc = mainStoryboard.instantiateViewController(withIdentifier: "OTPVerificationVC") as! OTPVerificationVC
//                vc.email = self.email.text ?? ""
//                self.navigationController?.pushViewController(vc, animated: true)
//            } else {
//
//            }
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
