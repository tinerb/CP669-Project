//
//  ViewController.swift
//  CP669_Project
//
//  Created by user926809 on 3/16/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        _ = SharingList()
        SharingList.sharedList.loadClothes()
        
        if (SharingList.sharedList.itemList == nil){
            SharingList.sharedList.itemList = ItemList()
        }
    }
}

