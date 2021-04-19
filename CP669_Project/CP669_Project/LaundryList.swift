//
//  LaundryList.swift
//  CP669_Project
//
//  Created by user926809 on 4/17/21.
//

import Foundation
class LaundryList {
    static let laundryList = LaundryList()
    let fileName = "laundryList.archive"
    let fileName2 = "laundryClothes.archive"
    var itemList : ItemList?
    var fileURL : URL {
        let documentDirectoryURL = try! FileManager.default.url(for:
    .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        return documentDirectoryURL.appendingPathComponent(fileName)
    }
    var fileURL2 : URL {
        let documentDirectoryURL = try! FileManager.default.url(for:
    .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        return documentDirectoryURL.appendingPathComponent(fileName2)
    }
    func loadClothes(){
        let jsonDecoder = JSONDecoder()
        var data = Data()
        var data2 = Data()
        do {
            data = try Data(contentsOf: fileURL) } catch {
                print("cannot read the archive")
            }
        do {
            data2 = try Data(contentsOf: fileURL2) } catch {
                print("cannot read the archive")
            }
        do{
            itemList = try jsonDecoder.decode(ItemList.self, from: data)
           
        } catch {
            print("cannot decode from the archive")
        }
        do{
            itemList?.setClothes(clothes: try jsonDecoder.decode([Item].self, from: data2))
           
        } catch {
            print("cannot decode from the archive")
        }
    }
    
    func saveClothes(){
        let jsonEncoder = JSONEncoder()
        var jsonData = Data()
        var jsonData2 = Data()
        do {
            jsonData = try jsonEncoder.encode(itemList)
            jsonData2 = try jsonEncoder.encode(itemList?.getClothes())
            print("itemList encoded")
            print(jsonData)
            print("clothes encoded")
            print(jsonData2)
        } catch {
            print("cannot encode itemList")
        }
        do {
            try jsonData.write(to: fileURL, options: [])
            try jsonData2.write(to: fileURL2, options: [])
        } catch { }
    }
}
