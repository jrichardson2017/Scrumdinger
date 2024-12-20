//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by justin richardson on 2024-10-13.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @State private var isPresentingNewScrumView = false
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: () -> Void
    
    var body: some View {
        NavigationStack {
            List($scrums) { $scrum in
                NavigationLink(destination: DetailView(scrum: $scrum)) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrums")
            .toolbar {
                Button(action: {
                    isPresentingNewScrumView = true
                }) {
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrum")
            }
        }
        .sheet(
            isPresented: $isPresentingNewScrumView,
            content: {
                NewScrumSheet(
                    scrums: $scrums,
                    isPresentingNewScrumSheet: $isPresentingNewScrumView
                )
            }
        )
        .onChange(of: scenePhase) {
            if scenePhase == .inactive {
                saveAction()
            }
        }
    }
}

#Preview {
    ScrumsView(
        scrums: .constant(DailyScrum.mockData),
        saveAction: { print("Save") }
    )
}
