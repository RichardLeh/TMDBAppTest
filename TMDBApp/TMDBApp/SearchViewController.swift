//
//  SearchViewController.swift
//  TMDBApp
//
//  Created by Richard Leh on 17/01/2017.
//  Copyright © 2017 Richard Leh. All rights reserved.
//

import UIKit
import SVProgressHUD

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var upcomingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.white
        
        let defDarkBlueColor = UIColor.init(hexString: Colors.defaultDarkBlue.rawValue)
        nav?.barTintColor = defDarkBlueColor
        
        let defGreenColor = UIColor.init(hexString: Colors.defaultGreen.rawValue)
        nav?.titleTextAttributes = [NSForegroundColorAttributeName:defGreenColor]
        
        self.searchTextField.textColor = defGreenColor
        self.upcomingButton.setTitleColor(defGreenColor, for: .normal)
        self.view.backgroundColor = defDarkBlueColor
        
        self.searchTextField.attributedPlaceholder = NSAttributedString(string:"What movie are you looking for?", attributes: [NSForegroundColorAttributeName: UIColor.init(white: 0.9, alpha: 1)])

        
        SVProgressHUD.setDefaultStyle(.dark)
        //SVProgressHUD.setBackgroundColor(UIColor(hexString: Colors.defaultDarkBlue.rawValue))
        //SVProgressHUD.setForegroundColor(UIColor(hexString: Colors.defaultGreen.rawValue))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showUpcomingMovies(_ sender: Any) {
        self.performSegue(withIdentifier: Segues.resultMovieSegue.rawValue, sender: nil)
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segues.resultMovieSegue.rawValue  {
            if let viewController = segue.destination as? ListMovieViewController {
                if let query = sender as? String{
                    viewController.query = query
                }
            }
        }
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.performSegue(withIdentifier: Segues.resultMovieSegue.rawValue, sender: textField.text)
        return true
    }
    
}
