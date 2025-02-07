//
//  WeatherData.swift
//  Clima
//
//  Created by Victor Gervacio on 1/30/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation
struct WeatherData:Decodable{
    let name: String
    let main: Main
    
}
struct Main: Decodable{
    let temp: Double
}
//does both codebale and decodeable
struct Terms: Codable {
    let id: Int
    let title: String
    let position_type: String
    let user_id: Int
}
