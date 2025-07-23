//
//  ErrorPresenter+Environment.swift
//  TaskNest
//
//  Created by Tung Le on 23/7/2025.
//

import SwiftUI

private struct ErrorPresenterKey: EnvironmentKey {
  static let defaultValue: ErrorPresenter = LogOnlyPresenter()
}

extension EnvironmentValues {
  var errorPresenter: ErrorPresenter {
    get { self[ErrorPresenterKey.self] }
    set { self[ErrorPresenterKey.self] = newValue }
  }
}



/// Fallback logger or default value for when `.withScopedErrorAlert()` is not used
final class LogOnlyPresenter: ErrorPresenter {
  func present(_ error: Error) {
    print("⚠️ Error: \(error.localizedDescription)")
  }
}
