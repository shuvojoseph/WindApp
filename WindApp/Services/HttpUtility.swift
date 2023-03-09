//
//  HttpUtility.swift
//  WindApp
//
//  Created by Joseph Shuvo on 3/8/23.
//

import Foundation
import Alamofire

struct HttpUtility
{
    
    func postApiData<T:Decodable>(requestUrl: String, parameters: Dictionary<String, Any>, resultType: T.Type, completionHandler:@escaping(_ result: T)-> Void)
    {
        
        
        AF.request(requestUrl, method: .post,  parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                print(response.result)
                
                
                switch response.result {
                case .success( _):
                    
                    do {
                       
                        let response = try JSONDecoder().decode(T.self, from: response.data!)
                        print(response)
                        _=completionHandler(response)
                    }
                    catch let decodingError {
                        debugPrint(decodingError)
                    }
                    
                case .failure(let error):
                    print(error)
                    
                }
            }
    }
}
