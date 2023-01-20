//
//  GetProfileVC.swift
//  sichtbar
//
//  Created by Developer on 06/05/22.
//

import UIKit

class GetProfileVC: UIViewController {
    fileprivate var viewModel:UserViewModel = UserViewModel()
    @IBOutlet weak var lblName:UILabel!
    @IBOutlet weak var imgView:CustomImageView!
    @IBOutlet weak var lblEmail:UILabel!
    fileprivate var selectedImageValue:Bool = false
    var image:UIImage = UIImage()
    var imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        lblName.text = "\(userModel?.firstName ?? "") \(userModel?.lastName ?? "")"
        lblEmail.text = userModel?.email ?? ""
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
    
    @IBAction func onClickResetPassword(_ sender:UIButton) {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ResetPasswordVC") as! ResetPasswordVC
        vc.userId = userID
        vc.isFromProfile = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickCamera(_ sender:UIButton) {
       myImagePicker()
     }

    
    @IBAction func onClickEdit(_ sender:UIButton) {
//        viewModel.editProfile(image: image, sender: self, onSuccess: {
//
//        }, onFailure: {
//
//        })
    }
}

extension GetProfileVC:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
     fileprivate func myImagePicker() {
         let pickerView = UIImagePickerController()
         pickerView.delegate = self
         pickerView.sourceType = .photoLibrary
         
         
         let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
         let cameraAction = UIAlertAction(title: "Open Camera", style: UIAlertAction.Style.default) {
             UIAlertAction in
             self.openCamera()
         }
         let gallaryAction = UIAlertAction(title: "Open Media Library", style: UIAlertAction.Style.default) {
             UIAlertAction in
             self.openGallery()
         }
         let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
             UIAlertAction in
         }
         
         if let popoverController = alert.popoverPresentationController {
             popoverController.sourceView = self.view
             popoverController.sourceRect =  CGRect.init(x: self.view.center.x + 50 , y: 75, width: 20, height: 20)
         }
         alert.addAction(cameraAction)
         alert.addAction(gallaryAction)
         alert.addAction(cancelAction)
         alert.view.tintColor = CustomColor.appThemeColor
         self.present(alert, animated: true, completion: nil)
     }
    
    
    
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self .present(imagePicker, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Warning", message: "You don't have camera" , preferredStyle: .actionSheet)
            let secondAction = UIAlertAction(title: "OK", style: .default, handler: {(_ action: UIAlertAction?) -> Void in
                
            })
            alert.addAction(secondAction)
            self.present(alert, animated: true)
        }
    }
    
    func openGallery() {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
    
        if let editedImage = info[.editedImage] as? UIImage {
           
            self.imgView.image = editedImage
            image = editedImage
            selectedImageValue = true
            picker.dismiss(animated: true, completion: nil)
        } else if let originalImage = info[.originalImage] as? UIImage {
            self.imgView.image = originalImage
            image = originalImage
            selectedImageValue = true
            picker.dismiss(animated: true, completion: nil)
        }
       
    }
}
