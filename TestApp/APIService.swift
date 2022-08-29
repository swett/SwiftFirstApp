//
//  APIService.swift
//  TestApp
//
//  Created by Nikita Kurochka on 28.07.2022.
//

import UIKit
import Alamofire
class APIService: NSObject {
    typealias Completion = (_ success:Bool) -> Void
    func fetchData(completion: @escaping Completion) {
        let request = AF.request("https://api.unsplash.com/photos/?client_id=ab3411e4ac868c2646c0ed488dfd919ef612b04c264f3374c97fff98ed253dc9").validate().responseJSON { responseJson in
            switch responseJson.result {
            case .success(let value):
                if  let photos = value as? [[String: Any]] {
                    photos.forEach { photo in
                        let photoItem = Photoitem()
                        //
                        photoItem.Id = photo["id"] as? String
                        photoItem.likes = photo["likes"] as? Int
                        //
                        var user = photo["user"] as! [String: Any]
                        photoItem.nickName = user["username"]! as? String
                        //
                        let images = user["profile_image"] as! [String: String]
                        photoItem.profileImage = URL(string: images["medium"]!)
                        //                                print(photoItem.photoImage)
                        let urls = photo["urls"] as! [String: String]
                        photoItem.photoImage =  URL(string: urls["regular"]!)
                        
                        AppData.shared.photosArray.append(photoItem)
                    }
                    
                    
                }
                completion(true)
            
            
            
        case .failure(let error):
            print(error)
            completion(false)
        }
    }
    
}
}
