//
//  WeatherManager.swift
//  Clima
//
//  Created by Victor Gervacio on 1/30/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation
struct WeatherManager{
    let weatherURL = "https://api.openweathermap.org/data/2.5/ name}&appid=KEY&unit=standard"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        performRequest(urlString: urlString)
    }
    func performRequest(urlString: String){
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
//            completionHandler takes a function waiting for answer
            let task =  session.dataTask(with: url) {(data, response, error) in
                if error != nil{
                    print(error!)
                    return
                }
                
                if let safeData = data{
                    self.parseJSON(weatherData: safeData)
//                    print(String(data: safeData, encoding: .utf8)!)
                }
            }
            
            task.resume()
        }
    }
    func parseJSON(weatherData: Data){
        let decoder = JSONDecoder()
        do {
            let docodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(docodedData .name)
        } catch {
            print(error)
            
        }
    }
    

}
