//
//  CurrentWeatherData.swift
//  Weather
//
//  Created by white4ocolate on 02.02.2024.
//

import Foundation

struct CurrentWeatherData: Decodable {
    
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
    let feelsLike: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
    }
}



struct Weather: Decodable {
    let id: Int
}
