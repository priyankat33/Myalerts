//
//  DomainDetailVC.swift
//  sichtbar
//
//  Created by Developer on 15/05/22.
//

import UIKit
import WebKit
class DomainDetailVC: UIViewController {
    var id:String = ""
    @IBOutlet weak var webView:WKWebView!
    @IBOutlet weak var lbl:UILabel!
    var headingName:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let myURLString = "https://web.my-alerts.app/dashboard/add-kpi?user_id=\(userID)&kpi_type=\(id)&mobile=true"
        let url = URL(string: myURLString)
        let request = URLRequest(url: url!)
        lbl.text = headingName
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

extension DomainDetailVC: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showLoader(status: true)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showLoader(status: false)
        webView.evaluateJavaScript("document.body.innerText") { result, error in
                if let resultString = result as? String,
                    resultString.contains("erfolgreich") {
                    self.navigationController?.popToRootViewController(animated: true)
                    }
                }
            }
        

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
        showLoader(status: false)
    }
}
