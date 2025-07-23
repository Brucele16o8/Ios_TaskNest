//
//  ErrorPresenter.swift
//  TaskNest
//
//  Created by Tung Le on 23/7/2025.
//

import Foundation
import Combine

protocol ErrorPresenter: AnyObject {
  func present(_ error: Error)
}

final class AlertErrorPresenter: ObservableObject, ErrorPresenter {
  @Published var currentError: PresentableError?
  
  func present(_ error: Error) {
    Task { @MainActor in
      self.currentError = PresentableError(error: error)
    }
  }
}


struct PresentableError: Identifiable {
  let id = UUID()
  let title: String
  let description: String
  
  init(error: Error) {
    if let localized = error as? LocalizedError {
      self.title = "Error"
      self.description = localized.errorDescription ?? "Something went wrong"
    } else {
      self.title = "Error"
      self.description = error.localizedDescription
    }
  }
}


