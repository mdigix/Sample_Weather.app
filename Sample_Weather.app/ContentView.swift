//
//  ContentView.swift
//  Sample_Weather.app
//
//  Created by mdigix on 2025/01/18.
//

import SwiftUI

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Current Temperature")
                .font(.headline)
            
            Text(viewModel.currentTemperature)
                .font(.largeTitle)
                .bold()
            
            Text(viewModel.weatherDescription)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .task {
            await viewModel.fetchWeather()
        }
    }
}


struct WeatherKitApp: App {
    var body: some Scene {
        WindowGroup {
            WeatherView() // ここでWeatherViewを表示
        }
    }
}


