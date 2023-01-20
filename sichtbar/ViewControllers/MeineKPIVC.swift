//
//  MeineKPIVC.swift
//  sichtbar
//
//  Created by Developer on 11/05/22.
//

import UIKit

class MeineKPIVC: UIViewController {
    @IBOutlet weak var lbl:UILabel!
    @IBOutlet weak var tableView:UITableView!
    var searchActive : Bool = false
    @IBOutlet weak var searchBar: UISearchBar!
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
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getKpi()
    }
    
    func getKpi() {
        homeViewModel.getKpi(page: 1, sender: self,  onSuccess: {
          self.tableView.reloadData()
        }, onFailure: {
            self.tableView.reloadData()
        })
    }

    @IBAction func onClickDelete(_ sender:UIButton) {
        
        showAlertWithTwoActions(sender: self, message: "Möchten Sie es wirklich löschen?", title: "Yes", onSuccess: {
            let value = sender.tag
            let id = self.homeViewModel.homeModel[value].id ?? ""
            self.homeViewModel.deleteKpi(kpiId: id, sender: self, onSuccess: {
                self.getKpi()
            }, onFailure: {
                
            })
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

extension MeineKPIVC: UITableViewDelegate, UITableViewDataSource {
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
////                cell.lbl1.text = "Domain Score"
////                cell.imgView.image = UIImage(named:"DomainScore")
//            } else if data.kpi_type == "2" {
//                //cell.lbl1.text = "Page Speed"
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
//              //  cell.imgView.image = UIImage(named:"SSL Active")
//            } else if data.kpi_type == "6" {
//               // cell.lbl1.text = "Website Online"
//                cell.lbl.text = data.domain ?? ""
//               // cell.imgView.image = UIImage(named:"Website Online")
//            } else if data.kpi_type == "7" {
//                cell.lbl.text = data.keyword ?? ""
////                cell.lbl1.text = "Monatliches Suchvolumen"
////                cell.imgView.image = UIImage(named:"Monatliches Suchvolumen")
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
//               //. cell.lbl1.text = "Page Speed"
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
//                //cell.lbl1.text = "Website Online"
//                cell.lbl.text = data.domain ?? ""
//              //  cell.imgView.image = UIImage(named:"Website Online")
//            } else if data.kpi_type == "7" {
//                cell.lbl.text = data.keyword ?? ""
////                cell.lbl1.text = "Monatliches Suchvolumen"
////                cell.imgView.image = UIImage(named:"Monatliches Suchvolumen")
//            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchActive {
            let data = homeViewModel.cellForRowAtSearch(indexPath: indexPath)
            let vc = homeStoryboard.instantiateViewController(withIdentifier: "KPIDetailVC") as! KPIDetailVC
            vc.urlString = data.detail_link ?? ""
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let data = homeViewModel.homeModel[indexPath.row]
            let vc = homeStoryboard.instantiateViewController(withIdentifier: "KPIDetailVC") as! KPIDetailVC
            vc.urlString = data.detail_link ?? ""
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension MeineKPIVC:UISearchBarDelegate{
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
        self.tableView.reloadData()
    }
}
