//
//  ProgressView.swift
//  TaskNest
//
//  Created by Tung Le on 15/7/2025.
//

import SwiftUI

struct ProgressViewComponent: View {
  var body: some View {
    ProgressView()
      .progressViewStyle(CircularProgressViewStyle(tint: .white))
      .frame(maxWidth: .infinity)
      .padding()
  }
}

#Preview {
  ProgressView()
}
