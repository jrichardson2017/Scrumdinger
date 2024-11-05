//
//  ScrumStore.swift
//  Scrumdinger
//
//  Created by justin richardson on 2024-11-04.
//

import Foundation


class ScrumStore: ObservableObject {
    
    @Published var scrums: [DailyScrum] = DailyScrum.mockData
    
    private static func fileURL() throws -> URL {
        return try FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        )
        .appendingPathComponent("scrums.data")
    }
    
    func save(scrums: [DailyScrum]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(scrums)
            let file = try Self.fileURL()
            try data.write(to: file)
        }
        
        _ = try await task.value
    }
    
    func load() async throws {
        let task = Task {
            let file = try Self.fileURL()
            let data = try Data(contentsOf: file)
            let scrums = try JSONDecoder().decode([DailyScrum].self, from: data)
            return scrums
        }
        
        self.scrums = try await task.value
    }
}
