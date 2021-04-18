//
//  RandomOutfitViewController.swift
//  CP669_Project
//

import UIKit

class RandomOutfitViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var randomItem: [Item] = []

    var itemList: ItemList?
    var randomIndices: [Int] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.register(UINib(nibName: "RandomOutfitTableViewCell", bundle: nil), forCellReuseIdentifier: "RandomOutfitTableViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        _ = SharingList()
        itemList = SharingList.sharedList.itemList

        if let randomIndex = itemList?.getClothes().indices.randomElement(), let element = itemList?.getClothes()[randomIndex]  {
            self.randomIndices.append(randomIndex)
            randomItem.append(element)
        }
        
        if let randomIndex = itemList?.getClothes().indices.randomElement(), let element = itemList?.getClothes()[randomIndex]  {
            self.randomIndices.append(randomIndex)
            randomItem.append(element)
        }
        
        tableView.reloadData()
    }
    
    @IBAction func confirmButtonAction(_ sender: Any) {
        for (index, value) in randomItem.enumerated() {
            value.setisLaundry(isLaundry: true)
            itemList?.updateItem(item: value, at: self.randomIndices[index])
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func refreshButtonAction(_ sender: Any) {
        randomItem = []
        randomIndices = []
        if let randomIndex = itemList?.getClothes().indices.randomElement(), let element = itemList?.getClothes()[randomIndex]  {
            self.randomIndices.append(randomIndex)
            randomItem.append(element)
        }
        
        if let randomIndex = itemList?.getClothes().indices.randomElement(), let element = itemList?.getClothes()[randomIndex]  {
            self.randomIndices.append(randomIndex)
            randomItem.append(element)
        }
        
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RandomOutfitTableViewCell") as? RandomOutfitTableViewCell else {
            return UITableViewCell()
        }

        let item = randomItem[indexPath.row]
        cell.colorLabel.text = item.getColour()
        cell.descLabel.text = item.getDesc()
        cell.clothImageView.image = item.getImage()
        cell.clothNameLabel.text = item.getType()
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        randomItem.count
    }
    
}
