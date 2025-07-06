//
//  AuthenticatedUser.swift
//  TaskNest
//
//  Created by Tung Le on 6/7/2025.
//

import Foundation

struct AuthenticatedUser: Sendable, Equatable {
  let id: String
  let name: String
  let email: String
  let avatarURL: URL?
}
