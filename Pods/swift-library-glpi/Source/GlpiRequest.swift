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

public class GlpiRequest {

    /**
     Request a session token to uses other api endpoints.
     - parameter: userToken
     */
    class public func initSessionByUserToken(userToken: String, completion: @escaping (_ data: AnyObject?,  _ response: HTTPURLResponse?, _ error: Error?) -> Void) {
        
        GlpiRequest.httpRequest(Routers.initSessionByUserToken(userToken)) { data, response, error in
            completion(data, response, error)
        }
    }
    
    /**
     Request a session token to uses other api endpoints.
     - parameter: user
     - parameter: password
     */
    class public func initSessionByCredentials(user: String, password: String, completion: @escaping (_ data: AnyObject?,  _ response: HTTPURLResponse?, _ error: Error?) -> Void) {
        
        GlpiRequest.httpRequest(Routers.initSessionByCredentials(user, password)) { data, response, error in
            completion(data, response, error)
        }
    }
    
    /**
     Request kill current session
     */
    class public func killSession(completion: @escaping (_ data: AnyObject?, _ response: HTTPURLResponse?, _ error: Error?) -> Void) {
        
        GlpiRequest.httpRequest(Routers.killSession) { data, response, error in
            completion(data, response , error)
        }
    }
    
    /**
     Request get my profiles
     */
    class public func getMyProfiles(completion: @escaping (_ data: AnyObject?,  _ response: HTTPURLResponse?, _ error: Error?) -> Void) {
        
        GlpiRequest.httpRequest(Routers.getMyProfiles) { data, response, error in
            completion(data, response, error)
        }
    }
    
    /**
     Request get active profile
     */
    class public func getActiveProfile(completion: @escaping (_ data: AnyObject?,  _ response: HTTPURLResponse?, _ error: Error?) -> Void) {
        
        GlpiRequest.httpRequest(Routers.getActiveProfile) { data, response, error in
            completion(data, response, error)
        }
    }
    
    /**
     Request change active profile
     - parameter: profileID
     */
    class public func changeActiveProfile(profileID: String, completion: @escaping (_ data: AnyObject?, _ response: HTTPURLResponse?, _ error: Error?) -> Void) {

        var paylaod = [String: Any]()
        paylaod["profiles_id"] = profileID
        
        GlpiRequest.httpRequest(Routers.changeActiveProfile(paylaod)) { data, response, error in
            completion(data, response, error)
        }
    }
    
    /**
     Request get my entities
     - parameter: isRecursive (optional)
     */
    class public func getMyEntities(isRecursive: Bool = false, completion: @escaping (_ data: AnyObject?, _ response: HTTPURLResponse?, _ error: Error?) -> Void) {
        
        var queryString = [String: Any]()
        queryString["is_recursive"] = isRecursive
        
        GlpiRequest.httpRequest(Routers.getMyEntities(queryString)) { data, response, error in
            completion(data, response, error)
        }
    }
    
    /**
     Request get active entities
     */
    class public func getActiveEntities(completion: @escaping (_ data: AnyObject?, _ response: HTTPURLResponse?, _ error: Error?) -> Void) {
        
        GlpiRequest.httpRequest(Routers.getActiveEntities) { data, response, error in
            completion(data, response, error)
        }
    }
    
    /**
     Request change active entities
     - parameter: entitiesID (optional)
     - parameter: isRecursive (optional)
     */
    class public func changeActiveEntities(entitiesID: String = "all", isRecursive: Bool = false, completion: @escaping (_ data: AnyObject?, _ response: HTTPURLResponse?, _ error: Error?) -> Void) {
        
        var queryString = [String: Any]()
        queryString["is_recursive"] = isRecursive
        queryString["entities_id"] = entitiesID
        
        GlpiRequest.httpRequest(Routers.changeActiveProfile(queryString)) { data, response, error in
            completion(data, response, error)
        }
    }
    
    /**
     Request get full session information
     */
    class public func getFullSession(completion: @escaping (_ data: AnyObject?, _ response: HTTPURLResponse?, _ error: Error?) -> Void) {
        
