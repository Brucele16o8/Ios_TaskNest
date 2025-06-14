//
//  ResolverEnvironmentKey.swift
//  TaskNest
//
//  Created by Tung Le on 15/6/2025.
//

import Swinject
import SwiftUI

private struct ResolverKey: EnvironmentKey {
  static let defaultValue: Resolver = AppDIContainer.shared.container
}

extension EnvironmentValues {
  public var resolver: Resolver {
    get { self[ResolverKey.self] }
    set { self[ResolverKey.self] = newValue }
  }
}
