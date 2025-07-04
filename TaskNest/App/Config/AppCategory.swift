//
//  Untitled.swift
//  TaskNest
//
//  Created by Tung Le on 1/7/2025.
//

import SwiftUI

enum AppCategory: String, CaseIterable {
  case work
  case personal
  case fitness
  case health
  case study
  case shopping
  case travel
  case finance
  case other
  
  var iconName: String {
    switch self {
    case .work: return "briefcase.fill"
    case .personal: return "person.fill"
    case .fitness: return "figure.walk"
    case .health: return "heart.fill"
    case .study: return "book.fill"
    case .shopping: return "cart.fill"
    case .travel: return "airplane"
    case .finance: return "dollarsign.circle.fill"
    case .other: return "tag.fill"
    }
  }
  
  var icon: Image {
    Image(systemName: iconName)
  }
  
  static func from(title: String) -> AppCategory {
    AppCategory.allCases.first(where: { $0.rawValue.lowercased() == title.lowercased() }) ?? .other
  }
}
