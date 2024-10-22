//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by justin richardson on 2024-10-10.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var scrums = DailyScrum.mockData
    
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $scrums)
        }
    }
}
