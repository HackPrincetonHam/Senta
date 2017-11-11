//
//  RoleRegister.swift
//  CognitoYourUserPoolsSample
//
//  Created by 何幸宇 on 11/11/17.
//  Copyright © 2017 Dubal, Rohan. All rights reserved.
//

import UIKit

class RoleRegisterViewController:UIViewController  {
    
    @IBAction func chooseRole(_ sender: UIButton){
        save_DDB(role: sender.currentTitle!) {
          
        }
        

    }
    
}
