//
//  ErrorMapper.swift
//  TaskNest
//
//  Created by Tung Le on 10/6/2025.
//

import Foundation
import Auth0

struct ErrorMapper {
  
  // ✅
  static func from(_ error: WebAuthError) -> AppError {
    switch error {
    case .userCancelled:
      return .auth(.cancelled)
    case .noInternet:
      return .auth(.noInternet)
    }
  }
}
