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
    var coats: [Item] = []
    var shirts: [Item] = []
    var pants: [Item] = []
    var shorts: [Item] = []
    var tshirts: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.register(UINib(nibName: "RandomOutfitTableViewCell", bundle: nil), forCellReuseIdentifier: "RandomOutfitTableViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        SharingList.sharedList.loadClothes()
        itemList = SharingList.sharedList.itemList
        coats = (itemList?.getClothes().filter({ $0.getType() == "coat" }))!
        pants = (itemList?.getClothes().filter({ $0.getType() == "pants" }))!
        shorts = (itemList?.getClothes().filter({ $0.getType() == "shorts" }))!
        shirts = (itemList?.getClothes().filter({ $0.getType() == "shirt" }))!
        tshirts = (itemList?.getClothes().filter({ $0.getType() == "t-shirt" }))!

        if itemList!.getWeather() < 40{
            if let randomIndex = coats.indices.randomElement() {
                let element = coats[randomIndex]
                self.randomIndices.append(randomIndex)
                randomItem.append(element)
            }
        }
        if itemList!.getWeather() > 60{
            if let randomIndex = tshirts.indices.randomElement() {
                let element = tshirts[randomIndex]
                self.randomIndices.append(randomIndex)
                randomItem.append(element)
            }
            if let randomIndex = shorts.indices.randomElement() {
                let element = shorts[randomIndex]
                self.randomIndices.append(randomIndex)
                randomItem.append(element)
            }
        }
        else if itemList!.getWeather() < 60{
            if let randomIndex = shirts.indices.randomElement() {
                let element = shirts[randomIndex]
                self.randomIndices.append(randomIndex)
                randomItem.append(element)
            }
            if let randomIndex = pants.indices.randomElement() {
                let element = pants[randomIndex]
                self.randomIndices.append(randomIndex)
                randomItem.append(element)
            }
        }
        
        tableView.reloadData()
    }
    
    @IBAction func confirmButtonAction(_ sender: Any) {
        for (_, value) in randomItem.enumerated() {
            value.setisLaundry(isLaundry: true)
            for i in 0...(itemList?.getClothes().count)!{
                if itemList?.getClothes()[i].getImage() == value.getImage() && itemList?.getClothes()[i].getType() == value.getType() && itemList?.getClothes()[i].getColour() == value.getColour() && itemList?.getClothes()[i].getDesc() == value.getDesc(){
                    itemList?.updateItem(item: value, at: i)
                    break
                }
            }
        }
        
        SharingList.sharedList.saveClothes()

        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func refreshButtonAction(_ sender: Any) {
        randomItem = []
        randomIndices = []
        if itemList!.weather < 40{
            if let randomIndex = coats.indices.randomElement() {
                let element = coats[randomIndex]
                self.randomIndices.append(randomIndex)
                randomItem.append(element)
            }
        }
        if itemList!.weather > 60{
            if let randomIndex = tshirts.indices.randomElement() {
                let element = tshirts[randomIndex]
                self.randomIndices.append(randomIndex)
                randomItem.append(element)
            }
            if let randomIndex = shorts.indices.randomElement() {
                let element = shorts[randomIndex]
                self.randomIndices.append(randomIndex)
                randomItem.append(element)
            }
        }
        else if itemList!.weather < 60{
            if let randomIndex = shirts.indices.randomElement() {
                let element = shirts[randomIndex]
                self.randomIndices.append(randomIndex)
                randomItem.append(element)
            }
            if let randomIndex = pants.indices.randomElement() {
                let element = pants[randomIndex]
                self.randomIndices.append(randomIndex)
                randomItem.append(element)
            }
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
