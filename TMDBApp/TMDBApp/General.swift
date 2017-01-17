//
//  Geral.swift
//  TMDBApp
//
//  Created by Richard Leh on 19/12/2016.
//  Copyright © 2016 Richard Leh. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

typealias CompletionResultError = (_ result: Any?, _ error: Error?) -> Void
typealias DictionaryData = Dictionary<String, Any>

func updatesOnMain(_ updatesToMake: @escaping () -> Void) {
    DispatchQueue.main.async {
        updatesToMake()
    }
}

func genrerFormatedString(fromMovie movie:Movie) -> String{
    if let mGenres = movie.genres {
        
        var genresString = ""
        
        let genresNames = mGenres.map { $0.name }
        for (index, name) in genresNames.enumerated(){
            guard let name = name else{
                break
            }
            genresString = genresString + name
            if index != genresNames.count - 1{
                genresString = genresString + ", "
            }
        }
        
        return genresString
    }
    return ""
}


// MARK: Extensions

extension UIViewController {
    
    func showProgress() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        SVProgressHUD.show()
    }
    func dismissProgress() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        SVProgressHUD.dismiss()
    }
    
}

extension String {
    
    var dateStringFormated: String{
        get{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: self)
            
            dateFormatter.dateFormat = "MMMM dd, yyyy"
            
            if let date = date {
                let dateString = dateFormatter.string(from: date)
                
                return dateString
            }
            return ""
        }
    }
    
}
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.characters.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
