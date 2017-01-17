//
//  Requests.swift
//  TMDBApp
//
//  Created by Richard Leh on 19/12/2016.
//  Copyright © 2016 Richard Leh. All rights reserved.
//

import Foundation
import Alamofire

// MARK: API TMDB MOVIE
private struct TMDBMovieAPI {
    
    static let key = "28190e24b6d3d0b73a9b5842bee9d8bf"
    static let language = "en-US"// "en-UK", "pt-BR"
    
    static let upcomingPath = "https://api.themoviedb.org/3/movie/upcoming"
    static let genrerPath   = "https://api.themoviedb.org/3/genre/movie/list"
    static let imagePath    = "https://image.tmdb.org/t/p/w780/"
    
}

class Requests: NSObject{
    
    class func sharedInstance() -> Requests {
        struct Singleton {
            static var sharedInstance = Requests()
        }
        return Singleton.sharedInstance
    }
    
    func verifyNetwork(andMake request:String){
        let manager = NetworkReachabilityManager()
        
        manager?.listener = { status in
            print("Network Status Changed: \(status)")
        }
        
        manager?.startListening()
    }
    
    fileprivate func request(fromString requestString: String, withCompletion completion: @escaping CompletionResultError) {
        
        Alamofire.request(requestString).validate().responseJSON { response in
            //debugPrint(response)
            
            switch response.result {
            case .success:
                if let json = response.result.value {
                    completion(json, nil)
                }
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
        }
    }
    
    func requestUpcomingMovies(fromPage page:Int = 1, completion: @escaping CompletionResultError) {
        
        let requestString = TMDBMovieAPI.upcomingPath +
                            "?api_key=" + TMDBMovieAPI.key +
                            "&language=" + TMDBMovieAPI.language +
                            "&page=" + String(page)
        
        print(requestString)
        self.request(fromString: requestString, withCompletion: completion)
    }
    
    func requestGenrer(completion: @escaping CompletionResultError) {
        
        let requestString = TMDBMovieAPI.genrerPath +
                            "?api_key=" + TMDBMovieAPI.key +
                            "&language=" + TMDBMovieAPI.language
        
        print(requestString)
        self.request(fromString: requestString, withCompletion: completion)
    }
    
    func gerURL(forImagePath imagePath:String) -> URL?{
        if let url = URL(string: TMDBMovieAPI.imagePath + imagePath){
            return url
        }
        return nil
    }
    
}


