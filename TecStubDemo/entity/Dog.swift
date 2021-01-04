//
//  Dog.swift
//  TecStubDemo
//
//  Created by Apple on 03/01/21.
//  Copyright © 2021 Tita. All rights reserved.
//

import UIKit
import ObjectMapper
class Dog: Mappable {
    
    var name : String?
    var lifeSpan : String?
    var image : String?
    
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        image       <- map["url"]
        name        <- map["breeds.0.name"]
        lifeSpan    <- map["breeds.0.life_span"]
        image       <- map["url"]
    }
    
    

}


struct DogLISTAPIRequest: Codable {
    let limit: Int
}

extension DogLISTAPIRequest: APIEndpoint {
    
    func endpoint() -> String {
        return "images/search"
    }
    
    func getURLPerameters() -> String {
        
        return "limit=\(limit)"
    }
    
    func dispatch(onSuccess successHandler: @escaping ((_: [Dog]) -> Void), onFailure failureHandler: @escaping ((_: APIError?, _: Error) -> Void)) {
        APIRequest.get(request: self, onSuccess: { (baseAPIResponse) in
            successHandler(baseAPIResponse)
        }) { (baseAPIError, error) in
            failureHandler(baseAPIError, error)
        }
    }
}
