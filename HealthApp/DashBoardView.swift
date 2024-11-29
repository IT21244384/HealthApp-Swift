//
//  DashBoardView.swift
//  HealthApp
//
//  Created by IM Student on 2024-11-29.
//

import SwiftUI

struct DashboardView: View {
    @State private var steps: Double = 0
    @State private var heartRate: Double = 0
    private let healthManager = HealthDataManager()
    
    var body: some View {
        VStack {
            Text("Welcome to HealthMate!")
                .font(.largeTitle)
                .padding()
            
            HStack {
                MetricCardView(title: "Steps", value: Int(steps))
                MetricCardView(title: "Heart Rate", value: Int(heartRate), unit: "bpm")
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                healthManager.requestAuthorization { success in
                    if success {
                        healthManager.fetchStepCount { steps in
                            self.steps = steps
                        }
                        healthManager.fetchHeartRate { rate in
                            self.heartRate = rate
                        }
                    }
                }
            }) {
                Text("Update Data")
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}

struct MetricCardView: View {
    let title: String
    let value: Int
    let unit: String?
    
    init(title: String, value: Int, unit: String? = nil) {
        self.title = title
        self.value = value
        self.unit = unit
    }
    
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.largeTitle)
                .bold()
            if let unit = unit {
                Text(unit)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
        }
        .frame(width: 150, height: 150)
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

