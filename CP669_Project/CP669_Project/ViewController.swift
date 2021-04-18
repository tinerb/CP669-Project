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
        //getLocation() causes error
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
            currentTemp.text = String((weatherResult?.current.temp)!) + "°F"
            maxTemp.text = String(max) + "°F"
            minTemp.text = String(min) + "°F"
            image.image = UIImage(named:weatherResult!.current.weather[0].icon)
        }) { (errorMessage) in
                debugPrint(errorMessage)
        }
    }
    
    func getLocation() {
        locationManger = CLLocationManager()
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.requestWhenInUseAuthorization()
        if (CLLocationManager.locationServicesEnabled()) {
            locationManger.requestLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.currentlocation = location
            
            let latitude: Double = self.currentlocation!.coordinate.latitude
            let longitude: Double = self.currentlocation!.coordinate.longitude
                
            NetworkService.shared.setLatitude(latitude)
            NetworkService.shared.setLongitude(longitude)
        }
    }
}

