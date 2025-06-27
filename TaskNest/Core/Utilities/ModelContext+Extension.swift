//
//  ModelContext+Extension.swift
//  TaskNest
//
//  Created by Tung Le on 27/6/2025.
//

import Foundation
import SwiftData

extension ModelContext {
    func deleteAll<T: PersistentModel>(_ type: T.Type) async throws {
        let descriptor = FetchDescriptor<T>()
        let allItems = try self.fetch(descriptor)
        for item in allItems {
            self.delete(item)
        }
    }
}
