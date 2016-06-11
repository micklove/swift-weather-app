//
//  WeatherService.swift
//  mlo.weather.app
//
//  Created by Love Michael on 11/06/2016.
//  Copyright © 2016 Love Michael. All rights reserved.
//

import Foundation

protocol WeatherServiceDelegate {
    func setWeather(weather: WeatherData)
}

class WeatherService {
    
    //http://api.openweathermap.org/data/2.5/weather?q=mascot&APPID=eaeb448007a512e64e5dc3ccffabb15c
    private var keyParam="APPID"
    private var queryStr="q"
    private var openWeatherMapKey = "eaeb448007a512e64e5dc3ccffabb15c";
    private var baseUrl = "http://api.openweathermap.org/data/2.5/weather?";
    
    
    private var delegate: WeatherServiceDelegate?
    
    func getWeather(city: String) {
        // Request weather data
        // Wait ...
        // Process data
        
        // Send Weather data back to Originator
        print("get weather for [\(city)]")
        let path = "\(baseUrl)\(queryStr)=\(city)&\(keyParam)=\(openWeatherMapKey)"
        //let urlEncoded = path.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        
        //http://stackoverflow.com/questions/24879659/how-to-encode-a-url-in-swift
        
        let task = session.dataTaskWithURL(url!) { (data: NSData?, response: NSURLResponse?, error: NSError?) in
            
            //See https://github.com/SwiftyJSON/SwiftyJSON
            let json = JSON(data: data!);
//            print(json);
//            let lon = json["coord"]["lon"].double
//            let lat = json["coord"]["lat"].double
//            let temp = json["main"]["temp"].double
//            let description = json["weather"][0]["description"].string
//            let name = json["name"].string
            
            //let weather = WeatherData(city: name!, temp: temp!, description: description!)
            
            let weather = self.getWeatherDataFromJson(json)
            
            if(nil != self.delegate) {
                
                //pass our 'update' function back to the main thread to update the view
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.delegate?.setWeather(weather);
                })
            }
        }
        task.resume();
    }
    
    
    func getWeatherDataFromJson(json: JSON) -> WeatherData {
        print(json);
        let lon = json["coord"]["lon"].double
        let lat = json["coord"]["lat"].double
        let temp = json["main"]["temp"].double
        let description = json["weather"][0]["description"].string
        let name = json["name"].string
        
        print("Weather Service: lon=\(lon), lat=\(lat), desc=\(description), temp=\(temp)");
        
        let weather = WeatherData(city: name!, temp: temp!, description: description!)
        return weather

    }
    
    func setDelegate(delegate: WeatherServiceDelegate) {
        self.delegate = delegate;
    }
}
