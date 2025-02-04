//
//  WeatherManager.swift
//  Clima
//
//  Created by Victor Gervacio on 1/30/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation
struct WeatherManager{
    let weatherURL = "http://localhost:3000/terms/"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)"
        print(urlString)
        performRequest(urlString: urlString)
    }
    func performRequest(urlString: String, method: String = "GET", body: Data? = nil) {
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        if let body = body {
            request.httpBody = body
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let safeData = data {
                print("Response Data: \(String(data: safeData, encoding: .utf8) ?? "Invalid Data")")
                if method == "GET" {
                    parseJSON(weatherData: safeData)
                }
            }
        }
        
        task.resume()
    }
    
    func parseJSON(weatherData: Data){
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        do {
            let docodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(docodedData)
            
        } catch {
            print(error)
        }
    }
    

}
