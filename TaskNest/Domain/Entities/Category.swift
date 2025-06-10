//
//  Category.swift
//  TaskNest
//
//  Created by Tung Le on 9/6/2025.
//

import Foundation

struct Category: Identifiable, Hashable {
  let name: String
  let id: UUID = UUID()
}
