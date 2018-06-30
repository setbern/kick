//
//  ApiClient.swift
//  Kick
//
//  Created by BernSternWhoEarns on 11/8/17.
//  Copyright © 2017 BernSternWhoEarns. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit


class ApiClient {
    static let API_VERSION = "1"
    let SETAPI_VERSION = "1"
    
    static let defaults = UserDefaults.standard
    
    //static let API_BASE_URL = true ? "http://localhost:3000" : "https://api.setmine.com"
    //static let API_ROOT = SETAPI_ROOT
    
    static let API_ROOT_GRAPH = "https://heartiest-uguisu-6964.dataplicity.io/api/v/1/graph"
    
    static func graph(query: String) -> Promise<JSON> {
        return Alamofire
            .request(
                API_ROOT_GRAPH,
                method: .post,
                parameters: ["query": query],
                encoding: JSONEncoding.default,
                headers: [:]
            )
            .responseJSON()
            .then { json in
                print("shit")
                return GeneralHelper.createJson(json: json)
            }.catch(execute: { (error) in
                print("graph Error: \(error)")
            })
    }
    
    static func json(urlString: String) -> Promise<JSON> {
        return Alamofire
            .request(
                urlString,
                method: .get,
                encoding: JSONEncoding.default
            )
            .responseJSON()
            .then { json in
                return JSON(json)
            }.catch(execute: { (error) in
                print("json Error: \(error)")
            })
    }
    
   
    static func toggleLight(socket: [Socket]) -> Promise<JSON> {
        var query: String
        if socket.count > 1 {
            
            var dataString : String = ""
            for sock in socket {
                let str = "{light: \"\(sock.socketName)\", status: \(sock.status)},"
                dataString += str
            }
            
            print("dataString \(dataString)")
            let socketString = "[\(dataString)]"
            
             query = "query{toggleLights(socket: \(socketString) )}"

        } else  {
             query = "query{toggleLights(socket: [{light: \"\(socket[0].socketName)\", status: \(socket[0].status) }] )}"
        }
        
        
        
        
        
        print("query \(query)")
        print("toggleLight QUERY STRING: \(query)")
        
        
        
        return graph(query: query)
            .then { json in
                return json
            }

        }

    
}

