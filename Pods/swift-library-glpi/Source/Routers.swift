/**
 *  LICENSE
 *
 *  This file is part of the GLPI API Client Library for Swift,
 *  a subproject of GLPI. GLPI is a free IT Asset Management.
 *
 *  Glpi is Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *  -----------------------------------------------------------------------------------
 *  @author    Hector Rondon - <hrondon@teclib.com>
 *  @copyright Copyright Teclib. All rights reserved.
 *  @license   Apache License, Version 2.0 https://www.apache.org/licenses/LICENSE-2.0
 *  @link      https://github.com/glpi-project/swift-library-glpi
 *  @link      https://glpi-project.github.io/swift-library-glpi/
 *  @link      http://www.glpi-project.org/
 *  -----------------------------------------------------------------------------------
 */

import Foundation

public enum Routers: URLRequestDelegate {
    
    /// GET /initSession
    case initSessionByUserToken(String)
    /// GET /initSession
    case initSessionByCredentials(String, String)
    /// GET /killSession
    case killSession
    /// GET /getMyProfiles
    case getMyProfiles
    /// GET /getActiveProfile
    case getActiveProfile
    /// POST /changeActiveProfile
    case changeActiveProfile([String: Any]?)
    /// GET /getMyEntities
    case getMyEntities([String: Any]?)
    /// GET /getActiveEntities
    case getActiveEntities
    /// POST /changeActiveEntities
    case changeActiveEntities([String: Any]?)
    /// GET /getFullSession
    case getFullSession
    /// GET /getGlpiConfig
    case getGlpiConfig
    /// GET /:itemtype
    case getAllItems(ItemType, [String: Any]?)
    /// GET /:itemtype/:id
    case getItem(ItemType, Int, [String: Any]?)
    /// GET /:itemtype/:id/:sub_itemtype
    case getSubItems(ItemType, Int, ItemType, [String: Any]?)
    /// GET /getMultipleItems
    case getMultipleItems([String: Any]?)
    /// POST /:itemtype
    case addItems(ItemType, String, [String: Any]?)
    /// PUT /:itemtype/:id
    case updateItems(ItemType, Int?, [String: Any]?)
    /// DELETE /:itemtype/:id
    case deleteItems(ItemType, Int?, [String: Any]?, [String: Any]?)
    /// PUT /lostPassword
    case lostPassword([String: Any]?)
    /// GET /listSearchOptions/:itemtype
    case listSearchOptions(ItemType, [String: Any]?)
    /// GET /search/:itemtype
    case searchItems(ItemType, [String: Any]?)
    
    /// get HTTP Method
    var method: HTTPMethod {
        switch self {
        case .initSessionByUserToken, .initSessionByCredentials, .killSession, .getMyProfiles, .getActiveProfile,
             .getMyEntities, .getActiveEntities, .getFullSession, .getGlpiConfig,
             .getMultipleItems, .getAllItems, .getItem, .getSubItems, .listSearchOptions, .searchItems:
            return .get
        case .changeActiveProfile, .changeActiveEntities, .addItems:
            return .post
        case .updateItems, .lostPassword:
            return .put
        case .deleteItems:
            return .delete
        }
    }
    
    /// build up and return the URL for each endpoint
    var path: String {
        
        switch self {
        case .initSessionByUserToken, .initSessionByCredentials:
            return "/initSession"
        case .killSession:
            return "/killSession"
        case .getMyProfiles:
            return "/getMyProfiles"
        case .getActiveProfile:
            return "/getActiveProfile"
        case .changeActiveProfile:
            return "/changeActiveProfile"
        case .getMyEntities:
            return "/getMyEntities"
        case .getActiveEntities:
            return "/getActiveEntities"
        case .changeActiveEntities:
            return "/changeActiveEntities"
        case .getFullSession:
            return "/getFullSession"
        case .getGlpiConfig:
            return "/getGlpiConfig"
        case .getAllItems(let itemType, _):
            return "/\(itemType)"
        case .getItem(let itemType, let itemID, _):
            return "/\(itemType)/\(itemID)"
        case .getSubItems(let itemType, let itemID, let subItemType, _):
            return "/\(itemType)/\(itemID)/\(subItemType)"
        case .getMultipleItems:
            return "/getMultipleItems"
        case .addItems(let itemType, _, _):
            return "/\(itemType)"
        case .updateItems(let itemType, let itemID, _):
            if let id = itemID {
                return "/\(itemType)/\(id)"
            } else {
                return "/\(itemType)"
            }
        case .deleteItems(let itemType, let itemID, _, _):
            if let id = itemID {
                return "/\(itemType)/\(id)"
            } else {
                return "/\(itemType)"
            }
        case .lostPassword:
            return "/lostPassword"
        case .listSearchOptions(let itemType, _):
            return "/listSearchOptions/\(itemType)"
        case .searchItems(let itemType, _):
            return "/search/\(itemType)"
        }
    }
    
