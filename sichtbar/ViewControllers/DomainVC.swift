//
//  DomainVC.swift
//  sichtbar
//
//  Created by Developer on 11/05/22.
//

import UIKit

class DomainVC: UIViewController {
    
    fileprivate var homeViewModel:HomeViewModel = HomeViewModel()
    @IBOutlet weak var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeViewModel.getKpiList(page: 1, sender: self,  onSuccess: {
            if self.homeViewModel.typeResponseModel.count > 0 {
                self.tableView.reloadData()
            }
           
        }, onFailure: {
            
        })
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

extension DomainVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.typeResponseModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TypeTVC", for: indexPath) as! TypeTVC
        let data = homeViewModel.typeResponseModel[indexPath.row]
        cell.lbl.text = data.kpi_name ?? ""
       return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //DomainDetailVC
        let data = homeViewModel.typeResponseModel[indexPath.row]
        let vc = homeStoryboard.instantiateViewController(withIdentifier: "DomainDetailVC") as! DomainDetailVC
        vc.id = data.id ?? ""
        vc.headingName = data.kpi_name ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
