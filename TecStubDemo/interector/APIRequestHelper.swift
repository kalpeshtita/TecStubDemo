////
////  APIRequestManager.swift
////  WeatherApp
////
////  Created by Kalpesh on 03/01/21.
////  Copyright © 2020 Kalpesh. All rights reserved.
////


import Alamofire

import Foundation
import ObjectMapper

protocol APIEndpoint {
    func endpoint() -> String
    func getURLPerameters() -> String
}

class APIRequest {
    
    public static let sessionManager: Session = {
        let manager = Alamofire.Session()
        return manager
    }()
        
    class func getServerUrl() -> String {
        
        return "https://api.thedogapi.com/v1/"
    }
    
}

extension APIRequest {
    
    public static func get<R: Codable & APIEndpoint>(
            request: R,
            onSuccess: @escaping ((_: [Dog]) -> Void),
            onError: @escaping ((_: APIError?, _: Error) -> Void)) {
            
            guard var endpointRequest = self.urlRequest(from: request) else {
                return
            }
            endpointRequest.httpMethod = "GET"
            APIRequest.sessionManager.request(endpointRequest)
                .validate(statusCode: 200..<299)
                .responseJSON { (response) in
                    self.processResponse(response, onSuccess: onSuccess, onError: onError)
            }
        }
    
    public static func urlRequest(from request: APIEndpoint) -> URLRequest? {
        let endpoint = request.endpoint()
        let urlParameters = request.getURLPerameters()
        guard let endpointUrl = URL(string: "\(getServerUrl())\(endpoint)?\(urlParameters)") else {
            return nil
        }
        
        var endpointRequest = URLRequest(url: endpointUrl)
        endpointRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return endpointRequest
    }
    
    public static func processResponse (_ response: AFDataResponse<Any>, onSuccess: ((_: [Dog]) -> Void), onError: ((_: APIError?, _: Error) -> Void)) {
        print(
            """
            =============== API response =====================
            Response: \(String(describing: response.request))
            Response: \(String(data: response.data!, encoding: String.Encoding.utf8)!)
            ==================================================
            """
        )
        switch response.result {
        case .success:
            guard let baseResponse = Mapper<Dog>().mapArray(JSONString: String(data: response.data!, encoding: String.Encoding.utf8)!) else {
                return
            }
            onSuccess(baseResponse)
            break
        case .failure(let error):
            guard let baseErrorResponse = Mapper<APIError>().map(JSONString: String(data: response.data!, encoding: String.Encoding.utf8)!) else {
                return
            }
            onError(baseErrorResponse, error)
            break
        }

    }

    public static func getErrorResponse(_ response: DataResponse<Any,Error>) -> APIError? {
        do {
//            guard let baseErrorResponse = Mapper<APIError>().map(JSONString: String(data: try JSONSerialization.data(withJSONObject: nil, options: .prettyPrinted), encoding: .utf8)!) else {
//                return nil
//            }
            return nil
        } catch {
            return nil
        }
    }
}

public enum PlistKey {
    
    case ServerURL
    case APIVersion
    case ConnectionProtocol
    case APIKey

    func value() -> String {
        switch self {
        case .ServerURL:
            return "server_url"
        case .APIVersion:
            return "api_version"
        case .ConnectionProtocol:
            return "protocol"
        case .APIKey:
                return "api_key"
        }
    }
}

public struct Environment {
    
    fileprivate var infoDict: [String: Any] {
        if let dict = Bundle.main.infoDictionary {
            return dict
        } else {
            fatalError("Plist file not found")
        }
    }

    public func configuration(_ key: PlistKey) -> String {
        switch key {
        case .ServerURL:
            if let tmpValue = infoDict[PlistKey.ServerURL.value()] as? String, tmpValue != "" {
                return tmpValue + "/"
            }
            return ""
        case .APIVersion:
            if let tmpValue = infoDict[PlistKey.APIVersion.value()] as? String, tmpValue != "" {
                return tmpValue + "/"
            }
            return ""
        case .ConnectionProtocol:
            if let tmpValue = infoDict[PlistKey.ConnectionProtocol.value()] as? String, tmpValue != "" {
                return tmpValue + "://"
            }
            return ""
        case .APIKey:
            if let tmpValue = infoDict[PlistKey.APIKey.value()] as? String, tmpValue != "" {
                return tmpValue
            }
            return ""

        }
    }
}

struct JSON {
    static let encoder = JSONEncoder()
}

extension Encodable {
    subscript(key: String) -> Any? {
        return toDictionary[key]
    }
    var toDictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSON.encoder.encode(self))) as? [String: Any] ?? [:]
    }
}

class APIError: Mappable {
    
    var cod: Int?
    var message: String?
    
    required init?(map: Map) {}

    func mapping(map: Map) {
        cod       <- map["cod"]
        message        <- map["message"]
    }
}
