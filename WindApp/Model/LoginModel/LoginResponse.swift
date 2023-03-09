//
//  LoginResponse.swift
//  WindApp
//
//  Created by Joseph Shuvo on 3/8/23.
//

import Foundation

struct LoginResponse : Decodable {

    let status:Bool
    let messages: [String?]
    let data: LoginResponseData?
}

struct LoginResponseData : Decodable
{
    let userInfo:UserInfo
    let accountInfo: AccountInfo
}

struct UserInfo : Decodable {
    let id: Int
    let email: String
    let userName: String
    let walletAddress: String
    let smartContactWallet: String
    let profileImage: String?
    
    init(id: Int, email: String, userName: String, walletAddress: String, smartContactWallet:String, profileImage:String) {
        self.id = id
        self.email = email
        self.userName = userName
        self.walletAddress = walletAddress
        self.smartContactWallet = smartContactWallet
        self.profileImage = profileImage
    }

enum CodingKeys: String, CodingKey {
    case id = "Id"
    case email = "Email"
    case userName = "UserName"
    case walletAddress = "WalletAddress"
    case smartContactWallet = "smartContactWallet"
    case profileImage = "ProfileImage"
}

init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    let id = try values.decode(Int.self, forKey: .id)
    let email = try values.decode(String.self, forKey: .email)
    let userName = try values.decode(String.self, forKey: .userName)
    let walletAddress = try values.decode(String.self, forKey: .walletAddress)
    let smartContactWallet = try values.decode(String.self, forKey: .smartContactWallet)
    let profileImage = try values.decode(String.self, forKey: .profileImage)
    
    self.init(id:id , email: email, userName: userName, walletAddress: walletAddress, smartContactWallet:smartContactWallet, profileImage:profileImage)
 }
}

struct AccountInfo : Decodable {
    let balance : Double
    let currency : String
}
