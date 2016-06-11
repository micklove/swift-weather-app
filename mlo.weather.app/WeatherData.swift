//
//  WeatherData.swift
//  mlo.weather.app
//
//  Created by Love Michael on 11/06/2016.
//  Copyright © 2016 Love Michael. All rights reserved.
//

import Foundation

struct WeatherData {
    
    let city: String
    let temp: Double
    let description: String
    
    init(city: String, temp: Double, description: String) {
        self.city = city
        self.temp = temp
        self.description = description
    }
    
}
