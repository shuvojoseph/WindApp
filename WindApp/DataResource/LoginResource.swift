//
//  LoginResource.swift
//  WindApp
//
//  Created by Joseph Shuvo on 3/8/23.
//

import Foundation

struct LoginResource
{
    func loginUser(loginRequest: LoginRequest, completion : @escaping (_ result: LoginResponse?) -> Void)
    {
        
        let httpUtility = HttpUtility()
        
        let parameters = loginRequest.toDict()
        httpUtility.postApiData(requestUrl: ApiEndpoints.login, parameters: parameters, resultType: LoginResponse.self) { (loginApiResponse) in
            
            _ = completion(loginApiResponse)
        }
    }
}
