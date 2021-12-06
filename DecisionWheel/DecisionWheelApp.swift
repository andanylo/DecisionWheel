//
//  DecisionWheelApp.swift
//  DecisionWheel
//
//  Created by Danil Andriuschenko on 06.12.2021.
//

import SwiftUI

@main
struct DecisionWheelApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
