//
//  GeneralHelper.swift
//  Kick
//
//  Created by BernSternWhoEarns on 11/10/17.
//  Copyright © 2017 BernSternWhoEarns. All rights reserved.
//

import Foundation
import UIKit
import PromiseKit
import SwiftyJSON


class GeneralHelper {
    static func createJson(json: Any) -> Promise<JSON> {
        
        return Promise { fulfill, reject in
            
            let json = JSON(json)
            if(json["errors"].exists()) {
                print("error creating JSON: \(json["errors"][0]["message"].string!)")
                reject ("Error creating JSON!" as! Error)
                return
            }
            
            fulfill(json["data"])
        }
    }
}
