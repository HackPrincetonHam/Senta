//
// Copyright 2014-2017 Amazon.com,
// Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Amazon Software License (the "License").
// You may not use this file except in compliance with the
// License. A copy of the License is located at
//
//     http://aws.amazon.com/asl/
//
// or in the "license" file accompanying this file. This file is
// distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, express or implied. See the License
// for the specific language governing permissions and
// limitations under the License.
//

import Foundation
import AWSCognitoIdentityProvider

class displayViewController : UIViewController {
    @IBOutlet weak var Image: UIImageView!
    @IBAction func BtnTapped(_ sender: UIButton) {
        getFromS3(bucketName: "hamex-storage", fileKey: "horse.jpg") { (dowloadingFileURL) in
            DispatchQueue.main.async {
                if let url = dowloadingFileURL as? URL{
                    self.Image.image = UIImage(contentsOfFile: url.path )
                }else{return}
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
}

