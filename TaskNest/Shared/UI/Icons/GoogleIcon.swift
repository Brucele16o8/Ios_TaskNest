//
//  GoogleIcons.swift
//  TaskNest
//
//  Created by Tung Le on 17/6/2025.
//

import SwiftUI

struct GoogleIcon: View {
  let iconSize: CGFloat
  
  init(iconSize: CGFloat = 45) {
    self.iconSize = iconSize
  }
  
  var body: some View {
    Image("GoogleIcon")
      .resizable()
      .frame(width: iconSize, height: iconSize)
  }
}

#Preview(traits: .sizeThatFitsLayout){
  GoogleIcon()
}
