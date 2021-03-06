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
    
    static let key = "28190e24b6d3d0b73a9b5842bee9d8bf" // 1f54bd990f1cdfb230adb312546d765d​
    
    static let upcomingPath = "https://api.themoviedb.org/3/movie/upcoming"
    static let genrerPath   = "https://api.themoviedb.org/3/genre/movie/list"
    static let searchPath   = "http://api.themoviedb.org/3/search/movie"
    static let imagePath    = "https://image.tmdb.org/t/p/w780"
    
}

enum RequestError: Error {
    case InvalidRequest(String)
}

class Requests: NSObject{
    
    class func sharedInstance() -> Requests {
        struct Singleton {
            static var sharedInstance = Requests()
        }
        return Singleton.sharedInstance
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
    
    func requestMovies(fromPage page:Int = 1, withQuery query:String = "", completion: @escaping CompletionResultError) {
        
        if query.isEmpty{
            self.requestUpcomingMovies(fromPage: page, completion: completion)
        }else{
            self.requestSearchMovies(fromPage: page, withQuery: query, completion: completion)
        }
    
    }
    func requestSearchMovies(fromPage page:Int = 1,withQuery query:String, completion: @escaping CompletionResultError) {
        
        let requestString = TMDBMovieAPI.searchPath +
                            "?api_key=" + TMDBMovieAPI.key +
                            "&language=" + Language.getDefaultLanguage() +
                            "&query=" + query +
                            "&page=" + String(page)
        
        let requestStringEncoded = requestString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        do {
            guard let string = requestStringEncoded else{
                throw RequestError.InvalidRequest("This is an invalid request string")
            }
            
            self.request(fromString: string, withCompletion: completion)
            
        } catch {
            completion(nil, error)
        }
    }
    
    func requestUpcomingMovies(fromPage page:Int = 1, completion: @escaping CompletionResultError) {
        
        let requestString = TMDBMovieAPI.upcomingPath +
                            "?api_key=" + TMDBMovieAPI.key +
                            "&language=" + Language.getDefaultLanguage() +
                            "&page=" + String(page)
        self.request(fromString: requestString, withCompletion: completion)
    }
    
    func requestGenrer(completion: @escaping CompletionResultError) {
        
        let requestString = TMDBMovieAPI.genrerPath +
                            "?api_key=" + TMDBMovieAPI.key +
                            "&language=" + Language.getDefaultLanguage()
        
        self.request(fromString: requestString, withCompletion: completion)
    }
    
    func gerURL(forImagePath imagePath:String) -> URL?{
        if let url = URL(string: TMDBMovieAPI.imagePath + imagePath){
            return url
        }
        return nil
    }
    
}


