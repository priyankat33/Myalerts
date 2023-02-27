//
//  ProfileVC.swift
//  sichtbar
//
//  Created by Developer on 06/05/22.
//

import UIKit

class ProfileVC: UIViewController {
    @IBOutlet weak var lbl:UILabel!
    @IBOutlet weak var lblCode:UILabel!
    @IBOutlet weak var countLbl:UILabel!
    @IBOutlet weak var viewHide:UIView!
    @IBOutlet weak var imgView:CustomImageView!
    @IBOutlet weak var btn:UIButton!
    @IBOutlet weak var btnCode:UIButton!
    @IBOutlet weak fileprivate var heightConstraint: NSLayoutConstraint!
    
    fileprivate var userViewModel:UserViewModel = UserViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        userViewModel.getLabelText(sender: self, onSuccess: {
            self.lblCode.text = self.userViewModel.message
        }, onFailure: {
            
        })
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userViewModel.getProfile(sender: self, onSuccess: {
            if let font = UIFont(name: "SFUIDisplay-Bold", size: 26) {
                let yourAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: font]
                let yourOtherAttributes = [NSAttributedString.Key.foregroundColor: CustomColor.appThemeColorGreen, NSAttributedString.Key.font: font]
                let partOne = NSMutableAttributedString(string: "\(userModel?.firstName ?? "") ", attributes: yourAttributes)
                let partTwo = NSMutableAttributedString(string: userModel?.lastName ?? "", attributes: yourOtherAttributes)
                let combination = NSMutableAttributedString()
                combination.append(partOne)
                combination.append(partTwo)
                self.lbl.attributedText = combination
                let code = userModel?.agency_code ?? ""
                if code != "0" {
                    self.btnCode.setTitle("Agenturcode: \(userModel?.agency_code ?? "")", for: .normal)
                    self.btnCode.isHidden = false
                } else {
                    self.btnCode.isHidden = true
                }
                self.countLbl.text = "\(userModel?.kpi_count ?? "")/\(userModel?.kpi_limit ?? "")"
                
                if userModel?.package ?? "" == "1" {
                    self.viewHide.isHidden = false
                    self.heightConstraint.constant = 55.0
                    self.btn.isUserInteractionEnabled = true
                    self.btn.setTitle("Upgrade Preis", for: .normal)
                    
                } else if userModel?.package ?? "" == "2" {
                    self.viewHide.isHidden = true
                    self.heightConstraint.constant = 0
                    self.btn.isUserInteractionEnabled = false
                    self.btn.setTitle("Marketeer Version", for: .normal)
                    
                } else if userModel?.package ?? "" == "3" {
                    self.viewHide.isHidden = true
                    self.heightConstraint.constant = 0.0
                    self.btn.isUserInteractionEnabled = false
                    self.btn.setTitle("Agency Version", for: .normal)
                   
                }
            }
        }, onFailure: {
            
        })
    }
    
    @IBAction func onClickLogout(_ sender: UIButton) {
        showAlertWithTwoActions(sender: self,message: "Are you sure you want to Ausloggen?",title: "Ausloggen", onSuccess: {
            SceneDelegate().logout(self.view)
        })
      }
    
    
    @IBAction func onClickDelete(_ sender: UIButton) {
        showAlertWithTwoActions(sender: self,message: "Are you sure you want to Konto löschen?",title: "Konto", onSuccess: {
            self.userViewModel.onDeleteAccount(sender: self, onSuccess: {
                SceneDelegate().logout(self.view)
            }, onFailure: {
                
            })
        })
      }
    
    
    @IBAction func addButtonClicked(_ sender: UIButton){
        let alertController = UIAlertController(title: "Agenturcode hinzufügen", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Code eingeben"
        }
        let saveAction = UIAlertAction(title: "Erledigt", style: .default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            let value = firstTextField.text ?? ""
            if !value.isEmpty {
                self.userViewModel.veriftAgencyCode(sender: self, code: value, onSuccess: {
                    showAlertWithSingleAction(sender: self, message: "Agenturcode geprüft")
                }, onFailure: {
                    showAlertWithSingleAction(sender: self, message: "Agenturcode nicht verifiziert")
                })
            }
        })
        let cancelAction = UIAlertAction(title: "Abbrechen", style: .cancel, handler: { (action : UIAlertAction!) -> Void in })
        

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func onClickMail(_ sender: UIButton) {
        let email = "info@my-alerts.app"
        if let url = URL(string: "mailto:\(email)") {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }
    }
    
    @IBAction func onClickPlanType(_ sender: UIButton) {
        if let tabBarController = self.navigationController?.tabBarController  {
                tabBarController.selectedIndex = 3
            }
    }
}