    /// build up and return the query for each endpoint
    var query: [URLQueryItem]? {

        switch self {
        case .initSessionByUserToken, .initSessionByCredentials, .killSession, .getMyProfiles, .getActiveProfile,
             .changeActiveProfile, .getActiveEntities, .changeActiveEntities,
             .getFullSession, .getGlpiConfig, .addItems, .updateItems, .lostPassword:
            return  nil
        case .getMyEntities(let params), .getAllItems(_, let params), .getItem(_, _, let params),
             .getSubItems(_, _, _, let params), .getMultipleItems(let params), .deleteItems(_, _, let params, _),
             .listSearchOptions(_, let params), .searchItems(_, let params):
            if let queryString = params {
                return queryString.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
            } else {
                return nil
            }
        }
    }
    
    /// build up and return the header for each endpoint
    var header: [String: String] {
        
        var dictHeader = [String: String]()
        dictHeader["Content-Type"] = "application/json"
        if !GlpiConfig.APP_TOKEN.isEmpty {
            dictHeader["App-Token"] = GlpiConfig.APP_TOKEN
        }
        
        switch self {
        case .initSessionByUserToken(let userToken) :
            
            dictHeader["Authorization"] = "user_token \(userToken)"
            
            return dictHeader
        case .initSessionByCredentials(let user, let password):
            let credentialData = "\(user):\(password)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
            let base64Credentials = credentialData.base64EncodedString()
            
            dictHeader["Authorization"] = "Basic \(base64Credentials)"
            
            return dictHeader
        case .addItems(_, let contentType, _):
            dictHeader["Content-Type"] = contentType
            
            return dictHeader
        default:
            
            dictHeader["Session-Token"] = GlpiConfig.SESSION_TOKEN
            return dictHeader
        }
    }
    
    /**
     Returns a URL request or throws if an `Error` was encountered
     
     - throws: An `Error` if the underlying `URLRequest` is `nil`.
     - returns: A URL request.
     */
    public func request() -> URLRequest {
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = GlpiConfig.URL?.scheme ?? ""
        urlComponents.host = GlpiConfig.URL?.host ?? ""
        urlComponents.path = "\(GlpiConfig.URL?.path ?? "")\(path)"
        urlComponents.queryItems = query
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        urlRequest.httpMethod = method.rawValue
        
        for (key, value) in header {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        switch self {
        case .changeActiveProfile(let payload), .changeActiveEntities(let payload), .addItems(_, _, let payload), .updateItems(_, _, let payload), .lostPassword(let payload), .deleteItems(_, _, _, let payload):

            if let jsonData = try? JSONSerialization.data(withJSONObject: payload ?? [String : Any](), options: []) {
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    urlRequest.httpBody = jsonString.data(using: .utf8)
                }
            }
            return urlRequest
        default:
            return urlRequest
        }
    }
}

/// Types adopting the `URLRequestDelegate` protocol can be used to construct URL requests.
public protocol URLRequestDelegate {
    
    /// Returns a URL request
    ///
    /// - returns: A URL request.
    func request() -> URLRequest
}

public enum HTTPMethod : String {
    
    case options
    
    case get
    
    case head
    
    case post
    
    case put
    
    case patch
    
    case delete
    
    case trace
    
    case connect
}
