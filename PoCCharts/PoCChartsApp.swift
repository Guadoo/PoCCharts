//
//  PoCChartsApp.swift
//  PoCCharts
//
//  Created by Guadoo on 2023/3/13.
//

import SwiftUI

@main
struct PoCChartsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
