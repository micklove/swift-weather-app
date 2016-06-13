//
//  MapViewController.swift
//  mlo.weather.app
//
//  Created by Love Michael on 13/06/2016.
//  Copyright © 2016 Love Michael. All rights reserved.
//

import Foundation
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    var weatherData: WeatherData!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController did load")
        initLabels()
        initMap()
    }
    
    
    func initLabels() {
        if(nil != self.weatherData) {
            let temp = String(format: "%.1F", weatherData.temp);
            self.tempLabel?.text = "\(temp)°C"
            self.cityLabel?.text = weatherData.city;
        }
    }
    
    
    //https://github.com/talhaqamar/Map-demo-swift/blob/master/Maps%20Demo/Maps%20Demo/ViewController.swift
    func initMap() {
        
        if(nil != self.weatherData) {
            //Empire state building coordinates
//            let latitude :CLLocationDegrees = 40.748643
//            let longitude :CLLocationDegrees = -73.985637

            let latitude :CLLocationDegrees = self.weatherData.lat
            let longitude :CLLocationDegrees = self.weatherData.lon
            
            let span = MKCoordinateSpanMake(0.075, 0.075)
            let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = self.weatherData.city
            annotation.subtitle = self.weatherData.description
            mapView.addAnnotation(annotation)

        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setWeather(weather: WeatherData) {
        self.weatherData = weather
        
//        print("MapViewController Set Weather invoked: city[\(city)]")
//        print("City: \(weather.city) temp: \(weather.temp) description: \(weather.description)");
//        self.cloudinessLabel?.text="Cloudiness:"
//        self.descriptionLabel?.text = weather.description
//        self.summaryLabel?.text = weather.summary
//        
//        //let formatter = NSNumberFormatter()
//        //let temp = formatter.stringFromNumber(
//        let temp = String(format: "%.1F", weather.temp);
//        
//        //let temp = String(weather.temp)
//        
//        self.tempLabel?.text = "\(temp)°C"
//        self.clouds?.text = "\(String(weather.clouds))%"
//        self.cityButton?.setTitle(weather.city, forState: .Normal)
//        
//        iconImageView.image = UIImage(named: "images/" + weather.icon);
    }

    
    
}