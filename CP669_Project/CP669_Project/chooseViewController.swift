//
//  chooseViewController.swift
//  CP669_Project
//
//  Created by user926809 on 4/19/21.
//

import UIKit

class chooseViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource {

    

    @IBOutlet weak var topTypePicker: UIPickerView!
    @IBOutlet weak var topColourPicker: UIPickerView!
    @IBOutlet weak var bottomTypePicker: UIPickerView!
    @IBOutlet weak var bottomColourPicker: UIPickerView!
    @IBOutlet weak var table: UITableView!
    
    var chosenItem: [Item] = []
    var itemList: ItemList?
    var chosenIndices: [Int] = []
    var coats: [Item] = []
    var shirts: [Item] = []
    var pants: [Item] = []
    var shorts: [Item] = []
    var tshirts: [Item] = []
    
    var colour = ["white", "black", "red", "yellow", "orange", "purple", "pink", "green"]
    var topType = ["shirt", "t-shirt", "coat"]
    var bottomType = ["pants", "shorts"]
    
    var topSelectedColour: String = ""
    var topSelectedType: String = ""
    var bottomSelectedColour: String = ""
    var bottomSelectedType: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.register(UINib(nibName: "RandomOutfitTableViewCell", bundle: nil), forCellReuseIdentifier: "RandomOutfitTableViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        _ = SharingList()
        itemList = SharingList.sharedList.itemList
        coats = (itemList?.getClothes().filter({ $0.getType() == "coat" }))!
        pants = (itemList?.getClothes().filter({ $0.getType() == "pants" }))!
        shorts = (itemList?.getClothes().filter({ $0.getType() == "shorts" }))!
        shirts = (itemList?.getClothes().filter({ $0.getType() == "shirt" }))!
        tshirts = (itemList?.getClothes().filter({ $0.getType() == "t-shirt" }))!
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == topColourPicker || pickerView == bottomColourPicker {
            return colour.count
        } else if pickerView == topTypePicker {
            return topType.count
        } else if pickerView == bottomTypePicker {
            return bottomType.count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == topColourPicker  || pickerView == bottomColourPicker  {
            let titleRow = colour[row]
            return titleRow
        } else if pickerView == topTypePicker {
            let titleRow = topType[row]
            return titleRow
        } else if pickerView == bottomTypePicker {
            let titleRow = bottomType[row]
            return titleRow
        }
        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == topColourPicker {
            self.topSelectedColour = self.colour[row]
        } else if pickerView == bottomColourPicker {
            self.bottomSelectedColour = self.colour[row]
        } else if pickerView == topTypePicker {
            self.topSelectedType = self.topType[row]
        } else if pickerView == bottomTypePicker {
            self.bottomSelectedType = self.bottomType[row]
        }
    }
    
    @IBAction func genrateButton(_ sender: Any) {
        chosenItem = []
        chosenIndices = []
        if topSelectedType == "coat"{
            if let randomIndex = coats.filter({ $0.getColour() == topSelectedColour }).indices.randomElement() {
                let element = coats.filter({ $0.getColour() == topSelectedColour })[randomIndex]
                self.chosenIndices.append(randomIndex)
                chosenItem.append(element)
            }
        } else if topSelectedType == "shirt"{
            if let randomIndex = shirts.filter({ $0.getColour() == topSelectedColour }).indices.randomElement() {
                let element = shirts.filter({ $0.getColour() == topSelectedColour })[randomIndex]
                self.chosenIndices.append(randomIndex)
                chosenItem.append(element)
            }
        } else if topSelectedType == "t-shirt"{
            if let randomIndex = tshirts.filter({ $0.getColour() == topSelectedColour }).indices.randomElement() {
                let element = tshirts.filter({ $0.getColour() == topSelectedColour })[randomIndex]
                self.chosenIndices.append(randomIndex)
                chosenItem.append(element)
            }
        }
        if bottomSelectedType == "pants"{
            if let randomIndex = pants.filter({ $0.getColour() == bottomSelectedColour }).indices.randomElement() {
                let element = pants.filter({ $0.getColour() == bottomSelectedColour })[randomIndex]
                self.chosenIndices.append(randomIndex)
                chosenItem.append(element)
            }
        } else if bottomSelectedType == "shorts"{
            if let randomIndex = shorts.filter({ $0.getColour() == bottomSelectedColour }).indices.randomElement() {
                let element = shorts.filter({ $0.getColour() == bottomSelectedColour })[randomIndex]
                self.chosenIndices.append(randomIndex)
                chosenItem.append(element)
            }
        }
        table.reloadData()
    }
    
    @IBAction func confirmButton(_ sender: Any) {
        for (_, value) in chosenItem.enumerated() {
            value.setisLaundry(isLaundry: true)
            for i in 0...(itemList?.getClothes().count)!{
                if itemList?.getClothes()[i].getImage() == value.getImage() && itemList?.getClothes()[i].getType() == value.getType() && itemList?.getClothes()[i].getColour() == value.getColour() && itemList?.getClothes()[i].getDesc() == value.getDesc(){
                    itemList?.updateItem(item: value, at: i)
                    break
                }
            }
        }
        
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RandomOutfitTableViewCell") as? RandomOutfitTableViewCell else {
            return UITableViewCell()
        }

        let item = chosenItem[indexPath.row]
        cell.colorLabel.text = item.getColour()
        cell.descLabel.text = item.getDesc()
        cell.clothImageView.image = item.getImage()
        cell.clothNameLabel.text = item.getType()
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chosenItem.count
    }
}
