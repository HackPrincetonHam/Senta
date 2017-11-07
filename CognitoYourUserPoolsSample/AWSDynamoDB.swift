//
//  AWSDynamoDB.swift
//  CognitoYourUserPoolsSample
//
//  Created by 何幸宇 on 11/3/17.
//  Copyright © 2017 Dubal, Rohan. All rights reserved.
//

import Foundation
import AWSCore
import AWSDynamoDB
import CoreML

//to update, you need to have the same sort key and partition key.
func DDBSave(date: String, text: String, userId: String, completion: ()->Void){
    
let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
let MessengeItem : Messenges = Messenges()
MessengeItem._userId = userId
MessengeItem._date = date
MessengeItem._text = text
    
    dynamoDBObjectMapper.save(MessengeItem) { (error) in
        if error != nil{
            print(error!)
            return
        }else{
            print("SAVED!")
        }
    }
}


func DDBRead( completion:@escaping (Messenges)->Void){
    let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
    
    dynamoDBObjectMapper.load(Messenges.self, hashKey: UserInfor["sub"]!, rangeKey: "11/4/17, 11:55 PM") { (item, Error) in
        if Error != nil{
            print(Error!)
        }else{
        if let messageItem = item as? Messenges{
        completion(messageItem)
            }
        }
    }
}

//query is for viewing multiple items.
func DDBQuery(completion:@escaping (Messenges)->Void){
    
    // 1) Configure the query
    
    let queryExpression = AWSDynamoDBQueryExpression()
    
    //you can only put rangeKey and partition key here
    queryExpression.keyConditionExpression = "#otherID = :otherID"
    
    //to use filter expression, you need to user # and in combination with attributeValues
    //queryExpression.filterExpression = "#text = :text"
    
    //the otherID needs to be the name of the attribute or the name of the with the addition of "#" in the front and in combination with expressionAttributeNames. add "#attributeionName" = "attributionName"
//    queryExpression.expressionAttributeNames = [
//        "abcd" : "otherID"
//    ]
    
    queryExpression.expressionAttributeNames = [
        "#otherID" : "otherID"
    ]
    
    queryExpression.expressionAttributeValues = [
        ":otherID" : "4c9c7d6e-9df1-4696-b4da-ecfd55cb1b52",
    ]
    
    // 2) Make the query
    
    let dynamoDbObjectMapper = AWSDynamoDBObjectMapper.default()
    
    dynamoDbObjectMapper.query(Messenges.self, expression: queryExpression) { (output: AWSDynamoDBPaginatedOutput?, error: Error?) in
        if error != nil {
            print("The request failed. Error: \(String(describing: error))")
        }
        if output != nil {
            for news in output!.items {
                let newsItem = news as? Messenges
                completion(newsItem!)
            }
        }
    }
}

func DDBDelete(date: String, text: String, userID: String, completion: @escaping ()->Void){
    let dynamoDBObjectMapper = AWSDynamoDBObjectMapper.default()
    let message = Messenges()
    
    message?._date = date
    message?._text = text
    message?._userId = userID
    
    dynamoDBObjectMapper.remove(message!) { (error) in
        if error != nil{
            print("Amazon Dynamo DB Error: \(error!)")
            return
        }else{
            completion()
        }
    }
}
