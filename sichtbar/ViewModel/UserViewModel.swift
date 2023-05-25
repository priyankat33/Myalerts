//
//  UserViewModel.swift

//

//

import UIKit

class UserViewModel: NSObject {
    
    var message:String = ""
    var userId:String = "0"
    func login(sender:UIViewController,email:String = "",password:String = "",onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
        if  ServerManager.shared.CheckNetwork(sender: sender){
            if email.isEmpty{
                
                showAlertWithSingleAction(sender:sender, message: ValidationMessage.kEmail)
            }else if password.isEmpty{
                
                showAlertWithSingleAction(sender:sender, message: ValidationMessage.kPassword)
            }
            
            else{
                ///let params:[String:Any] = ["user_email":email,"user_pass":password]
                showLoader(status: true)
                let data = "&email=\(email)&password=\(password)&device_token=\(deviceTokenNew)&fcm_device_token=\(fcmToken)&device_type=1"
                
                ServerManager.shared.httpPost(request:  baseURL + API.kLogin + data, params: nil,headers: nil, successHandler: { (responseData:Data,status)  in
                    
                    
                    DispatchQueue.main.async {
                        showLoader()
                        guard let response = responseData.decoder(UserResponseModel1.self) else{return}
                        
                        switch status{
                        case 200:
                            let status = response.status ?? -999
                            if status == 1 {
                                userID = response.data?.userId ?? ""
                                firstName = response.data?.email ?? ""
                                //lastName = response.data?.lastname ?? ""
                                onSuccess()
                            } else {
                                self.message = response.message ?? ""
                                if "Your account is not active" == response.message {
                                    
                                    onFailure()
                                } else {
                                    showAlertWithSingleAction(sender: sender, message: response.message ?? "")
                                    onFailure()
                                }
                                
                            }
                            
                            break
                        default:
                            showAlertWithSingleAction(sender: sender, message: response.message ?? "")
                            
                            onFailure()
                            break
                        }
                    }
                }, failureHandler: { (error) in
                    DispatchQueue.main.async {
                        showLoader()
                        showAlertWithSingleAction(sender: sender, message: error?.localizedDescription ?? "")
                        onFailure()
                    }
                })
            }
        }
    }
    
    
    func resetPassword(sender:UIViewController,userId:String = "",password:String = "",confirmPassword:String = "",onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
        if  ServerManager.shared.CheckNetwork(sender: sender){
            if password.isEmpty{
                
                showAlertWithSingleAction(sender:sender, message: ValidationMessage.kPassword)
            } else if confirmPassword.isEmpty{
                
                showAlertWithSingleAction(sender:sender, message:  ValidationMessage.kConfirmPassword)
            } else if confirmPassword != password{
                
                showAlertWithSingleAction(sender:sender, message:  ValidationMessage.kPasswordNotMatch)
            }
            
            else{
                ///let params:[String:Any] = ["user_email":email,"user_pass":password]
                showLoader(status: true)
                let data = "&password=\(password)&user_id=\(userId)&confirm_password=\(confirmPassword)"
                
                ServerManager.shared.httpPost(request:  baseURL + API.kChangePassword + data, params: nil,headers: nil, successHandler: { (responseData:Data,status)  in
                    
                    
                    DispatchQueue.main.async {
                        showLoader()
                        guard let response = responseData.decoder(UserResponseModel.self) else{return}
                        
                        switch status{
                        case 200:
                            let status = response.status ?? -999
                            if status == 1 {
                                onSuccess()
                            } else {
                                showAlertWithSingleAction(sender: sender, message: response.message ?? "")
                                onFailure()
                            }
                            
                            break
                        default:
                            showAlertWithSingleAction(sender: sender, message: response.message ?? "")
                            
                            onFailure()
                            break
                        }
                    }
                }, failureHandler: { (error) in
                    DispatchQueue.main.async {
                        showLoader()
                        showAlertWithSingleAction(sender: sender, message: error?.localizedDescription ?? "")
                        onFailure()
                    }
                })
            }
        }
    }
    
