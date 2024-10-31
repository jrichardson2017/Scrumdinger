//
//  NewScrumSheet.swift
//  Scrumdinger
//
//  Created by justin richardson on 2024-10-30.
//

import SwiftUI

struct NewScrumSheet: View {
    @Binding var scrums: [DailyScrum]
    @Binding var isPresentingNewScrumSheet: Bool
    
    @State private var newScrum = DailyScrum.emptyScrum
    
    var body: some View {
        NavigationStack {
            DetailEditView(scrum: $newScrum)
                .toolbar {
                    ToolbarItem(
                        placement: .cancellationAction,
                        content: {
                            Button("Dismiss") {
                                isPresentingNewScrumSheet = false
                            }
                        }
                    )
                    
                    ToolbarItem(
                        placement: .confirmationAction,
                        content: {
                            Button("Add") {
                                scrums.append(newScrum)
                                isPresentingNewScrumSheet = false
                            }
                        }
                    )
                }
        }
    }
}

#Preview {
    NewScrumSheet(
        scrums: .constant(DailyScrum.mockData),
        isPresentingNewScrumSheet: .constant(true)
    )
}
