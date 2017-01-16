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
struct TMDBMovieAPI {
    static let upcomingPath = "https://api.themoviedb.org/3/movie/upcoming"
    
    static let key = "28190e24b6d3d0b73a9b5842bee9d8bf"
    
    static let APIScheme = "https"
    static let APIHost = "api.themoviedb.org"
    static let APIPath = "/3"
    static let APIMethod = "/movie/upcoming"
}

struct TMDBMovieKeys {
    static let APIKEY = "api_key"
    static let Language = "language"
    static let Page = "page"
}

struct TMDBMovieValues {
    static let APIKEY = "28190e24b6d3d0b73a9b5842bee9d8bf"
    static let Language = "en-US"
    static let Page = "1"
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
            debugPrint(response)
            
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
        
        let requestString = TMDBMovieAPI.upcomingPath + "/?api_key=" + TMDBMovieAPI.key + "&page=" + String(page)
        self.request(fromString: requestString, withCompletion: completion)
    }
}

/*
 
 {
 "poster_path": "/ylXCdC106IKiarftHkcacasaAcb.jpg",
 "adult": false,
 "overview": "Mia, an aspiring actress, serves lattes to movie stars in between auditions and Sebastian, a jazz musician, scrapes by playing cocktail party gigs in dingy bars, but as success mounts they are faced with decisions that begin to fray the fragile fabric of their love affair, and the dreams they worked so hard to maintain in each other threaten to rip them apart.",
 "release_date": "2016-12-01",
 "genre_ids": [
 10749,
 35,
 18,
 10402
 ],
 "id": 313369,
 "original_title": "La La Land",
 "original_language": "en",
 "title": "La La Land",
 "backdrop_path": "/nadTlnTE6DdgmYsN4iWc2a2wiaI.jpg",
 "popularity": 20.131656,
 "vote_count": 260,
 "video": false,
 "vote_average": 8
 }
 
 */
