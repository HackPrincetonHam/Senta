//
//  DisplayViewController.swift
//  CognitoYourUserPoolsSample
//
//  Created by 何幸宇 on 10/31/17.
//  Copyright © 2017 Dubal, Rohan. All rights reserved.
//

import UIKit
import AWSCore
import AWSCognito
import AWSDynamoDB
import AWSCognitoIdentityProvider

class DisplayViewController: UIViewController {
    

    var user : AWSCognitoIdentityUser?
    var response : AWSCognitoIdentityUserGetDetailsResponse?
    var pool : AWSCognitoIdentityUserPool?
    var pastMessages : [String:String]?

    
    @IBAction func SignOutTapped(_ sender: UIButton){
            self.user?.signOut()
            self.title = nil
//        self.performSegue(withIdentifier: "loggedOut", sender: nil)
}
    
    @IBAction func BtnTapped(_ sender: UIButton) {
//        getFromS3(bucketName: "hamex-storage", fileKey: "horse.jpg") { (url) in
//            if let url = url as? URL{
//                self.Image.image = UIImage(contentsOfFile: url.path)
//            }
//        }
//
//        read_DDB { (message) in
//            print(message._text!)
//            print("this is read_DDB")
//        }
//
//        query_DDB { (message) in
//            print(message._text!)
//            print("this is query_DDB")
//        }
        
    }
    
    @IBAction func SendBtnTapped(_ sender: UIButton){
        performSegue(withIdentifier: "roleSelectionSegue", sender: nil)
//        let time = DateFormatter.localizedString(from: .init(), dateStyle: .short, timeStyle: .short)
        //S3
//        if let textInput = textInput.text{
//        dataset?.setString(textInput, forKey:time)
//            dataset?.synchronize().continueWith(block: { (task) -> Any? in
//                if task.error != nil{
//                }
//                    return nil
//            })
//        }else{return}
//        textInput.text = ""
//        pastMessages = dataset?.getAll()
        
        //DynamoDB
        
        
//        save_DDB(date: "11/4/17, 11:55 PM", text: textInput.text!, userId: "newUserID") {
//            return
//        }
    
//        MessengeTableView.reloadData()
}
    
    
   
    
    var dataset : AWSCognitoDataset?
    override func viewDidLoad() {
        super.viewDidLoad()
//        MessengeTableView.dataSource = self
//        MessengeTableView.delegate = self
        let syncClient = AWSCognito.default()
         dataset = syncClient.openOrCreateDataset("myDataset")
         pastMessages = dataset?.getAll()
        self.pool = AWSCognitoIdentityUserPool(forKey: AWSCognitoUserPoolsSignInProviderKey)
        self.user = self.pool?.currentUser()
        getUserInfo(user: self.user!)
    }
}
