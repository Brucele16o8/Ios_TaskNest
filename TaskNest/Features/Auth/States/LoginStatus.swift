//
//  LoginStatus.swift
//  TaskNest
//
//  Created by Tung Le on 14/6/2025.
//

enum LoginStatus: Equatable {
    case idle
    case authenticating
    case authenticated
    case error
}
