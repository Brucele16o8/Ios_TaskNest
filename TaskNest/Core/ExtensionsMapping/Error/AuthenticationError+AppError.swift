//
//  AuthenticationError+AppError.swift
//  TaskNest
//
//  Created by Tung Le on 13/6/2025.
//

import Auth0

extension AuthenticationError {
    var toAppError: AppError {
        ErrorMapper.mapAuthenticationError(self)
    }
}
