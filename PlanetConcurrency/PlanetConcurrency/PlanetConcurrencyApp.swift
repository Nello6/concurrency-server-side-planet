//
//  PlanetConcurrencyApp.swift
//  PlanetConcurrency
//
//  Created by Antonio Iacono on 31/03/22.
//

import SwiftUI

@main
struct iOS_ConcurrencyApp: App {
    var body: some Scene {
        WindowGroup {
            PhotoListView()
                .onAppear {
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                }
        }
    }
}
