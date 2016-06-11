//
//  ViewController.swift
//  mlo.weather.app
//
//  Created by Love Michael on 11/06/2016.
//  Copyright © 2016 Love Michael. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WeatherServiceDelegate {

    private let weatherService = WeatherService()
    
    @IBOutlet weak var setCityButton: UIButton!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
//    @IBOutlet weak var cityLabel: UILabel!
    
    @IBAction
    func setCityTapped(sender: UIButton) {
        print("Set City Button Tapped");
        self.openCityAlert();
    }
    
    func initLabels() {
//        self.cityLabel.text = ""
        self.descriptionLabel?.text = ""
        self.tempLabel?.text = ""
        self.summaryLabel?.text = ""
    }
    
    func setWeather(weather: WeatherData) {
        let city = weather.city
        print("Set Weather invoked: city[\(city)]")
        print("City: \(weather.city) temp: \(weather.temp) description: \(weather.description)");
//        self.cityLabel.text = weather.city;
        self.descriptionLabel?.text = weather.description
        self.summaryLabel?.text = weather.summary
        self.tempLabel?.text = String(weather.temp)
        self.setCityButton?.setTitle(weather.city, forState: .Normal)
    }
    
    
    //option click to view details of variables
    
    func openCityAlert() {
        
        //Create Alert Controller
        //.Alert allows you to add a text input field (ActionSheet doesn't)
        let cityAlert = UIAlertController(title: "City", message: "Enter City Name", preferredStyle: .Alert)
        
        //Create Cancel action
        let cancel = UIAlertAction(title: "Cancel",
            style: .Cancel,
            handler: nil)
        cityAlert.addAction(cancel);
        
        //Create OK Action
        let ok = UIAlertAction(title: "OK", style: .Default) { (action: UIAlertAction) -> Void in
            let textField = cityAlert.textFields?[0]
            if(nil != textField) {
                let txt = textField!.text!
                if(!txt.isEmpty) {
                    print(textField!.text);
                    self.weatherService.getWeather(txt)
                } else {
                    print("ERROR: No city provided");
                }
            }
        }
        cityAlert.addAction(ok);
        
        cityAlert.addTextFieldWithConfigurationHandler { (textField: UITextField) -> Void in
            textField.placeholder = "City Name"
        }
        
        self.presentViewController(cityAlert, animated: false, completion: nil)
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController did load")
        self.weatherService.setDelegate(self)
        
        if(self.setCityButton.currentTitle!.lowercaseString == "set city") {
            self.initLabels()
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

