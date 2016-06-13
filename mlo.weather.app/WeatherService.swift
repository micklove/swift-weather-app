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
    private var openWeatherMapKey = "eaeb448007a512e64e5dc3ccffabb15c"
    private var baseUrl = "http://api.openweathermap.org/data/2.5/weather?"
    private var temperatureForm = "units=metric"
    
    private var delegate: WeatherServiceDelegate?
    
    func getWeather(city: String) {
        //http://stackoverflow.com/questions/24879659/how-to-encode-a-url-in-swift
        let encodedCity = city.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        print("get weather for [\(encodedCity)]")
        let path = "\(baseUrl)\(queryStr)=\(encodedCity!)&\(keyParam)=\(openWeatherMapKey)&\(temperatureForm)"
        let url = NSURL(string: path)
        let session = NSURLSession.sharedSession()
        
        //http://stackoverflow.com/questions/24879659/how-to-encode-a-url-in-swift
        
        let task = session.dataTaskWithURL(url!, completionHandler: handleGetWeatherResponse)
        task.resume();
    }
    
    
    
    func handleGetWeatherResponse(data: NSData?, response: NSURLResponse?, error: NSError?) -> Void {
        if let httpResponse = response as? NSHTTPURLResponse {
            let httpStatusCode = httpResponse.statusCode
            
            print("Status code: (\(httpStatusCode))")
            // do stuff.
            
            if(httpStatusCode >= 200 && httpStatusCode < 300) {
                //See https://github.com/SwiftyJSON/SwiftyJSON
                let json = JSON(data: data!);
                let weather = self.getWeatherDataFromJson(json)
                
                if(nil != self.delegate && !weather.city.isEmpty) {
                    
                    //pass our 'update' function back to the main thread to update the view
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.delegate?.setWeather(weather);
                    })
                }
            }
        }
    }
    
    
    //See http://api.openweathermap.org/data/2.5/weather?q=mascot&APPID=eaeb448007a512e64e5dc3ccffabb15c
    
    func getWeatherDataFromJson(json: JSON) -> WeatherData {
        print(json);
        
        if let lon = json["coord"]["lon"].double {
            let lat = json["coord"]["lat"].double
            let temp = json["main"]["temp"].double
            let summary = json["weather"][0]["main"].string
            let description = json["weather"][0]["description"].string
            let name = json["name"].string
            let icon = json["weather"][0]["icon"].string
            let clouds = json["clouds"]["all"].double
            
            print("Weather Service: lon=\(lon), lat=\(lat), summary=\(summary), desc=\(description), temp=\(temp)");
            let weather = WeatherData(city: name!, temp: temp!, summary: summary!, description: description!, icon: icon!, clouds: clouds!)
            return weather
        } else {
            //couldn't extract value, assume an error, return an empty WeatherData
            return WeatherData(city: "", temp: 0, summary: "", description: "", icon: "", clouds: 0)
        }
    }
    
    func setDelegate(delegate: WeatherServiceDelegate) {
        self.delegate = delegate;
    }
}
