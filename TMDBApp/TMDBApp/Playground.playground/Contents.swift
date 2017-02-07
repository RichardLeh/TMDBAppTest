//: Playground - noun: a place where people can play

import Foundation
import UIKit
import Alamofire

Alamofire.request("https://api.themoviedb.org/3/movie/76341?api_key=28190e24b6d3d0b73a9b5842bee9d8bf").validate().responseJSON { response in
    debugPrint(response)
    
    switch response.result {
    case .success:
        print("Validation Successful")
        if let json = response.result.value {
            print("JSON: \(json)")
        }
    case .failure(let error):
        print(error)
    }
}
