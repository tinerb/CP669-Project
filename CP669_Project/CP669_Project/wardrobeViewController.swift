//
//  wardrobeViewController.swift
//  CP669_Project
//
//  Created by user926809 on 4/17/21.
//

import UIKit

class wardrobeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var itemList: ItemList?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        SharingList.sharedList.loadClothes()
        itemList = SharingList.sharedList.itemList
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")

        if( !(cell != nil))
        {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        }

        guard let item = itemList?.getClothes().filter( { $0.getIsLaundry() == false })[indexPath.row] else {
            return cell ?? UITableViewCell()
        }
        
        cell?.textLabel?.text = item.getType()
        cell?.imageView?.image = item.getImage()
        return cell ?? UITableViewCell()

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemList?.getClothes().filter( { $0.getIsLaundry() == false }).count ?? 0
    }
}
