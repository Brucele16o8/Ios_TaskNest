//
//  SettingPanel.swift
//  TaskNest
//
//  Created by Tung Le on 22/6/2025.
//

import SwiftUI

struct SettingsPanel: View {
  let onLogout: () -> Void
  
  var body: some View {
    NavigationStack {
      VStack {
        Spacer()
        Button(role: .destructive) {
          onLogout()
        } label: {
          Text("Log Out")
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.red.opacity(0.1))
            .cornerRadius(12)
        }
        .padding(.horizontal, 40)
        
        Spacer(minLength: 40)
      }
      .navigationTitle(Text("Settings"))
      .navigationBarTitleDisplayMode(.inline)
    }
  }
}

#Preview {
  SettingsPanel(onLogout: { })
}
