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
    private let geoCoder = CLGeocoder()
    
    @Published var locationName: String = "UnKnown Location"
    @Published var currentTemperature: String = "Loading..."
    
    func fetchWeather() async {
        // サンプル位置情報: 緯度と経度（東京の座標）
        let location = CLLocation(latitude: 35.6895, longitude: 139.6917)
        
        do {
            let placemarks = try await geoCoder.reverseGeocodeLocation(location)
            if let placemark = placemarks.first {
                self.locationName = placemark.locality ?? "Unknown City"
            
            }
            let weather = try await weatherService.weather(for: location)
            let temperature = weather.currentWeather.temperature.converted(to: .celsius)
            self.currentTemperature = String(format: "%.1f°C", temperature.value) // 小数点以下1桁
                
        } catch {
            print("Error fetching weather: \(error)")
                self.locationName = "Error"
                self.currentTemperature = "Failed to load weather"
            
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