    func editProfile(image:Any,firstName:String = "",lastName:String = "" ,sender:UIViewController,onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
        if  ServerManager.shared.CheckNetwork(sender: sender){
//            let array = self.set1(data: image)
//            if array.isEmpty{
//                 showLoader()
//                return
//           }
            if firstName.isEmpty{
            
                            showAlertWithSingleAction(sender:sender, message: ValidationMessage.kFirstName)
                        }
//            else if lastName.isEmpty{
//            
//                            showAlertWithSingleAction(sender:sender, message: ValidationMessage.kLastName)
//                        }
            else {
                            let data = "&user_id=\(userID)&firstname=\(firstName )&lastname=\(lastName)"
                            
                            guard let urlString = data.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return  }
                            ServerManager.shared.httpPost(request:  baseURL + API.kEditProfile + urlString , params: nil,headers: nil, successHandler: { (responseData:Data,status)  in
                                DispatchQueue.main.async {
                                    showLoader()
                                    guard let response = responseData.decoder(UserResponseModel.self) else{return}
                                 /**
                                  let status = response.status ?? -999
                                  if status == 1 {
                                      onSuccess()
                                  } else {
                                      showAlertWithSingleAction(sender: sender, message: response.message ?? "")
                                      onFailure()
                                  }
                                  */
                                    switch status{
                                    case 200:
                                        let status = response.status ?? -999
                                        if status == 1 {
                                            showAlertWithSingleAction1(sender: sender, message: response.message ?? "", onSuccess: {
                                                onSuccess()
                                            })
                                            
                                        } else {
                                            showAlertWithSingleAction(sender: sender, message: response.message ?? "")
                                            onFailure()
                                        }
                                        
                                        break
                                    default:
                                        showAlertWithSingleAction(sender: sender, message: response.message ?? "")
                                        
                                        onFailure()
                                        break
                                    }
                                }
                            }, failureHandler: { (error) in
                                DispatchQueue.main.async {
                                    showLoader()
                                    showAlertWithSingleAction(sender: sender, message: error?.localizedDescription ?? "")
                                    onFailure()
                                }
                            })
                        }
            }
    }
    
    func signUp(agency_code:String = "",sender:UIViewController,email:String = "",password:String = "",confirmPassword:String = "",lastName:String = "",onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
        if  ServerManager.shared.CheckNetwork(sender: sender){
//            if firstName.isEmpty{
//
//                showAlertWithSingleAction(sender:sender, message: ValidationMessage.kFirstName)
//            } else if lastName.isEmpty{
//
//                showAlertWithSingleAction(sender:sender, message: ValidationMessage.kLastName)
//            }
             if email.isEmpty{
                
                showAlertWithSingleAction(sender:sender, message: ValidationMessage.kEmail)
            } else if !email.isEmail {
                showAlertWithSingleAction(sender:sender, message: "Bitte gültige E-Mail-Adresse eingeben")
            }
            
//            else if password.isEmpty{
//
//                showAlertWithSingleAction(sender:sender, message: ValidationMessage.kPassword)
//            } else if confirmPassword.isEmpty{
//
//                showAlertWithSingleAction(sender:sender, message: ValidationMessage.kConfirmPassword)
//            } else if confirmPassword != password{
//
//                showAlertWithSingleAction(sender:sender, message: ValidationMessage.kPasswordNotMatch)
//            }
            
            else {
                
                showLoader(status: true)
                
                let data = "&email=\(email)&device_type=1&device_token=\(deviceTokenNew)&fcm_device_token=\(fcmToken)"
                guard let urlString = data.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return  }
                ServerManager.shared.httpPost(request:  baseURL + API.kSignUpNew + urlString, params: nil,headers: nil, successHandler: { (responseData:Data,status)  in
                    
                    DispatchQueue.main.async {
                        showLoader()
                        guard let response = responseData.decoder(SignUpResponseModel.self) else{return}
                        
                        switch status {
                        case 200:
                            let status = response.status ?? -999
                            if status == 1 {
                                userID = "\(response.data?.userId ?? 0)"
                                firstName = email
                                onSuccess()
                            } else {
                                showAlertWithSingleAction(sender: sender, message: response.message ?? "")
                                onFailure()
                            }
                            
                            break
                        default:
                            showAlertWithSingleAction(sender: sender, message: response.message ?? "")
                            
                            onFailure()
                            break
                        }
                    }
                }, failureHandler: { (error) in
                    DispatchQueue.main.async {
                        showLoader()
                        showAlertWithSingleAction(sender: sender, message: error?.localizedDescription ?? "")
                        onFailure()
                    }
                })
            }
        }
    }
    
    
    func getLabelText(sender:UIViewController,onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
        if  ServerManager.shared.CheckNetwork(sender: sender){
            showLoader(status: true)
            
           
            ServerManager.shared.httpPost(request:  baseURL + API.kAgencyCodeLabel, params: nil,headers: nil, successHandler: { (responseData:Data,status)  in
                
                
                DispatchQueue.main.async {
                    showLoader()
                    guard let response = responseData.decoder(UserResponseModel2.self) else{return}
                    
                    switch status {
                    case 200:
                        let status = response.status ?? -999
                        if status == 1 {
                            
                            self.message = response.message ?? ""
                            onSuccess()
                        } else {
                            showAlertWithSingleAction(sender: sender, message: response.message ?? "")
                            onFailure()
                        }
                        
                        break
                    default:
                        showAlertWithSingleAction(sender: sender, message: response.message ?? "")
                        
                        onFailure()
                        break
                    }
                }
            }, failureHandler: { (error) in
                DispatchQueue.main.async {
                    showLoader()
                    showAlertWithSingleAction(sender: sender, message: error?.localizedDescription ?? "")
                    onFailure()
                }
            })
            
        }
    }
    
    
    func onDeleteAccount(sender:UIViewController,onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
        if  ServerManager.shared.CheckNetwork(sender: sender){
            showLoader(status: true)
            let data = "&id=\(userID)"
            guard let urlString = data.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return  }
            ServerManager.shared.httpPost(request:  baseURL + API.kDeleteAccount + urlString, params: nil,headers: nil, successHandler: { (responseData:Data,status)  in
                
                
                DispatchQueue.main.async {
                    showLoader()
                    guard let response = responseData.decoder(UserResponseModel2.self) else{return}
                    
                    switch status {
                    case 200:
                        let status = response.status ?? -999
                        if status == 1 {
                            userModel = response.data
                            
                            onSuccess()
                        } else {
                            showAlertWithSingleAction(sender: sender, message: response.message ?? "")
                            onFailure()
                        }
                        
                        break
                    default:
                        showAlertWithSingleAction(sender: sender, message: response.message ?? "")
                        
                        onFailure()
                        break
                    }
                }
            }, failureHandler: { (error) in
                DispatchQueue.main.async {
                    showLoader()
                    showAlertWithSingleAction(sender: sender, message: error?.localizedDescription ?? "")
                    onFailure()
                }
            })
            
        }
    }
    
    
    func getProfile(sender:UIViewController,onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
        if  ServerManager.shared.CheckNetwork(sender: sender){
            showLoader(status: true)
            let data = "&user_id=\(userID)"
            guard let urlString = data.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return  }
            ServerManager.shared.httpPost(request:  baseURL + API.kProfileInfo + urlString, params: nil,headers: nil, successHandler: { (responseData:Data,status)  in
                
                
                DispatchQueue.main.async {
                    showLoader()
                    guard let response = responseData.decoder(UserResponseModel2.self) else{return}
                    
                    switch status {
                    case 200:
                        let status = response.status ?? -999
                        if status == 1 {
                            userModel = response.data
                            
                            onSuccess()
                        } else {
                            showAlertWithSingleAction(sender: sender, message: response.message ?? "")
                            onFailure()
                        }
                        
                        break
                    default:
                        showAlertWithSingleAction(sender: sender, message: response.message ?? "")
                        
                        onFailure()
                        break
                    }
                }
            }, failureHandler: { (error) in
                DispatchQueue.main.async {
                    showLoader()
                    showAlertWithSingleAction(sender: sender, message: error?.localizedDescription ?? "")
                    onFailure()
                }
            })
            
        }
    }
    
    func otpVerification(sender:UIViewController,email:String = "",otp:String = "",onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
        if  ServerManager.shared.CheckNetwork(sender: sender){
            if otp.isEmpty{
                showAlertWithSingleAction(sender:sender, message: ValidationMessage.kOTP)
            } else if otp.count != 4 {
                showAlertWithSingleAction(sender:sender, message: "Bitte geben Sie alle Ziffern des OTPs ein")
            }
            
            else {
                
                showLoader(status: true)
                let data = "&email=\(email)&otp=\(otp)"
                ServerManager.shared.httpPost(request:  baseURL + API.kVerifyEmail + data, params: nil,headers: nil, successHandler: { (responseData:Data,status)  in
                    
                    
                    DispatchQueue.main.async {
                        showLoader()
                        guard let response = responseData.decoder(UserResponseModel.self) else{return}
                        
                        switch status {
                        case 200:
                            let status = response.status ?? -999
                            if status == 1 {
                                onSuccess()
                            } else {
                                showAlertWithSingleAction(sender: sender, message: response.message ?? "")
                                onFailure()
                            }
                            
                            break
                        default:
                            showAlertWithSingleAction(sender: sender, message: response.message ?? "")
                            
                            onFailure()
                            break
                        }
                    }
                }, failureHandler: { (error) in
                    DispatchQueue.main.async {
                        showLoader()
                        showAlertWithSingleAction(sender: sender, message: error?.localizedDescription ?? "")
                        onFailure()
                    }
                })
            }
        }
    }
    
    
    func resendOtp(sender:UIViewController,email:String = "",onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
        if  ServerManager.shared.CheckNetwork(sender: sender){
            showLoader(status: true)
            let data = "&email=\(email)"
            ServerManager.shared.httpPost(request:  baseURL + API.kResendOTP + data, params: nil,headers: nil, successHandler: { (responseData:Data,status)  in
                
                
                DispatchQueue.main.async {
                    showLoader()
                    guard let response = responseData.decoder(UserResponseModel.self) else{return}
                    
                    switch status {
                    case 200:
                        let status = response.status ?? -999
                        if status == 1 {
                            onSuccess()
                        } else {
                            showAlertWithSingleAction(sender: sender, message: response.message ?? "")
                            onFailure()
                        }
                        
                        break
                    default:
                        showAlertWithSingleAction(sender: sender, message: response.message ?? "")
                        
                        onFailure()
                        break
                    }
                }
            }, failureHandler: { (error) in
                DispatchQueue.main.async {
                    showLoader()
                    showAlertWithSingleAction(sender: sender, message: error?.localizedDescription ?? "")
                    onFailure()
                }
            })
            
        }
    }
    
    func veriftAgencyCode(sender:UIViewController,code:String = "",onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
        if  ServerManager.shared.CheckNetwork(sender: sender){
            showLoader(status: true)
            let data = "&user_id=\(userID)&agency_code=\(code)"
            ServerManager.shared.httpPost(request:  baseURL + API.kVerifyAgencyCode + data, params: nil,headers: nil, successHandler: { (responseData:Data,status)  in
                
                
                DispatchQueue.main.async {
                    showLoader()
                    guard let response = responseData.decoder(UserResponseModel.self) else{return}
                    
                    switch status {
                    case 200:
                        let status = response.status ?? -999
                        if status == 1 {
                            onSuccess()
                        } else {
                            showAlertWithSingleAction(sender: sender, message: response.message ?? "")
                            onFailure()
                        }
                        
                        break
                    default:
                        showAlertWithSingleAction(sender: sender, message: response.message ?? "")
                        
                        onFailure()
                        break
                    }
                }
            }, failureHandler: { (error) in
                DispatchQueue.main.async {
                    showLoader()
                    showAlertWithSingleAction(sender: sender, message: error?.localizedDescription ?? "")
                    onFailure()
                }
            })
            
        }
    }
    
    func forgotPassword(sender:UIViewController,email:String = "",onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
        if  ServerManager.shared.CheckNetwork(sender: sender) {
            if email.isEmpty{
                
                showAlertWithSingleAction(sender:sender, message: ValidationMessage.kEmail)
            }
            else{
                let data = "&email=\(email)"
                showLoader(status: true)
                
                ServerManager.shared.httpPost(request:  baseURL + API.kForgotPassword + data, params: nil,headers: nil, successHandler: { (responseData:Data,status)  in
                    DispatchQueue.main.async {
                        showLoader()
                        guard let response = responseData.decoder(UserResponseModel1.self) else{return}
                        
                        switch status{
                        case 200:
                            
                            let status = response.status ?? -999
                            if status == 1 {
                                self.userId = response.data?.userId ?? "0"
                                onSuccess()
                            } else {
                                showAlertWithSingleAction(sender: sender, message: response.message ?? "")
                                onFailure()
                            }
                            
                            break
                        default:
                            showAlertWithSingleAction(sender: sender, message: response.message ?? "")
                            
                            onFailure()
                            break
                        }
                    }
                }, failureHandler: { (error) in
                    DispatchQueue.main.async {
                        showLoader()
                        showAlertWithSingleAction(sender: sender, message: error?.localizedDescription ?? "")
                        onFailure()
                    }
                })
            }
        }
    }
    
    fileprivate func set1(data:Any)->[MultipartData]{
           let dataFormate:DataFormate = .multipart
           let dataType:DataType!
           let uploadKey = "profile_image"
           if let image = data as? UIImage {
               dataType = DataType.image(image: image, fileName: nil, uploadKey: uploadKey, formate: .jpeg(quality: .medium))
           }else if let url = data as? URL{
               dataType =  DataType.file(file: url, uploadKey: uploadKey)
           }else if let filePath = data as? String{
               dataType =  DataType.file(file: filePath, uploadKey: uploadKey)
           }else{
               return []
           }

           return [dataFormate.result(dataType: dataType) as! MultipartData]
       }
    
        func logout(sender:UIViewController,onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
            if  ServerManager.shared.CheckNetwork(sender: sender){
    
                let data = "&user_id=\(userID)"
                guard let urlString = data.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return  }
                showLoader(status: true)
                ServerManager.shared.httpPost(request:  baseURL + API.kLogout + urlString, params: nil,headers: nil, successHandler: { (responseData:Data,status)  in
                    
                    
                    DispatchQueue.main.async {
                        showLoader()
                        guard let response = responseData.decoder(UserResponseModel2.self) else{return}
                        
                        switch status {
                        case 200:
                            let status = response.status ?? -999
                            if status == 1 {
                                userModel = response.data
                                
                                onSuccess()
                            } else {
                                showAlertWithSingleAction(sender: sender, message: response.message ?? "")
                                onFailure()
                            }
                            
                            break
                        default:
                            showAlertWithSingleAction(sender: sender, message: response.message ?? "")
                            
                            onFailure()
                            break
                        }
                    }
                }, failureHandler: { (error) in
                    DispatchQueue.main.async {
                        showLoader()
                        showAlertWithSingleAction(sender: sender, message: error?.localizedDescription ?? "")
                        onFailure()
                    }
                })
    
            }
        }
}

