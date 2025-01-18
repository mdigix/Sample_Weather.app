//
//  ContentView.swift
//  Sample_Weather.app
//
//  Created by mdigix on 2025/01/18.
//

import SwiftUI
@preconcurrency import WeatherKit
import CoreLocation

struct WeatherView: View {
    @StateObject private var viewModel = WeatherViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Text(viewModel.locationName) // 地名を表示
                .font(.largeTitle)
                .bold()
            
            Text(viewModel.currentTemperature) // 温度を表示
                .font(.title)
            
            Button(action: {
                Task {
                    await viewModel.fetchWeather()
                }
            }) {
                Text("Refresh")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .task {
            await viewModel.fetchWeather()
        }
    }
}


