//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by justin richardson on 2024-10-10.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @StateObject private var store = ScrumStore()
    
    var body: some Scene {
        WindowGroup {
            ScrumsView(
                scrums: $store.scrums,
                saveAction: {
                    Task {
                        do {
                            try await store.save(scrums: store.scrums)
                        } catch {
                            fatalError("Failed to save: \(error.localizedDescription)")
                        }
                    }
                }
            )
            .task {
                do {
                    try await store.load()
                } catch {
                    fatalError("Failed to load: \(error.localizedDescription)")
                }
            }
        }
    }
}
