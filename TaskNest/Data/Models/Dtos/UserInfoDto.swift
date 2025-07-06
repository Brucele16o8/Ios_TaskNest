//
//  ProfileDto.swift
//  TaskNest
//
//  Created by Tung Le on 22/6/2025.
//

struct UserInfoDto: Decodable {
  let sub: String
  let name: String?
  let email: String?
  let picture: String?
}
