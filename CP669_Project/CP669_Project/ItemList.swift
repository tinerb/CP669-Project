//
//  ItemList.swift
//  CP669_Project
//
//  Created by user926809 on 3/16/21.
//

import Foundation
import UIKit

class ItemList: Codable {
    var clothes: [Item] = [Item]()
    var current : Int = 0
    
    init(){}
    
    func currentItem() -> Item{
        return self.clothes[current]
    }
    
    func getClothes() -> [Item]{
        return self.clothes
    }
    
    func setClothes(clothes:[Item]){
        self.clothes = clothes
    }
    
    func getCurrentIndex() -> Int{
        return self.current
    }
    
    func setCurrentIndex(current:Int){
        self.current = current
    }
    
    func addItem(item:Item){
        self.clothes.append(item)
    }
    
    func updateItem(item:Item, at index: Int){
        guard index < clothes.count else {
            return
        }
        self.clothes[index] = item
    }
    
    func deleteItem(index:Int){
        self.clothes.remove(at:index)
    }

    public enum CodingKeys: String, CodingKey {
        case current
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let currentData = try container.decode(Data.self, forKey: .current)
        self.current = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(currentData) as! Int
    } //decoder
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let currentData = try NSKeyedArchiver.archivedData(withRootObject: current, requiringSecureCoding: true)
        try container.encode(currentData, forKey: .current)
    } //encoder
    
    init?(list: [Item], current: Int){
        self.clothes = list
        self.current = current
    }
}
