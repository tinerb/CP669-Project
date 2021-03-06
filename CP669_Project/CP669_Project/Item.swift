//
//  Item.swift
//  CP669_Project
//
//  Created by user926809 on 3/16/21.
//

import Foundation
import UIKit
import os
class Item: Codable {
    private var image: UIImage?
    private var colour:String
    private var type:String
    private var desc:String
    private var isLaundry: Bool = false
    
    init(image: UIImage, colour: String, type: String, desc: String, isLaundry: Bool){
        self.image = image
        self.colour = colour
        self.type = type
        self.desc = desc
        self.isLaundry = isLaundry
    }
    func setImage(image: UIImage?){
        self.image = image
    }
    
    func getImage() -> UIImage?{
        return self.image
    }
    
    func setColour(colour: String){
        self.colour = colour
    }
    
    func getColour() -> String{
        return self.colour
    }
    
    func setType(type: String){
        self.type = type
    }
    
    func setisLaundry(isLaundry: Bool){
        self.isLaundry = isLaundry
    }
    
    func getType() -> String{
        return self.type
    }
    
    func setDesc(desc: String){
        self.desc = desc
    }
    
    func getDesc() -> String{
        return self.desc
    }
    
    func getIsLaundry() -> Bool{
        return self.isLaundry
    }
    
    init?(image: UIImage?, colour: String, type: String, desc: String, isLaundry: Bool){
        guard !colour.isEmpty else {
            return nil
        }
        guard !type.isEmpty else {
            return nil
        }
        self.image = image
        self.colour = colour
        self.type = type
        self.desc = desc
        self.isLaundry = isLaundry
    }
    
    public enum CodingKeys: String, CodingKey {
        case image
        case colour
        case type
        case desc
        case isLaundry
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let imageData = try container.decode(Data.self, forKey: .image)
        image = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(imageData) as? UIImage
        let colourData = try container.decode(Data.self, forKey: .colour)
        colour = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colourData) as? String ?? "???"
        let typeData = try container.decode(Data.self, forKey: .type)
        type = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(typeData) as? String ?? "???"
        let descData = try container.decode(Data.self, forKey: .desc)
        desc = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(descData) as? String ?? "???"
        let isLaundryData = try container.decode(Data.self, forKey: .isLaundry)
        isLaundry = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(isLaundryData) as? Bool ?? false

    } // decoder
        
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let imageData = try NSKeyedArchiver.archivedData(withRootObject: image ?? UIImage(named: "questionmark.png")!, requiringSecureCoding: true)
        try container.encode(imageData, forKey: .image)
        let colourData = try NSKeyedArchiver.archivedData(withRootObject: colour, requiringSecureCoding: true)
        try container.encode(colourData, forKey: .colour)
        let typeData = try NSKeyedArchiver.archivedData(withRootObject: type, requiringSecureCoding: true)
        try container.encode(typeData, forKey: .type)
        let descData = try NSKeyedArchiver.archivedData(withRootObject: desc, requiringSecureCoding: true)
        try container.encode(descData, forKey: .desc)
        let isLaundryData = try NSKeyedArchiver.archivedData(withRootObject: isLaundry, requiringSecureCoding: true)
        try container.encode(isLaundryData, forKey: .isLaundry)

    } // encoder
}
