//
//  HomeViewModel.swift
//  sichtbar
//
//  Created by Developer on 11/05/22.
//

import UIKit

class HomeViewModel: NSObject {

    var homeModel:[HomeModel] = [HomeModel]()
    var notificationModel:[NotificationModel] = [NotificationModel]()
    var filterhomeModel:[HomeModel] = [HomeModel]()
    
    var package: String = ""
    var notification_count: String = ""
    var package_id:String = ""
    var typeResponseModel:[TypeModel] = [TypeModel]()
   
    func setDomain(sender:UIViewController,website:String = "",onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
        if  ServerManager.shared.CheckNetwork(sender: sender){
            if website.isEmpty{
                
                showAlertWithSingleAction(sender:sender, message: "Bitte Name der Website eingeben")
            }
            
            else{
                ///let params:[String:Any] = ["user_email":email,"user_pass":password]
                showLoader(status: true)
                let data = "&user_id=\(userID)&kpi_type=\(1)&domain=\(website)"
                
                ServerManager.shared.httpPost(request:  baseURL + API.kAddKpi + data, params: nil,headers: nil, successHandler: { (responseData:Data,status)  in
                    
                    
                    DispatchQueue.main.async {
                        showLoader()
                        guard let response = responseData.decoder(UserResponseModel1.self) else{return}
                        
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
    
    func getKpi(page:Int = 1,sender:UIViewController,onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
        if  ServerManager.shared.CheckNetwork(sender: sender){

           ///let params:[String:Any] = ["user_email":email,"user_pass":password]
                showLoader(status: true)
                let data = "&user_id=\(userID)&page=\(1)"
                
                ServerManager.shared.httpPost(request:  baseURL + API.kKpiListing + data, params: nil,headers: nil, successHandler: { (responseData:Data,status)  in
                    self.homeModel.removeAll()
                    
                    DispatchQueue.main.async {
                        showLoader()
                        guard let response = responseData.decoder(HomeResponseModel.self) else{return}
                        
                        switch status{
                        case 200:
                            let status = response.status ?? -999
                            if status == 1 {
                                self.package = response.package ?? ""
                                self.notification_count = response.notification_count ?? ""
                                self.homeModel = response.data
//                                self.filterhomeModel = response.data
                                onSuccess()
                            } else {
                                self.package = response.package ?? ""
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
    
    
    func getPackageDetail(sender:UIViewController,onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
        if  ServerManager.shared.CheckNetwork(sender: sender){

                showLoader(status: true)
                let data = "&user_id=\(userID)"
                
                ServerManager.shared.httpPost(request:  baseURL + API.kGetUserPackage + data, params: nil,headers: nil, successHandler: { (responseData:Data,status)  in
                    
                    
                    DispatchQueue.main.async {
                        
                        guard let response = responseData.decoder(PlanResponseModel.self) else{return}
                        
                        switch status{
                        case 200:
                            let status = response.status ?? -999
                            if status == 1 {
                                self.package_id = response.data?.package_id ?? ""
                              
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
    
    
    func generateCode( sender:UIViewController,onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
        if  ServerManager.shared.CheckNetwork(sender: sender){

    showLoader(status: true)
                let data = "&user_id=\(userID)"
                
                ServerManager.shared.httpPost(request:  baseURL + API.kGenerateAgencyCode + data, params: nil,headers: nil, successHandler: { (responseData:Data,status)  in
                    
                    
                    DispatchQueue.main.async {
                        showLoader()
                        guard let response = responseData.decoder(PlanResponseModel.self) else{return}
                        
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
    
    
    func addTranscationDetail(package_start:String,package_end:String,package_id:String = "",amount_paid:String = "",txn_id:String = "", sender:UIViewController,onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
        if  ServerManager.shared.CheckNetwork(sender: sender){

    showLoader(status: true)
                let data = "&user_id=\(userID)&package_id=\(package_id)&amount_paid=\(amount_paid)&package_start=\(package_start)&package_end=\(package_end)&txn_id=\(txn_id)"
                
                ServerManager.shared.httpPost(request:  baseURL + API.kAddUserPackage + data, params: nil,headers: nil, successHandler: { (responseData:Data,status)  in
                    
                    
                    DispatchQueue.main.async {
                        showLoader()
                        guard let response = responseData.decoder(PlanResponseModel.self) else{return}
                        
                        switch status{
                        case 200:
                            let status = response.status ?? -999
                            if status == 1 {
                                self.package_id = response.data?.package_id ?? ""
                              
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
    
    func cancelSubscription(status:Int = 0, sender:UIViewController,onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
        if  ServerManager.shared.CheckNetwork(sender: sender){

                showLoader(status: true)
                let data = "&user_id=\(userID)&is_cancelled=\(status)"
                
                ServerManager.shared.httpPost(request:  baseURL + API.kCancelUserPackage + data, params: nil,headers: nil, successHandler: { (responseData:Data,status)  in
                    
                    
                    DispatchQueue.main.async {
                        showLoader()
                        guard let response = responseData.decoder(PlanResponseModel.self) else{return}
                        
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
    
    
    func getNotification(page:Int = 1,sender:UIViewController,onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
        if  ServerManager.shared.CheckNetwork(sender: sender){

           
                ///let params:[String:Any] = ["user_email":email,"user_pass":password]
                showLoader(status: true)
                let data = "&user_id=\(userID)&page=\(1)"
                
                ServerManager.shared.httpPost(request:  baseURL + API.kNotification + data, params: nil,headers: nil, successHandler: { (responseData:Data,status)  in
                    
                    
                    DispatchQueue.main.async {
                        showLoader()
                        guard let response = responseData.decoder(NotificationResponseModel.self) else{return}
                        
                        switch status{
                        case 200:
                            let status = response.status ?? -999
                            if status == 1 {
                                
                                self.notificationModel = response.data
//                                self.filterhomeModel = response.data
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
    
    func markNotification(sender:UIViewController,onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
        if  ServerManager.shared.CheckNetwork(sender: sender){
 ///let params:[String:Any] = ["user_email":email,"user_pass":password]
                showLoader(status: true)
                let data = "&user_id=\(userID)"
                
                ServerManager.shared.httpPost(request:  baseURL + API.kMarkNotificationSeen + data, params: nil,headers: nil, successHandler: { (responseData:Data,status)  in
                    
                    
                    DispatchQueue.main.async {
                        showLoader()
                        guard let response = responseData.decoder(NotificationResponseModel.self) else{return}
                        
                        switch status{
                        case 200:
                            let status = response.status ?? -999
                            if status == 1 {
                                onSuccess()
                            } else {
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
    
    func deleteKpi(kpiId:String = "",sender:UIViewController,onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
        if  ServerManager.shared.CheckNetwork(sender: sender){

           
                ///let params:[String:Any] = ["user_email":email,"user_pass":password]
                showLoader(status: true)
                let data = "&id=\(kpiId)"
                
                ServerManager.shared.httpPost(request:  baseURL + API.kDeleteKpi + data, params: nil,headers: nil, successHandler: { (responseData:Data,status)  in
                    
                    
                    DispatchQueue.main.async {
                        showLoader()
                        guard let response = responseData.decoder(HomeResponseModel.self) else{return}
                        
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
    
    
    func getKpiList(page:Int = 1,sender:UIViewController,onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
        if  ServerManager.shared.CheckNetwork(sender: sender){

           
                ///let params:[String:Any] = ["user_email":email,"user_pass":password]
                showLoader(status: true)
                let data = "&page=\(page)"
                
                ServerManager.shared.httpPost(request:  baseURL + API.kKpiTypesListing + data, params: nil,headers: nil, successHandler: { (responseData:Data,status)  in
                    
                    
                    DispatchQueue.main.async {
                        showLoader()
                        guard let response = responseData.decoder(TypeResponseModel.self) else{return}
                        
                        switch status{
                        case 200:
                            let status = response.status ?? -999
                            if status == 1 {
                                
                                self.typeResponseModel = response.data
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

extension HomeViewModel {
    func numberofRowsSearch() -> Int {
        return filterhomeModel.count
    }
    func cellForRowAtSearch(indexPath:IndexPath) -> HomeModel {
           return filterhomeModel[indexPath.row]
       }
}
