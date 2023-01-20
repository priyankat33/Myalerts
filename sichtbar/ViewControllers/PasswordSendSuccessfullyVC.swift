//
//  PasswordSendSuccessfullyVC.swift
//  sichtbar
//
//  Created by Developer on 30/04/22.
//

import UIKit

class PasswordSendSuccessfullyVC: UIViewController {
    var userid:String = "0"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickSubmit(_ sender: UIButton) {
        
            
            let vc = mainStoryboard.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
            vc.userId = userid
            self.navigationController?.pushViewController(vc, animated: true)
        
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
