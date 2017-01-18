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
