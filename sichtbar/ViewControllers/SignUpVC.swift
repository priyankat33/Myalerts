//
//  SignUpVC.swift
//  sichtbar
//
//  Created by Developer on 28/04/22.
//

import UIKit

class SignUpVC: UIViewController {
    @IBOutlet weak fileprivate var firstName:CustomTextField!
    @IBOutlet weak fileprivate var latName:CustomTextField!
    @IBOutlet weak fileprivate var email:CustomTextField!
    @IBOutlet weak fileprivate var confirmPassword:CustomTextField!
    @IBOutlet weak fileprivate var password:CustomTextField!
    @IBOutlet weak fileprivate var code:CustomTextField!
    fileprivate var userViewModel:UserViewModel = UserViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        userViewModel.getLabelText(sender: self, onSuccess: {
            self.code.placeholder =  self.userViewModel.message
        }, onFailure: {
            
        })
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickSignUp(_ sender: UIButton) {
        userViewModel.signUp(agency_code:code.text ?? "",sender: self, email: email.text ?? "", password: password.text ?? "", confirmPassword: confirmPassword.text ?? "", lastName: latName.text  ?? "", onSuccess: {
            
//            let vc = mainStoryboard.instantiateViewController(withIdentifier: "OTPVerificationVC") as! OTPVerificationVC
//            vc.email = self.email.text ?? ""
//            self.navigationController?.pushViewController(vc, animated: true)
            SceneDelegate().setUpHome(self.view)
        }, onFailure: {
            
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
