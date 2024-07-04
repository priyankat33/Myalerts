//
//  PlanenVC.swift
//  sichtbar
//
//  Created by Developer on 27/05/22.
//

import UIKit
import StoreKit
class PlanenVC: UIViewController {
   
    
    fileprivate var homeViewModel:HomeViewModel = HomeViewModel()
    @IBOutlet weak var tenView:CustomView!
    @IBOutlet weak var hundredView:CustomView!
    @IBOutlet weak var tenLabel:UILabel!
    @IBOutlet weak var tenLabelAmount:UILabel!
    @IBOutlet weak var hundredLabel:UILabel!
    @IBOutlet weak var hundredLabelAmount:UILabel!
    var expValue:String = ""
    var purchaseValue:String = ""
    var transcationValue:String = ""
    @IBOutlet weak var planLbl:UILabel!
    fileprivate var selectedIndex:Int = 0
    fileprivate var products:[SKProduct] = [SKProduct]()
    fileprivate var productIds:[String] = ["com.10werte", "com.100werte"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeViewModel.getPackageDetail(sender: self, onSuccess: {
            
            if self.homeViewModel.package_id  == "1" {
                self.planLbl.text = "Upgrade Preis"
            } else if  self.homeViewModel.package_id == "2" {
                self.planLbl.text = "Marketeer Version"
            } else if  self.homeViewModel.package_id == "3" {
                self.planLbl.text = "Agency Version"
            }
            CTIAPHandler.shared.setProductIds(ids: self.productIds)
            DispatchQueue.main.async {
                
                CTIAPHandler.shared.fetchAvailableProducts(complition: { [weak self](products)   in
                    showLoader()
                    guard let sSelf = self else {return}
                    sSelf.products = products

                })
            }
            
        }, onFailure: {
            
        })
       
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
       
    }
    
    @IBAction func onClick10(_ button:UIButton) {
        tenView.borderColor = CustomColor.appThemeColorGreen
        hundredView.borderColor = UIColor.lightGray
        tenLabel.textColor = CustomColor.appThemeColorGreen
        tenLabelAmount.textColor = CustomColor.appThemeColorGreen
        hundredLabel.textColor = .darkGray
        hundredLabelAmount.textColor = .black
        selectedIndex = 1
    }
    
    
    @IBAction func onClick100(_ button:UIButton) {
        hundredView.borderColor = CustomColor.appThemeColorGreen
        tenView.borderColor = UIColor.lightGray
        tenLabel.textColor = .darkGray
        tenLabelAmount.textColor = .black
        hundredLabel.textColor = CustomColor.appThemeColorGreen
        hundredLabelAmount.textColor = CustomColor.appThemeColorGreen
        selectedIndex = 0
    }
    
    @IBAction func onClickPlanSelect(_ button:UIButton) {
        
        DispatchQueue.main.async {
            showLoader(status: true)
            CTIAPHandler.shared.purchase(product: self.products[self.selectedIndex]) { (alert, product, transaction) in
                if let tran = transaction, let prod = product, let date = transaction?.transactionDate {
                
                   if self.selectedIndex == 1 {
                       self.planLbl.text = "Marketeer Version"
                   } else {
                       self.planLbl.text = "Agency Version"
                   }
                    
                    self.receiptValidation(onSuccess: {
                        if transcationCode != self.transcationValue {
                            self.homeViewModel.addTranscationDetail(package_start:self.purchaseValue,package_end:self.expValue,package_id: self.selectedIndex == 1 ? "2" : "3", amount_paid: self.selectedIndex == 1 ? "99.00" : "999.00", txn_id: self.transcationValue, sender: self, onSuccess: {
                                transcationCode = self.transcationValue
                                self.homeViewModel.generateCode(sender: self, onSuccess: {
                                    
                                }, onFailure: {
                                    
                                })
                           }, onFailure: {
                               
                           })
                        } else {
                           showLoader()
                        }
                        
                    }, onFailure: {
//                        showLoader()
                    })
                }
              }
        }
        
    }
    
    
    @IBAction func onClickTerm(_ button:UIButton) {
        let vc = homeStoryboard.instantiateViewController(withIdentifier: "KPIDetailVC") as! KPIDetailVC
        vc.urlString = "https://www.my-alerts.app/agb/"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onClickPrivacy(_ button:UIButton) {
        let vc = homeStoryboard.instantiateViewController(withIdentifier: "KPIDetailVC") as! KPIDetailVC
        vc.urlString = "https://www.my-alerts.app/datenschutz/"
        
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func receiptValidation(onSuccess:@escaping()->Void,onFailure:@escaping()->Void) {
            
      
        // SandBox: “https://sandbox.itunes.apple.com/verifyReceipt”
// Live : "https://buy.itunes.apple.com/verifyReceipt"
            let receiptFileURL = Bundle.main.appStoreReceiptURL
            let receiptData = try? Data(contentsOf: receiptFileURL!)
            let recieptString = receiptData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
            let jsonDict: [String: AnyObject] = ["receipt-data" : recieptString! as AnyObject, "password" : "57e73512a2a546efa4e004a300d97b95" as AnyObject]
            do {
               
                let requestData = try JSONSerialization.data(withJSONObject: jsonDict, options: JSONSerialization.WritingOptions.prettyPrinted)
                let storeURL = URL(string: "https://buy.itunes.apple.com/verifyReceipt")!
                var storeRequest = URLRequest(url: storeURL)
                storeRequest.httpMethod = "POST"
                storeRequest.httpBody = requestData
                
                let session = URLSession(configuration: URLSessionConfiguration.default)
                let task = session.dataTask(with: storeRequest, completionHandler: { [weak self] (data, response, error) in
                    
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
                        if let date = self?.getExpirationDateFromResponse(jsonResponse as! NSDictionary).0, let purchaseDate = self?.getExpirationDateFromResponse(jsonResponse as! NSDictionary).1, let transid = self?.getExpirationDateFromResponse(jsonResponse as! NSDictionary).2 {
                            print(date)
                            let dateFormatter = DateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd" //Your New Date format as per requirement change it own
                            let newDate = dateFormatter.string(from: date)
                            let purchase = dateFormatter.string(from: purchaseDate)
                            //pass Date here
                            self?.expValue = newDate
                            self?.purchaseValue = purchase
                            self?.transcationValue = transid
                            onSuccess()
                        }
                    } catch let parseError {
                        onFailure()
                    }
                })
                task.resume()
            } catch let parseError {
                onFailure()
            }
        }
    
    func getExpirationDateFromResponse(_ jsonResponse: NSDictionary) -> (Date?,Date?, String?) {
            
            if let receiptInfo: NSArray = jsonResponse["latest_receipt_info"] as? NSArray {
                
                let lastReceipt = receiptInfo.firstObject as! NSDictionary
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss VV"
                
                if let expiresDate = lastReceipt["expires_date"] as? String, let purchaseDate = lastReceipt["purchase_date"] as? String, let trans = lastReceipt["transaction_id"] as? String {
                    return (formatter.date(from: expiresDate),formatter.date(from: purchaseDate),trans)
                }
                
                return (nil,nil,nil)
            }
            else {
                return (nil,nil,nil)
            }
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
