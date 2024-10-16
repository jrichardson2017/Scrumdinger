//
//  DetailView.swift
//  Scrumdinger
//
//  Created by justin richardson on 2024-10-15.
//

import SwiftUI

struct DetailView: View {
    var scrum: DailyScrum
    
    var body: some View {
        List {
            Section(header: Text("Meeting Info")) { }
            Label("Start Timer", systemImage: "timer")
                .font(.headline)
                .foregroundStyle(Color.accentColor)
            HStack {
                Label("Length", systemImage: "timer")
                Spacer()
                Text("\(scrum.lengthInMinutes) minutes")
            }
            .accessibilityElement(children: .combine)
            
        }
    }
}

#Preview {
    NavigationStack {
        let scrum = DailyScrum.mockData[0]
        DetailView(scrum: scrum)
    }
}