        GlpiRequest.httpRequest(Routers.getFullSession) { data, response, error in
            completion(data, response, error)
        }
    }
    
    /**
     Request get Glpi Configuration
     */
    class public func getGlpiConfig(completion: @escaping (_ data: AnyObject?, _ response: HTTPURLResponse?, _ error: Error?) -> Void) {
        
        GlpiRequest.httpRequest(Routers.getGlpiConfig) { data, response, error in
            completion(data, response, error)
        }
    }
    
    /**
     Request get all items
     - parameter: itemType
     - parameter: params (optional)
     */
    class public func getAllItems(itemType: ItemType, params: [String: Any]? = nil, completion: @escaping (_ data: AnyObject?, _ response: HTTPURLResponse?, _ error: Error?) -> Void) {

        GlpiRequest.httpRequest(Routers.getAllItems(itemType, params)) { data, response, error in
            completion(data, response, error)
        }
    }
    
    /**
     Request get an item
     - parameter: itemType
     - parameter: itemID
     - parameter: params (optional)
     */
    class public func getItem(itemType: ItemType, itemID: Int, params: [String: Any]? = nil, completion: @escaping (_ data: AnyObject?, _ response: HTTPURLResponse?, _ error: Error?) -> Void) {
        
        GlpiRequest.httpRequest(Routers.getItem(itemType, itemID, params)) { data, response, error in
            completion(data, response, error)
        }
    }
    
    /**
     Request get an item
     - parameter: itemType
     - parameter: itemID
     - parameter: subItemTypes
     - parameter: params (optional)
     */
    class public func getSubItems(itemType: ItemType, itemID: Int, subItemType: ItemType, params: [String: Any]? = nil, completion: @escaping (_ data: AnyObject?, _ response: HTTPURLResponse?, _ error: Error?) -> Void) {
        
        GlpiRequest.httpRequest(Routers.getSubItems(itemType, itemID, subItemType, params)) { data, response, error in
            completion(data, response, error)
        }
    }
    
    /**
     Request Add Items
     - parameter: itemType
     - parameter: contentType (optional)
     - parameter: payload
     */
    class public func addItems(itemType: ItemType, contentType: String = "application/json", payload: [String: Any], completion: @escaping (_ data: AnyObject?, _ response: HTTPURLResponse?, _ error: Error?) -> Void) {
        
        GlpiRequest.httpRequest(Routers.addItems(itemType, contentType, payload)) { data, response, error in
            completion(data, response, error)
        }
    }
    
    /**
     Request Update Items
     - parameter: itemType
     - parameter: itemID (optional)
     - parameter: payload
     */
    class public func updateItems(itemType: ItemType, itemID: Int? = nil, payload: [String: Any], completion: @escaping (_ data: AnyObject?, _ response: HTTPURLResponse?, _ error: Error?) -> Void) {
        
        GlpiRequest.httpRequest(Routers.updateItems(itemType, itemID, payload)) { data, response, error in
            completion(data, response, error)
        }
    }
    
    /**
     Request Delete Items
     - parameter: itemType
     - parameter: itemID (optional)
     - parameter: params (optional)
     - parameter: payload (optional)
     */
    class public func deleteItems(itemType: ItemType, itemID: Int? = nil, params: [String: Any]? = nil, payload: [String: Any]? = nil, completion: @escaping (_ data: AnyObject?, _ response: HTTPURLResponse?, _ error: Error?) -> Void) {
        
        GlpiRequest.httpRequest(Routers.deleteItems(itemType, itemID, params, payload)) { data, response, error in
            completion(data, response, error)
        }
    }
    
    /**
     Request Lost password
     - parameter: email
     */
    class public func recoveryPassword(email: String, completion: @escaping (_ data: AnyObject?, _ response: HTTPURLResponse?, _ error: Error?) -> Void) {
        
        var payload = [String: Any]()
        payload["email"] = email
        
        GlpiRequest.httpRequest(Routers.lostPassword(payload)) { data, response, error in
            completion(data, response, error)
        }
    }
    
    /**
     Request reset password
     - parameter: payload
     */
    class public func resetPassword(payload: [String: Any], completion: @escaping (_ data: AnyObject?, _ response: HTTPURLResponse?, _ error: Error?) -> Void) {
        
