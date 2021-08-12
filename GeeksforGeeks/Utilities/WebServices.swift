//
//  WebServices.swift
//  GeeksforGeeks
//
//  Created by MAC on 11/08/21.
//

import Foundation
import Alamofire
class WebServices: NSObject {
    static let getInstance = WebServices()
    private override init() {
    }
    func requestWithGet(baseUrl: String, endUrl: String,onCompletion: (([String:Any]) -> Void)? = nil , onError: ((Error?) -> Void)? = nil){
        let url = baseUrl + endUrl

        Alamofire.request(url, method: .get ).responseJSON { response in
            
            switch response.result{
            case .success:
                onCompletion!(response.result.value as! [String:Any])
            case .failure:
                onError!( nil)
            }
        }
    }
}
