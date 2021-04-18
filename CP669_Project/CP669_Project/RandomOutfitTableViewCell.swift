//
//  RandomOutfitTableViewCell.swift
//  CP669_Project
//

import UIKit

class RandomOutfitTableViewCell: UITableViewCell {

    @IBOutlet weak var clothLabel: UILabel!
    @IBOutlet weak var clothNameLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var clothImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
