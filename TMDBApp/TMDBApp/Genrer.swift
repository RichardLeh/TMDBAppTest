//
//  Genrer.swift
//  TMDBApp
//
//  Created by Richard Leh on 15/01/2017.
//  Copyright © 2017 Richard Leh. All rights reserved.
//

import Foundation

enum ServerTMDBGenrer:String{
    case id = "id"
    case name = "name"
}
class Genrer{
    var id:Int?
    var name:String?
    
    convenience init(withDict dictionary:DictionaryData) {
        self.init()
        
        if let _id = dictionary[ServerTMDBGenrer.id.rawValue] as? Int{
            self.id = _id
        }
        if let _name = dictionary[ServerTMDBGenrer.name.rawValue] as? String{
            self.name = _name
        }
    }
}

/*

class Genres: NSObject{
    
    var genres = [Genrer]()
    
    class func sharedInstance() -> Genres {
        struct Singleton {
            static var sharedInstance = Genres()
        }
        return Singleton.sharedInstance
    }
    func getGenre(byId id:Int) -> Genrer? {
        for genrer in genres {
            if genrer.id == id{
                return genrer
            }
        }
        return nil
    }
    
    fileprivate func getGenres(withCompletion completion: @escaping CompletionResultError) {
        Requests.sharedInstance().requestGenrer{ [weak self] (result, error) in
            
            guard result != nil, let resultDict = result as? DictionaryData else{
                completion(nil, error)
                return
            }
            self?.parseGenrer(resultDict)
            
            completion(true, nil)
        }
    }
    
    fileprivate func parseGenrer(_ data:DictionaryData){
        genres = [Genrer]()
        
        guard let results = data[jsonResult.genres.rawValue] as? [DictionaryData] else {
            return
        }
        for result in results{
            let genrer = Genrer(withDict: result)
            genres.append(genrer)
        }
    }
}
 
 */
