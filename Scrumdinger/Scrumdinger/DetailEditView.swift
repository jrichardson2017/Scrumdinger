//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by justin richardson on 2024-10-16.
//

import SwiftUI

struct DetailEditView: View {
    @State private var scrum = DailyScrum.emptyScrum
    
    var body: some View {
        Form {
            Section(header: Text("Meeting Info")) {
                TextField("Title", text: $scrum.title)
            }
        }
    }
}

#Preview {
    DetailEditView()
}
