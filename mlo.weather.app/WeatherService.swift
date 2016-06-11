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
    
    private var delegate: WeatherServiceDelegate?
    
    func getWeather(city: String) {
        // Request weather data
        // Wait ...
        // Process data
        let weather = WeatherData(city: city, temp: 1.0, description: "Nice Day")
        
        // Send Weather data back to Originator
        print("get weather for [\(city)]")
        if(nil != delegate) {
            self.delegate!.setWeather(weather)
        }
    }
    
    func setDelegate(delegate: WeatherServiceDelegate) {
        self.delegate = delegate;
    }
}
