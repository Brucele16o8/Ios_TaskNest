//
//  ScopedErrorAlert.swift
//  TaskNest
//
//  Created by Tung Le on 23/7/2025.
//

import Foundation
import SwiftUI

private struct ScopedErrorAlert: ViewModifier {
  @StateObject private var presenter = AlertErrorPresenter()
  
  func body(content: Content) -> some View {
    content
      .environment(\.errorPresenter, presenter)
      .alert(item: $presenter.currentError) { error in
        Alert(
          title: Text(error.title),
          message: Text(error.description),
          dismissButton: .default(Text("Ok"))
        )
      }
  }
}

extension View {
  func withScopedErrorAlert() -> some View {
    self.modifier(ScopedErrorAlert())
  }
}
