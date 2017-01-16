//
//  Geral.swift
//  TMDBApp
//
//  Created by Richard Leh on 19/12/2016.
//  Copyright © 2016 Richard Leh. All rights reserved.
//

import Foundation

typealias CompletionResultError = (_ result: Any?, _ error: Error?) -> Void
typealias DictionaryData = Dictionary<String, Any>

func updatesOnMain(_ updatesToMake: @escaping () -> Void) {
    DispatchQueue.main.async {
        updatesToMake()
    }
}
