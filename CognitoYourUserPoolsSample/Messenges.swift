
import Foundation
import UIKit
import AWSDynamoDB

class Messenges: AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    
    var _userId: String?
    var _date: String?
    var _text: String?
    static var _tableName: String = "Message"
    static var _hashKeyAttribute: String = "otherID"
    static var _rangeKeyAttribute: String = "date"
    
    
    
    class func dynamoDBTableName() -> String {

        return _tableName
    }
    
    class func hashKeyAttribute() -> String {

        return _hashKeyAttribute
    }
    
    class func rangeKeyAttribute() -> String {
        
        return _rangeKeyAttribute
    }
    
    override class func jsonKeyPathsByPropertyKey() -> [AnyHashable: Any] {
        return [
                "_date" : _rangeKeyAttribute,
               "_userId" : _hashKeyAttribute,
               "_text" : "text",
        ]
    }
}


