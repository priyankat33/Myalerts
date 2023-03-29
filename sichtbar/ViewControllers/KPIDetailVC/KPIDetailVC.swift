//
//  KPIDetailVC.swift
//  sichtbar
//
//  Created by Developer on 17/05/22.
//

import UIKit
import WebKit
class KPIDetailVC: UIViewController {
    var urlString:String = ""
    var id:String = ""
    fileprivate var homeViewModel:HomeViewModel = HomeViewModel()
    @IBOutlet weak var webView:WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: urlString)
        let request = URLRequest(url: url!)
        
        webView.navigationDelegate = self
        webView.load(request)
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

}

extension KPIDetailVC: WKNavigationDelegate {

    @IBAction func onClickDelete(_ sender:UIButton) {
        
        showAlertWithTwoActions(sender: self, message: "Möchten Sie es wirklich löschen?", title: "Ja", onSuccess: {
            
            
            self.homeViewModel.deleteKpi(kpiId: self.id, sender: self, onSuccess: {
                self.navigationController?.popViewController(animated: true)
                
            }, onFailure: {
                
            })
        })
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showLoader(status: true)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showLoader(status: false)
        webView.evaluateJavaScript("document.body.innerText") { result, error in
                
                }
            }
        

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
        showLoader(status: false)
    }
}

