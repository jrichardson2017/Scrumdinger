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
            Section(header: Text("Meeting Info")) {
                Label("Start Timer", systemImage: "timer")
                    .font(.headline)
                    .foregroundStyle(Color.accentColor)
                HStack {
                    Label("Length", systemImage: "timer")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text("\(scrum.theme.name)")
                        .padding(4)
                        .foregroundStyle(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }
            }
            
            Section(header: Text("Attendees")) {
                ForEach(scrum.attendees) { attendee in
                    Label("\(attendee.name)", systemImage: "person")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        let scrum = DailyScrum.mockData[0]
        DetailView(scrum: scrum)
    }
}
