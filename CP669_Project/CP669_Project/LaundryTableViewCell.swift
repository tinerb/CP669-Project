//
//  LaundryTableViewCell.swift
//  CP669_Project
//


import UIKit

class LaundryTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var clearButton: UIButton!
    
    var cleanAction: (() -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func cleanButtonAction(_ sender: Any) {
        cleanAction?()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
