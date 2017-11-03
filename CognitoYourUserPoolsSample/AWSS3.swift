//
//  AWSS3.swift
//  CognitoYourUserPoolsSample
//
//  Created by 何幸宇 on 10/31/17.
//  Copyright © 2017 Dubal, Rohan. All rights reserved.
//

import Foundation
import AWSCore
import AWSS3

func getFromS3(bucketName: String, fileKey: String, completion:@escaping (Any?)->Void){
    
    let transferManager = AWSS3TransferManager.default()
    let downloadingFileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileKey)
    let downloadRequest = AWSS3TransferManagerDownloadRequest()
    downloadRequest?.bucket = bucketName
    downloadRequest?.key = fileKey
    downloadRequest?.downloadingFileURL = downloadingFileURL
    transferManager.download(downloadRequest!).continueWith(executor: AWSExecutor.mainThread(), block: { (task:AWSTask<AnyObject>) -> Any? in
        
        if let error = task.error as? NSError {
            if error.domain == AWSS3TransferManagerErrorDomain, let code = AWSS3TransferManagerErrorType(rawValue: error.code) {
                switch code {
                case .cancelled, .paused:
                    break
                default:
                    print("Error downloading: \(downloadRequest?.key) Error: \(error)")
                }
            } else {
                print("Error downloading: \(downloadRequest?.key) Error: \(error)")
            }
            return nil
        }
        print("Download complete for: \(downloadRequest?.key)")
        let downloadOutput = task.result
        completion(downloadingFileURL)
        return nil
    })
    
}

