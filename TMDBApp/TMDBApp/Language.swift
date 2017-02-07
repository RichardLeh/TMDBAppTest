//
//  Language.swift
//  TMDBApp
//
//  Created by Richard Leh on 17/01/2017.
//  Copyright © 2017 Richard Leh. All rights reserved.
//

import Foundation

struct Language{
    static let defaulUserKey = "defaulLanguage"
    static let appResult = ["en-US", "pt-BR", "es-ES", "hr-HR", "ja-JP"]
    
    static func setDefaultLanguage(_ lang:String){
        let defaults = UserDefaults.standard
        defaults.set(lang, forKey: Language.defaulUserKey)
        defaults.synchronize()
    }
    
    static func getDefaultLanguage() -> String{
        let defaults = UserDefaults.standard
        guard let lang = defaults.value(forKey: Language.defaulUserKey) as? String else{
            return ""
        }
        return lang
    }
    
    static func getDefaultIndex() -> Int{
        let defaults = UserDefaults.standard
        guard let lang = defaults.value(forKey: Language.defaulUserKey) as? String,
            let index = appResult.index(of: lang) else{
                return 0
        }
        return index
    }
}
