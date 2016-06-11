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
    let summary: String
    let description: String
    
    init(city: String, temp: Double, summary: String, description: String) {
        self.city = city
        self.temp = temp
        self.summary = summary
        self.description = description
    }
    
}
