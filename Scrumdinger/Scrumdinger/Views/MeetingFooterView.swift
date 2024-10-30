//
//  MeetingFooterView.swift
//  Scrumdinger
//
//  Created by justin richardson on 2024-10-22.
//

import SwiftUI

struct MeetingFooterView: View {
    let speakers: [ScrumTimer.Speaker]
    var skipAction: () -> Void
    
    var speakerNumber: Int? {
        guard let index = speakers.firstIndex(where: { !$0.isCompleted }) else { return nil }
        return index + 1
    }
    
    var totalSpeakers: Int {
        return speakers.count
    }
    
    var isLastSpeaker: Bool {
        return speakers.dropLast().allSatisfy { $0.isCompleted }
    }
    
    var speakerText: String {
        if isLastSpeaker { return "Last Speaker" }
        
        guard let speakerNumber = speakerNumber else { return "No speakers" }
        
        return "Speaker \(speakerNumber) of \(totalSpeakers)"
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(speakerText)
                Spacer()
                Button(action: skipAction) {
                    Image(systemName: "forward.fill")
                }
                .accessibilityLabel("Next Speaker")
            }
        }
        .padding([.bottom, .horizontal])
    }
}

struct MeetingFooterView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingFooterView(
            speakers: DailyScrum.mockData[0].attendees.speakers,
            skipAction: {}
        )
            .previewLayout(.sizeThatFits)
    }
}
