//
//  UserInfoDto+Mapper.swift
//  TaskNest
//
//  Created by Tung Le on 6/7/2025.
//

import Foundation

extension UserInfoDto {
  var mapToAuthenticatedUser: AuthenticatedUser {
    AuthenticatedUser(
      id: self.sub,
      name: self.email ?? "",
      email: self.email ?? "",
      avatarURL: URL(string: self.picture ?? "")
    )
  }
}
