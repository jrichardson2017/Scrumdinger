//
//  ScrumTimer.swift
//  Scrumdinger
//
//  Created by justin richardson on 2024-10-22.
//
import Foundation

@MainActor
final class ScrumTimer: ObservableObject {
    
    // MARK: - Speaker Obj
    
    struct Speaker {
        var name: String
        var isCompleted: Bool
    }
    
    // MARK: - Public Props
    
    @Published var activeSpeaker = ""
    @Published var secondsElapsed = 0
    @Published var secondsRemaining = 0
    var speakerChangedAction: (() -> Void)?
    
    
    // MARK: - Private Props
    
    private(set) var speakers: [Speaker] = []
    private(set) var meetingLengthInMinutes: Int
    
    
    // MARK: - Timer Props
    
    private var timerStopped = false
    private var speakerIndex = 0
    private weak var timer: Timer?
    private var frequency: TimeInterval { 1.0 / 60.0 }
    private var startDate: Date?
    private var isTimerStopped = false
    private var secondsElapsedForSpeaker: Int = 0
    private var meetingLengthInSeconds: Int { meetingLengthInMinutes * 60 }
    private var secondsPerSpeaker: Int {
        (meetingLengthInMinutes * 60) / speakers.count
    }
    private var speakerText: String {
        return "Speaker \(speakerIndex + 1): " + speakers[speakerIndex].name
    }
    
    
    // MARK: - Init
    
    init(meetingLengthInMinutes: Int = 0, attendees: [DailyScrum.Attendee] = []) {
        self.meetingLengthInMinutes = meetingLengthInMinutes
        self.speakers = attendees.speakers
        secondsRemaining = meetingLengthInSeconds
        activeSpeaker = speakerText
    }

    
    // MARK: - Public Methods
    
    nonisolated func skipSpeaker() {
        Task { @MainActor in
            changeToSpeaker(at: speakerIndex + 1)
        }
    }
    
    func startScrum() {
        timer = Timer.scheduledTimer(
            withTimeInterval: frequency,
            repeats: true,
            block: { [weak self] timer in
                self?.update()
            }
        )
        timer?.tolerance = 0.1
        changeToSpeaker(at: 0)
    }
    
    func stopScrum() {
        timer?.invalidate()
        timerStopped = true
    }
    
    func reset(lengthInMinutes: Int, attendees: [DailyScrum.Attendee]) {
        self.meetingLengthInMinutes = lengthInMinutes
        self.speakers = attendees.speakers
        secondsRemaining = meetingLengthInSeconds
        activeSpeaker = speakerText
    }
    
    
    // MARK: - Private Methods
    
    private func changeToSpeaker(at index: Int) {
        /// Set speaker to completed
        if index > 0 {
            let previousSpeakerIndex = index - 1
            speakers[previousSpeakerIndex].isCompleted = true
        }
        
        /// Reset the seconds elapsed for the new speaker
        secondsElapsedForSpeaker = 0
        
        /// Safe guard for going out of bounds
        guard index < speakers.count else { return }
        
        /// Set the index to the new speaker
        speakerIndex = index
        ///
        activeSpeaker = speakerText
        
        secondsElapsed = index * secondsPerSpeaker
        secondsRemaining = meetingLengthInSeconds - secondsElapsed
        startDate = Date()
    }
    
    nonisolated private func update() {
        Task { @MainActor in
            guard let startDate, !isTimerStopped else { return }
            
            secondsElapsedForSpeaker = Int(Date().timeIntervalSince1970 - startDate.timeIntervalSince1970)
            
            self.secondsElapsed = (secondsPerSpeaker * speakerIndex) + secondsElapsedForSpeaker
            
            guard secondsElapsedForSpeaker <= secondsPerSpeaker else { return }
            
            secondsRemaining = max(meetingLengthInSeconds - self.secondsElapsed, 0)

            if secondsElapsedForSpeaker >= secondsPerSpeaker {
                changeToSpeaker(at: speakerIndex + 1)
                speakerChangedAction?()
            }
        }
    }

}
