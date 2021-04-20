//
//  LaundryViewController.swift
//  CP669_Project
//


import UIKit

class LaundryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var itemList: ItemList?
    var laundryItems: [Item]  {
        sharingList.itemList?.getClothes().filter( { $0.getIsLaundry() == true }) ?? []
    }
    let sharingList = SharingList.sharedList
    override func viewDidLoad() {
        super.viewDidLoad()
        sharingList.loadClothes()
        itemList = sharingList.itemList
        tableView.reloadData()
    }

    @IBAction func clearBasketAction(_ sender: Any) {
        itemList?.getClothes().forEach({ item in
            item.setisLaundry(isLaundry: false)
        })
        sharingList.saveClothes()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? LaundryTableViewCell else {
            return UITableViewCell()
        }

        let item = laundryItems[indexPath.row]
        cell.typeLabel?.text = item.getType()
        cell.imgView?.image = item.getImage()
        cell.cleanAction = {
            item.setisLaundry(isLaundry: false)
            
            self.itemList?.updateItem(item: item, at: indexPath.row)
            self.sharingList.saveClothes()
            self.tableView.reloadData()
        }
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        laundryItems.count
    }

}
