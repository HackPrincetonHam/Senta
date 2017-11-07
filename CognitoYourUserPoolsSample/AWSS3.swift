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

func s3download(bucketName: String, fileKey: String, completion:@escaping (Any?)->Void){
    
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


func s3upload(url: String, bucketName: String, fileKey: String)->AWSS3TransferManagerUploadRequest{
    
    let transferManager = AWSS3TransferManager.default()
    
    let uploadingFileUrl = URL(fileURLWithPath: url)
    let uploadRequest = AWSS3TransferManagerUploadRequest()
    
    uploadRequest?.bucket = bucketName
    uploadRequest?.key = fileKey
    uploadRequest?.body = uploadingFileUrl
        
    transferManager.upload(uploadRequest!).continueWith(executor: AWSExecutor.mainThread()) { (task:AWSTask<AnyObject>) -> Any? in
        if let error = task.error as NSError?{
            if error.domain == AWSS3TransferManagerErrorDomain, let code = AWSS3TransferManagerErrorType(rawValue: error.code){
                switch code{
                case .cancelled:
                    break
                case .paused:
                    break
                default:
                    print("Uploading error: \(String(describing: uploadRequest?.key!)) error: \(error)")
                }
                
            }else{
                print("Uploading error: \(String(describing: uploadRequest?.key!)) error: \(error)")
                }
            }
        return nil
        }
    return uploadRequest!
}


func s3UploadPause(request: Any){
    if let uploadRequest = request as? AWSS3TransferManagerUploadRequest{
    uploadRequest.pause().continueOnSuccessWith(block: { (task) -> Any? in
        if let error = task.error as NSError?{
                print("Error: \(error)")
                return nil
        }
            return nil
    })
    }
    else if let downloadRequest = request as? AWSS3TransferManagerDownloadRequest{
        downloadRequest.pause().continueOnSuccessWith(block: { (task) -> Any? in
            if let error = task.error as NSError?{
                print("Error: \(error)")
                return nil
            }
            return nil
        })
    }
}

func s3UploadCancel(request: Any){
    if let uploadRequest = request as? AWSS3TransferManagerUploadRequest{
        uploadRequest.cancel().continueOnSuccessWith(block: { (task) -> Any? in
            if let error = task.error as NSError?{
                print("Error: \(error)")
                return nil
            }
            return nil
        })
    }
    else if let downloadRequest = request as? AWSS3TransferManagerDownloadRequest{
        downloadRequest.cancel().continueOnSuccessWith(block: { (task) -> Any? in
            if let error = task.error as NSError?{
                print("Error: \(error)")
                return nil
            }
            return nil
        })
    }
}

func s3UploadProgress(request: Any, completion: @escaping (Int64, Int64, Int64)->Void){
    if let uploadRequest = request as? AWSS3TransferManagerUploadRequest{
        uploadRequest.uploadProgress = {(bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) -> Void in
            DispatchQueue.main.async(execute: {() -> Void in
                completion(bytesSent, totalBytesSent, totalBytesSent)
            })
        }
    }
        
    else if let downloadRequest = request as? AWSS3TransferManagerUploadRequest{
        downloadRequest.uploadProgress = {(bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) -> Void in
            DispatchQueue.main.async(execute: {() -> Void in
                completion(bytesSent, totalBytesSent, totalBytesSent)
            })
        }
    }
}



