//
//  LoginRequest.swift
//  WindApp
//
//  Created by Joseph Shuvo on 3/8/23.
//

import Foundation

struct LoginRequest : JSONAble
{
    var user, pin: String?
}
