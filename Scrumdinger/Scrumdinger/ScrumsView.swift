//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by justin richardson on 2024-10-13.
//

import SwiftUI

struct ScrumsView: View {
    let scrums: [DailyScrum]
    
    var body: some View {
        List(scrums, id: \.title) { scrum in
            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Content")/*@END_MENU_TOKEN@*/
        }
    }
}

#Preview {
    ScrumsView(scrums: DailyScrum.mockData)
}