        GlpiRequest.httpRequest(Routers.lostPassword(payload)) { data, response, error in
            completion(data, response, error)
        }
    }
    
    /**
     Request get multiple items
     - parameter: params
     */
    class public func getMultipleItems(params: [String: Any], completion: @escaping (_ data: AnyObject?, _ response: HTTPURLResponse?, _ error: Error?) -> Void) {
        
        GlpiRequest.httpRequest(Routers.getMultipleItems(params)) { data, response, error in
            completion(data, response, error)
        }
    }
    
    /**
     Request list search option
     - parameter: itemType
     - parameter: params (optional)
     */
    class public func listSearchOptions(itemType: ItemType, params: [String: Any]? = nil, completion: @escaping (_ data: AnyObject?, _ response: HTTPURLResponse?, _ error: Error?) -> Void) {
        
        GlpiRequest.httpRequest(Routers.listSearchOptions(itemType, params)) { data, response, error in
            completion(data, response, error)
        }
    }
    
    /**
     Request list search option
     - parameter: itemType
     - parameter: params (optional)
     */
    class public func searchItems(itemType: ItemType, params: [String: Any]? = nil, completion: @escaping (_ data: AnyObject?, _ response: HTTPURLResponse?, _ error: Error?) -> Void) {
        
        GlpiRequest.httpRequest(Routers.searchItems(itemType, params)) { data, response, error in
            completion(data, response, error)
        }
    }
    
    /**
     Handler http request
     - parameter: router
     */
    class func httpRequest(_ router: Routers, completion: @escaping (_ data: AnyObject?, _ response: HTTPURLResponse?, _ error: Error?) -> Void) {
        
        let task:URLSessionDataTask = URLSession.shared.dataTask(with: router.request()) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let httpResponse = response as? HTTPURLResponse{
                    if httpResponse.statusCode >= 400 {
                        completion(GlpiRequest.handlerErrorData(data, error, httpResponse.statusCode) as AnyObject, response as? HTTPURLResponse, error)
                    } else {
                        
                        guard error == nil, let responseData = data else {
                            completion(GlpiRequest.handlerErrorData(data, error, httpResponse.statusCode) as AnyObject, response as? HTTPURLResponse, error)
                            return
                        }
                        
                        // parse the result as JSON
                        // then create a Todo from the JSON
                        do {
                            if let dataJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] {
                                
                                switch router {
                                case .initSessionByUserToken, .initSessionByCredentials:
                                    if let session_token = dataJSON["session_token"] {
                                        GlpiConfig.SESSION_TOKEN = session_token as? String ?? ""
                                    }
                                default:
                                    break
                                }
                                completion(dataJSON as AnyObject, response as? HTTPURLResponse, nil)
                                
                            } else {
                                // couldn't create a todo object from the JSON
                                completion(GlpiRequest.handlerErrorData(data, error, httpResponse.statusCode) as AnyObject, response as? HTTPURLResponse, error)
                            }
                        } catch {
                            // error trying to convert the data to JSON using JSONSerialization.jsonObject
                            completion(GlpiRequest.handlerErrorData(data, error, httpResponse.statusCode) as AnyObject, response as? HTTPURLResponse, error)
                            return
                        }
                    }
                }
            }
        }
        task.resume()
    }
    
    /**
     handler Error
     - return: error message
     */
    class func handlerErrorData(_ data: Data?, _ error: Error?, _ errorCode: Int) -> [String: String]  {
        
        var errorObj = [String]()
        var errorDict = [String: String]()
        
        if let result = data {
            do {
                errorObj = try JSONSerialization.jsonObject(with: result) as? [String] ?? [String]()
            } catch {
                errorObj = [String]()
            }
        }
        
        if errorObj.count == 2 {
            errorDict["error"] = errorObj[0]
            errorDict["message"] = errorObj[1]
        } else {
            errorDict["error"] = "\(errorCode)"
            errorDict["message"] = "\(error?.localizedDescription ?? "unknown error")"
        }
        
        return errorDict
    }
}
