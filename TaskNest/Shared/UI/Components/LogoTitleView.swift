//
//  LogoTitleView.swift
//  TaskNest
//
//  Created by Tung Le on 17/6/2025.
//

import SwiftUI

struct LogoTitleView: View {
  @Namespace var animationNamespace
  let title: String
  let size: CGFloat
  var showText: Bool
  
  var body: some View {
    Text(title)
      .font(.custom("Pacifico-Regular", size: size).weight(.bold))
      .foregroundStyle(.headingText)
      .scaleEffect(showText ? 1 : 0.8)
      .opacity(showText ? 1 : 0)
      .matchedGeometryEffect(id: "title", in: animationNamespace)
  }
}

#Preview {
  LogoTitleView(title: "TaskNest", size: 68, showText: true)
}
