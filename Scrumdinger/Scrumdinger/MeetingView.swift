//
//  ContentView.swift
//  Scrumdinger
//
//  Created by justin richardson on 2024-10-10.
//

import SwiftUI

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(scrum.theme.mainColor)
            VStack {
                ProgressView(value: 5, total: 15)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Seconds Elapsed")
                            .font(.caption)
                        Label("300", systemImage: "hourglass.tophalf.fill")
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("Seconds Remaining")
                            .font(.caption)
                        Label("600", systemImage: "hourglass.bottomhalf.fill")
                    }
                }
                .accessibilityElement(children: /*@START_MENU_TOKEN@*/.ignore/*@END_MENU_TOKEN@*/)
                .accessibilityLabel("Time Remaining")
                .accessibilityValue("10 minutes")

                Circle()
                    .strokeBorder(lineWidth: 24)
                    
                
                HStack {
                    Text("Speaker 1 of 3")
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next Speaker")
                }
            }
        }
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .foregroundStyle(scrum.theme.accentColor)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MeetingView(scrum: .constant(DailyScrum.mockData[0]))
}
