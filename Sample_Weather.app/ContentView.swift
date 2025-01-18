//
//  ContentView.swift
//  Sample_Weather.app
//
//  Created by mdigix on 2025/01/18.
//

import SwiftUI
@preconcurrency import WeatherKit
import CoreLocation

@MainActor
class WeatherViewModel: ObservableObject {
    private let weatherService = WeatherService()
    
    @Published var currentTemperature: String = "Loading..."
    @Published var weatherDescription: String = "Loading..."
    
    func fetchWeather() async {
        // サンプル位置情報: 緯度と経度（東京の座標）
        let location = CLLocation(latitude: 35.6895, longitude: 139.6917)
        
        do {
            let weather = try await weatherService.weather(for: location)
            DispatchQueue.main.async {
                self.currentTemperature = "\(weather.currentWeather.temperature.value)° \(weather.currentWeather.temperature.unit.symbol)"
                self.weatherDescription = weather.currentWeather.condition.description
            }
        } catch {
            print("Error fetching weather: \(error)")
            DispatchQueue.main.async {
                self.currentTemperature = "Error"
                self.weatherDescription = "Failed to load weather"
            }
        }
    }
}


//@main
struct WeatherKitApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView()
        }
    }
}


