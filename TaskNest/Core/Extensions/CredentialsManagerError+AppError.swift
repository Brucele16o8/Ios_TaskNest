//
//  CredentialsManagerError+AppError.swift
//  TaskNest
//
//  Created by Tung Le on 12/6/2025.
//

import Auth0

extension CredentialsManagerError {
    var toAppError: AppError {
        ErrorMapper.mapCredentialsManagerError(self)
    }
}
