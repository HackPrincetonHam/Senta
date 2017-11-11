//
//  ReindeerData.swift
//  CognitoYourUserPoolsSample
//
//  Created by Matthew Reading on 11/11/17.
//  Copyright © 2017 Dubal, Rohan. All rights reserved.
//

import Foundation
import UIKit
import AWSDynamoDB

class ReindeerData: AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    
    var _userId: String?
    var _drop_date: String?
    var _drop_location: String?
    var _drop_time_range: String?
    var _identity: String?
    static var _tableName: String = "GiftData"
    static var _hashKeyAttribute: String = "user_sub"
    
    class func dynamoDBTableName() -> String {
        
        return _tableName
    }
    
    class func hashKeyAttribute() -> String {
        
        return _hashKeyAttribute
    }
    
    override class func jsonKeyPathsByPropertyKey() -> [AnyHashable: Any] {
        return [
            "_userId" : _hashKeyAttribute,
        "_drop_date" : "drop_date",
        "drop_location" : "drop_location",
        "_drop_time_range" : "drop_time_range",
        "_identity" : "identity"
        ]
    }
}
