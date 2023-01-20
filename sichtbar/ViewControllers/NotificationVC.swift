//
//  NotificationVC.swift
//  sichtbar
//
//  Created by Developer on 15/06/22.
//

import UIKit

class NotificationVC: UIViewController {
    fileprivate var homeViewModel:HomeViewModel = HomeViewModel()
    @IBOutlet weak var tableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
            print("Value of notification : ", notification.object ?? "")
        self.navigationController!.tabBarItem.badgeValue = "\(notification.object ?? "")"
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        
        homeViewModel.getNotification(page: 1, sender: self, onSuccess: {
            if self.homeViewModel.notificationModel.count > 0 {
                self.tableView.reloadData()
            }
        }, onFailure: {
            
        })
        
        homeViewModel.markNotification(sender: self, onSuccess: {
            
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

extension NotificationVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.notificationModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TypeTVC1", for: indexPath) as! TypeTVC1
        let data = homeViewModel.notificationModel[indexPath.row]
        cell.lbl.text = data.title ?? ""
        cell.lblDesc.text = data.message ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let date = dateFormatter.date(from: data.created ?? "")
        let dateFormatter2 : DateFormatter = DateFormatter()
        dateFormatter2.dateFormat = "dd MMM, yyyy"
        dateFormatter2.timeZone = .current
        if let value = date {
            cell.lbl1.text  = dateFormatter2.string(from: value)
        }
        return cell
    }
    
}
