//
//  WebAuthError+AppError.swift
//  TaskNest
//
//  Created by Tung Le on 12/6/2025.
//

import Auth0

extension WebAuthError {
  var toAppError: AppError {
    ErrorMapper.mapWebAuthError(self)
  }
}
