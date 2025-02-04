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
struct Terms: Decodable {
    let id:Int
    let title:String
    let position_type:String
    let user_id:Int
    let created_at:Date
    let updated_at:Date
}
