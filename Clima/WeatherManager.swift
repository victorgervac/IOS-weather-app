//
//  WeatherManager.swift
//  Clima
//
//  Created by Victor Gervacio on 1/30/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: TermCard)
    func didFailWithError(error: Error)
    
}

struct WeatherManager{
    let weatherURL = "http://localhost:3000/terms/"
    
    var delegate: WeatherManagerDelegate?
    
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
                self.delegate?.didFailWithError(error: error)
                return

            }
            
            if let safeData = data {
//                print("Response Data: \(String(data: safeData, encoding: .utf8) ?? "Invalid Data")")
                if method == "GET" {
                    if let parseData = self.parseJSON(weatherData: safeData){
//                        let termVC = WeatherViewController()
//                        termVC.didUpdateWeather(weather: parseData)
                        self.delegate?.didUpdateWeather(self, weather: parseData)
//                        self.delegate?.didUpdateWeather(self, weather: parseData)
                    }
                   
                }
            }
        }
        
        task.resume()
    }
    
    func parseJSON(weatherData: Data)-> TermCard? {
        let decoder = JSONDecoder()
        
//        decoder.dateDecodingStrategy = .iso8601
//        print(weatherData.utf8)
        do {
            let docodedData = try decoder.decode([Terms].self, from: weatherData)
            let title = docodedData[0].title
            let positionType = docodedData[0].position_type
            let termCard = TermCard(title: title, positionType: positionType)
            print(termCard.title)
            
            return termCard
        } catch {
            self.delegate?.didFailWithError(error: error)
            print(error)
            return nil
 
        }
    }
    

}
