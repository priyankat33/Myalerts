//
//  HomeTVC.swift
//  sichtbar
//
//  Created by Developer on 11/05/22.
//

import UIKit

class HomeTVC: UITableViewCell {
    @IBOutlet weak var lbl:UILabel!
    @IBOutlet weak var delteBtn:UIButton!
    
    @IBOutlet weak var lbl1:UILabel!
    @IBOutlet weak var scoreLbl:UILabel!
    @IBOutlet weak var imgView:UIImageView!
    @IBOutlet weak var imgViewStatus:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


class TypeTVC: UITableViewCell {
    @IBOutlet weak var lbl:UILabel!
    
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



class TypeTVC1: UITableViewCell {
    @IBOutlet weak var lbl:UILabel!
    @IBOutlet weak var lbl1:UILabel!
    @IBOutlet weak var lblDesc:UILabel!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
