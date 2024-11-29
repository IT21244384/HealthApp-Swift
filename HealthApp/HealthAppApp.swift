//
//  HealthAppApp.swift
//  HealthApp
//
//  Created by IM Student on 2024-11-29.
//

import SwiftUI

@main
struct HealthAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
