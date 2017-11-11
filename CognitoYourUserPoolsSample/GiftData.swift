//
//  GiftData.swift
//  CognitoYourUserPoolsSample
//
//  Created by Matthew Reading on 11/11/17.
//  Copyright © 2017 Dubal, Rohan. All rights reserved.
//

import Foundation
import UIKit
import AWSDynamoDB

class GiftData: AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    
    var _userId: String?
    var _likes: Array<String>?
    var _dislikes: Array<String>?
    var _price_range: Int?
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
            "_user" : _hashKeyAttribute,
            "_likes" : "likes",
            "_dislikes" : "dislikes",
            "_price_range" : "price_range"
        ]
    }
}



