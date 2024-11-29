//
//  ContentView.swift
//  HealthApp
//
//  Created by IM Student on 2024-11-29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            DashboardView()
                .navigationTitle("HealthMate")
        }
    }
}
