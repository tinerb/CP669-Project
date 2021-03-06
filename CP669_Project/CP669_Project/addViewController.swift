//
//  addViewController.swift
//  CP669_Project
//
//  Created by user926809 on 4/17/21.
//

import UIKit

class addViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var descriptionTextfield: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var colorPicker: UIPickerView!
    @IBOutlet weak var typePicker: UIPickerView!
    
    
    var selectedColor: String = "white"
    var selectedType: String = "pants"
    var imagePicker: UIImagePickerController!
    var sharingList = SharingList.sharedList

    var color = ["white", "black", "red", "yellow", "orange", "purple", "pink", "green"]
    var type = ["pants", "shorts", "shirt", "t-shirt", "coat"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextfield.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func addButtonAction(_ sender: Any) {
        guard let item = Item(image: imageView.image, colour: selectedColor, type: selectedType, desc: descriptionTextfield.text ?? "", isLaundry: false) else {
            return
        }
        sharingList.loadClothes()
        sharingList.itemList?.addItem(item: item)
        
        sharingList.saveClothes()

        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addImageAction(_ sender: Any) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == colorPicker {
            return color.count
        } else if pickerView == typePicker {
            return type.count
        }
        
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == colorPicker {
            let titleRow = color[row]
            return titleRow
        } else if pickerView == typePicker {
            let titleRow = type[row]
            return titleRow
        }
        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == colorPicker {
            self.selectedColor = self.color[row]
        } else if pickerView == typePicker {
            self.selectedType = self.type[row]
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.dismiss(animated: true, completion: nil)
        imageView.image = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
