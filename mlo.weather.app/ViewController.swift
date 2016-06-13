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
    
    @IBOutlet weak var mapSegueButton: UIButton!
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var clouds: UILabel!
    @IBOutlet weak var cloudinessLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    var weatherData: WeatherData!
    var mapViewSegueId = "mapViewSegue"
    
    @IBAction
    func setCityTapped(sender: UIButton) {
        print("Set City Button Tapped");
        self.openCityAlert();
    }
    
    @IBAction
    func mapSegueButtonTapped(sender: UIButton) {
        print("mapSegueButtonTapped");
        performSegueWithIdentifier(mapViewSegueId, sender: nil)
    }
    
    func initLabels() {
        hideLabels(true)
        self.descriptionLabel?.text = ""
        self.tempLabel?.text = ""
        self.summaryLabel?.text = ""
        self.cloudinessLabel?.text = ""
        self.clouds?.text = ""
    }
    
    func initControls() {
        self.hideLabels(true);
    }
    
    func hideLabels(display: Bool) {
        self.descriptionLabel?.hidden = display;
        self.tempLabel?.hidden = display;
        self.summaryLabel?.hidden = display;
        self.clouds?.hidden = display;
        self.cloudinessLabel?.hidden = display;
        
        self.mapSegueButton?.hidden = display
    }
    
    func setWeather(weather: WeatherData) {
        
        self.hideLabels(false);
        
        weatherData = weather
        
        let city = weather.city
        print("Set Weather invoked: city[\(city)]")
        print("City: \(weather.city) temp: \(weather.temp) description: \(weather.description)");
//        self.cloudinessLabel?.text="Cloudiness:"
        self.descriptionLabel?.text = weather.description
        self.summaryLabel?.text = weather.summary
        
        //let formatter = NSNumberFormatter()
        //let temp = formatter.stringFromNumber(
        let temp = String(format: "%.1F", weather.temp);
        
        //let temp = String(weather.temp)
        
        self.tempLabel?.text = "\(temp)°C"
        self.clouds?.text = "\(String(weather.clouds))%"
        self.cityButton?.setTitle(weather.city, forState: .Normal)
        
        iconImageView.image = UIImage(named: "images/" + weather.icon);
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
    
//    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
//        if segue.identifier == "push" {
//            
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        print("prepare for segue [\(mapViewSegueId)]")
        if segue.identifier == mapViewSegueId && nil != self.weatherData {
            let vc = segue.destinationViewController as! MapViewController
            vc.setWeather(weatherData);
        }
    }

    
    //http://stackoverflow.com/a/15839298/178808
    @IBAction func unwindToMyViewController(segue: UIStoryboardSegue) {
        print("unwind done...")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController did load")
        self.weatherService.setDelegate(self)
        
        if(self.cityButton.currentTitle!.lowercaseString == "set city") {
            //self.initLabels()
            self.initControls()
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

