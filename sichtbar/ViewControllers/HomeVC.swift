//
//  HomeVC.swift
//  sichtbar
//
//  Created by Developer on 11/05/22.
//

import UIKit
import Kingfisher
class HomeVC: UIViewController {
    @IBOutlet weak var lbl:UILabel!
    @IBOutlet weak var lbl1:UILabel!
    @IBOutlet weak var notificationLbl:CustomLabel!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var searchActive : Bool = false
    fileprivate var expValue:String = ""
    fileprivate var purchaseValue:String = ""
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var upgradePlan:UIButton!
    fileprivate var homeViewModel:HomeViewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        if let font = UIFont(name: "SFUIDisplay-Bold", size: 26) {
            let yourAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: font]
            let yourOtherAttributes = [NSAttributedString.Key.foregroundColor: CustomColor.appThemeColorGreen, NSAttributedString.Key.font: font]
            let partOne = NSMutableAttributedString(string: "My ", attributes: yourAttributes)
            let partTwo = NSMutableAttributedString(string: "Alerts", attributes: yourOtherAttributes)
            let combination = NSMutableAttributedString()
            combination.append(partOne)
            combination.append(partTwo)
            lbl.attributedText = combination
        }
        
        if let font = UIFont(name: "SFUIDisplay-Bold", size: 26) {
            let yourAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: font]
            let yourOtherAttributes = [NSAttributedString.Key.foregroundColor: CustomColor.appThemeColorGreen, NSAttributedString.Key.font: font]
            let partOne = NSMutableAttributedString(string: "\(firstName) ", attributes: yourAttributes)
            let partTwo = NSMutableAttributedString(string: lastName, attributes: yourOtherAttributes)
            let combination = NSMutableAttributedString()
            combination.append(partOne)
            combination.append(partTwo)
            lbl1.text = firstName
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        getKpi()
    }
    
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        getKpi()
    }
    
    
    
    
    private func getKpi() {
        homeViewModel.getKpi(page: 1, sender: self,  onSuccess: { [self] in
            if self.homeViewModel.package == "2" || self.homeViewModel.package == "1"{
                self.heightConstraint.constant = 210
                self.upgradePlan.isHidden = false
            } else {
                self.heightConstraint.constant = 0
                self.upgradePlan.isHidden = true
            }
            if self.homeViewModel.homeModel.count > 0 {
                self.updateTableView()
            }
            self.updateTableView()
            if self.homeViewModel.notification_count == "0" || self.homeViewModel.notification_count == "" {
                self.notificationLbl.text = ""
                self.notificationLbl.isHidden = true
                
            } else {
                
                self.notificationLbl.text = self.homeViewModel.notification_count
                //let objToBeSent = "\(self.homeViewModel.notification_count)"
               // NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: objToBeSent)
                self.notificationLbl.isHidden = true
                self.navigationController!.tabBarController?.tabBar.items?[1].badgeValue = "\(self.homeViewModel.notification_count)"
            }
            //            self.receiptValidation()
        }, onFailure: {
            if self.homeViewModel.package == "2" || self.homeViewModel.package == "1" {
                self.heightConstraint.constant = 210
                self.upgradePlan.isHidden = false
            } else {
                self.heightConstraint.constant = 0
                self.upgradePlan.isHidden = true
            }
            self.updateTableView()
            if self.homeViewModel.notification_count == "0" || self.homeViewModel.notification_count == "" {
                self.notificationLbl.text = ""
                self.notificationLbl.isHidden = true
            } else {
                self.notificationLbl.text = self.homeViewModel.notification_count
                let objToBeSent = "2"
                NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: objToBeSent)
                
                self.notificationLbl.isHidden = true
            }
            
        })
    }
    
    //    func receiptValidation() {
    //
    //
    //        // SandBox: “https://sandbox.itunes.apple.com/verifyReceipt”
    //
    //            let receiptFileURL = Bundle.main.appStoreReceiptURL
    //            let receiptData = try? Data(contentsOf: receiptFileURL!)
    //            let recieptString = receiptData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
    //            let jsonDict: [String: AnyObject] = ["receipt-data" : recieptString! as AnyObject, "password" : "57e73512a2a546efa4e004a300d97b95" as AnyObject]
    //
    //            do {
    //                let requestData = try JSONSerialization.data(withJSONObject: jsonDict, options: JSONSerialization.WritingOptions.prettyPrinted)
    //                let storeURL = URL(string: "https://sandbox.itunes.apple.com/verifyReceipt")!
    //                var storeRequest = URLRequest(url: storeURL)
    //                storeRequest.httpMethod = "POST"
    //                storeRequest.httpBody = requestData
    //
    //                let session = URLSession(configuration: URLSessionConfiguration.default)
    //                let task = session.dataTask(with: storeRequest, completionHandler: { [weak self] (data, response, error) in
    //
    //                    do {
    //                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
    //                        print("=======>",jsonResponse)
    //                        if let date = self?.getExpirationDateFromResponse(jsonResponse as! NSDictionary).0, let purchaseDate = self?.getExpirationDateFromResponse(jsonResponse as! NSDictionary).1 {
    //                            print(date)
    //                            let dateFormatter = DateFormatter()
    //                            dateFormatter.dateFormat = "yyyy-MM-dd" //Your New Date format as per requirement change it own
    //                            let newDate = dateFormatter.string(from: date)
    //                            let purchase = dateFormatter.string(from: purchaseDate)
    //                            //pass Date here
    //                            self?.expValue = newDate
    //                            self?.purchaseValue = purchase
    //                            print(newDate)
    //                            self?.cancelSubscription(value: 0)
    //                        } else {
    //                            self?.cancelSubscription(value: 1)
    //                        }
    //                    } catch let parseError {
    //                        print(parseError)
    //
    //                    }
    //                })
    //                task.resume()
    //            } catch let parseError {
    //                print(parseError)
    //
    //            }
    //        }
    
    func cancelSubscription(value:Int = 0 )  {
        homeViewModel.cancelSubscription(status: value, sender: self, onSuccess: {
            
        }, onFailure: {
            
        })
    }
    
    func getExpirationDateFromResponse(_ jsonResponse: NSDictionary) -> (Date?,Date?) {
        
        if let receiptInfo: NSArray = jsonResponse["latest_receipt_info"] as? NSArray {
            
            let lastReceipt = receiptInfo.lastObject as! NSDictionary
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss VV"
            
            if let expiresDate = lastReceipt["expires_date"] as? String, let purchaseDate = lastReceipt["purchase_date"] as? String {
                return (formatter.date(from: expiresDate),formatter.date(from: purchaseDate))
            }
            
            return (nil,nil)
        }
        else {
            return (nil,nil)
        }
    }
    
    fileprivate func updateTableView() {
        self.tableView.reloadData()
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func onClickDelete(_ sender:UIButton) {
        
        showAlertWithTwoActions(sender: self, message: "Möchten Sie es wirklich löschen?", title: "Yes", onSuccess: {
            let value = sender.tag
            let id = self.homeViewModel.homeModel[value].id ?? ""
            self.homeViewModel.deleteKpi(kpiId: id, sender: self, onSuccess: {
                if self.searchActive {
                    
                } else {
                    self.homeViewModel.homeModel.remove(at: value)
                }
                self.updateTableView()
            }, onFailure: {
                
            })
        })
    }
    
    @IBAction func onClickUpgrade(_ sender:UIButton) {
        if let tabBarController = self.navigationController?.tabBarController  {
            tabBarController.selectedIndex = 3
        }
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return homeViewModel.numberofRowsSearch()
        } else {
            return homeViewModel.homeModel.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTVC", for: indexPath) as! HomeTVC
        if searchActive {
            let data = homeViewModel.cellForRowAtSearch(indexPath: indexPath)
            cell.lbl1.text = data.kpi_name ?? ""
            cell.scoreLbl.text = "\(data.kpi_score ?? "")"
            cell.imgView.kf.setImage(with: URL(string: data.kpi_icon_link ?? ""), placeholder: nil, options: nil) { result in
                switch result {
                case .success(let value):
                    print("Image: \(value.image). Got from: \(value.cacheType)")
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
            cell.imgViewStatus.kf.setImage(with: URL(string: data.status_icon ?? ""), placeholder: nil, options: nil) { result in
                switch result {
                case .success(let value):
                    print("Image: \(value.image). Got from: \(value.cacheType)")
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
            cell.delteBtn.tag = indexPath.row
            cell.lbl.text = data.kpi_title ?? ""
            //            if data.kpi_type == "1" {
            //                cell.lbl.text = data.domain ?? ""
            //
            //
            //            } else if data.kpi_type == "2" {
            //
            //                cell.lbl.text = data.domain ?? ""
            //
            //            } else if data.kpi_type == "3" {
            //                cell.lbl.text = data.business_name ?? ""
            //
            //            } else if data.kpi_type == "4" {
            //                cell.lbl.text = data.keyword ?? ""
            //
            //            } else if data.kpi_type == "5" {
            //
            //                cell.lbl.text = data.domain ?? ""
            //
            //            } else if data.kpi_type == "6" {
            //
            //                cell.lbl.text = data.domain ?? ""
            //
            //            } else if data.kpi_type == "7" {
            //                cell.lbl.text = data.keyword ?? ""
            //
            //            }
        } else {
            let data = homeViewModel.homeModel[indexPath.row]
            cell.lbl1.text = data.kpi_name ?? ""
            cell.scoreLbl.text = "\(data.kpi_score ?? "")"
            cell.imgView.kf.setImage(with: URL(string: data.kpi_icon_link ?? ""), placeholder: nil, options: nil) { result in
                switch result {
                case .success(let value):
                    print("Image: \(value.image). Got from: \(value.cacheType)")
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
            cell.imgViewStatus.kf.setImage(with: URL(string: data.status_icon ?? ""), placeholder: nil, options: nil) { result in
                switch result {
                case .success(let value):
                    print("Image: \(value.image). Got from: \(value.cacheType)")
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
            cell.delteBtn.tag = indexPath.row
            cell.lbl.text = data.kpi_title ?? ""
            //            if data.kpi_type == "1" {
            //                cell.lbl.text = data.domain ?? ""
            ////                cell.lbl1.text = "Domain Score"
            ////                cell.imgView.image = UIImage(named:"DomainScore")
            //            } else if data.kpi_type == "2" {
            ////                cell.lbl1.text = "Page Speed"
            //                cell.lbl.text = data.domain ?? ""
            //                //cell.imgView.image = UIImage(named:"Page Speed")
            //            } else if data.kpi_type == "3" {
            //                cell.lbl.text = data.business_name ?? ""
            ////                cell.lbl1.text = "Google Reviews"
            ////                cell.imgView.image = UIImage(named:"Google Reviews")
            //            } else if data.kpi_type == "4" {
            //                cell.lbl.text = data.keyword ?? ""
            ////                cell.lbl1.text = "Keyword Ranking"
            ////                cell.imgView.image = UIImage(named:"Keyword Ranking")
            //            } else if data.kpi_type == "5" {
            //               // cell.lbl1.text = "SSL"
            //                cell.lbl.text = data.domain ?? ""
            //                //cell.imgView.image = UIImage(named:"SSL Active")
            //            } else if data.kpi_type == "6" {
            //               // cell.lbl1.text = "Website Online"
            //                cell.lbl.text = data.domain ?? ""
            //               // cell.imgView.image = UIImage(named:"Website Online")
            //            } else if data.kpi_type == "7" {
            //                cell.lbl.text = data.keyword ?? ""
            //               // cell.lbl1.text = "Monatliches Suchvolumen"
            //               // cell.imgView.image = UIImage(named:"Monatliches Suchvolumen")
            //            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchActive {
            let data = homeViewModel.cellForRowAtSearch(indexPath: indexPath)
            let vc = homeStoryboard.instantiateViewController(withIdentifier: "KPIDetailVC") as! KPIDetailVC
            vc.urlString = data.detail_link ?? ""
            vc.id = data.id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let data = homeViewModel.homeModel[indexPath.row]
            let vc = homeStoryboard.instantiateViewController(withIdentifier: "KPIDetailVC") as! KPIDetailVC
            vc.id = data.id ?? ""
            vc.urlString = data.detail_link ?? ""
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


extension HomeVC:UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        self.searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        self.searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        self.searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        homeViewModel.filterhomeModel = homeViewModel.homeModel.filter{($0.domain?.localizedCaseInsensitiveContains(searchText) ?? false || $0.business_name?.localizedCaseInsensitiveContains(searchText) ?? false || $0.keyword?.localizedCaseInsensitiveContains(searchText) ?? false)}
        
        if(homeViewModel.filterhomeModel.count == 0){
            if searchText == "" {
                searchActive = false;
            }else{
                searchActive = true;
            }
            
        } else {
            searchActive = true;
        }
        updateTableView()
    }
}
