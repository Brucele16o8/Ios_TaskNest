//
//  ColorPalette.swift
//  TaskNest
//
//  Created by Tung Le on 1/7/2025.
//
import SwiftUI

enum AppColor: CaseIterable {
  case primaryBlue, successGreen, dangerRed, warningOrange, alertYellow, creativityPurple, secondaryIndigo
  
  var value: Color {
    switch self {
    case .primaryBlue: return .blue
    case .successGreen: return .green
    case .dangerRed: return .red
    case .warningOrange: return .orange
    case .alertYellow: return .yellow
    case .creativityPurple: return .purple
    case .secondaryIndigo: return .indigo
    }
  }
  
  static var allValues: [Color] {
    AppColor.allCases.map { $0.value }
  }
}
