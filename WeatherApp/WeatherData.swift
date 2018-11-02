//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Dogukan Cudin on 1.11.2018.
//  Copyright © 2018 Dogukan Cudin. All rights reserved.
//

import UIKit

class WeatherData: NSObject {
    
    var temp: Double
    var temp_min:Double
    var temp_max:Double
    var pressure:Double
    var humidity:Double
    var weatherMain:String
    var weatherDescription:String
    var windSpeed:Double
    var dt_text:String
    
    init(temp:Double,temp_min:Double,temp_max:Double,pressure:Double,humidity:Double,weatherMain:String,weatherDescription:String,windSpeed:Double,dt_text:String) {
        
        self.temp = temp
        self.temp_min = temp_min
        self.temp_max = temp_max
        self.pressure = pressure
        self.humidity = humidity
        self.weatherMain = weatherMain
        self.weatherDescription = weatherDescription
        self.windSpeed = windSpeed
        self.dt_text = dt_text
        
    }

}
