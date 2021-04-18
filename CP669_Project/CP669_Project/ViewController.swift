//
//  ViewController.swift
//  CP669_Project
//
//  Created by user926809 on 3/16/21.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    
    var weatherResult: Result?
    var locationManger: CLLocationManager!
    var currentlocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = SharingList()
        SharingList.sharedList.loadClothes()
        
        if (SharingList.sharedList.itemList == nil){
            SharingList.sharedList.itemList = ItemList()
        }
        getWeather()
    }
    
    func getWeather() {
        var max: Double = -1000
        var min: Double = 1000
        NetworkService.shared.getWeather(onSuccess: { [self] (result) in
            self.weatherResult = result
            for i in 0...((weatherResult?.hourly.count)! - 1){
                if (weatherResult?.hourly[i].temp)! > max{
                    max = (weatherResult?.hourly[i].temp)!
                }
                if (weatherResult?.hourly[i].temp)! < min{
                    min = (weatherResult?.hourly[i].temp)!
                }
            }
            currentTemp.text = String((weatherResult?.current.temp)!)
            maxTemp.text = String(max)
            minTemp.text = String(min)
            image.image = UIImage(named:weatherResult!.current.weather[0].icon)
        }) { (errorMessage) in
                debugPrint(errorMessage)
        }
    }
}

