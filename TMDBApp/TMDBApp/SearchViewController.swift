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
    @IBOutlet weak var languageSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateUI()
        self.setLanguages()
        
        SVProgressHUD.setDefaultStyle(.dark)
        //SVProgressHUD.setBackgroundColor(UIColor(hexString: Colors.defaultDarkBlue.rawValue))
        //SVProgressHUD.setForegroundColor(UIColor(hexString: Colors.defaultGreen.rawValue))
    }
    
    fileprivate func updateUI(){
        self.title = "TMDB"
        
        let nav = self.navigationController?.navigationBar
        nav?.tintColor = UIColor.white
        
        let defDarkBlueColor = UIColor.init(hexString: Colors.defaultDarkBlue.rawValue)
        nav?.barTintColor = defDarkBlueColor
        
        let defGreenColor = UIColor.init(hexString: Colors.defaultGreen.rawValue)
        nav?.titleTextAttributes = [NSForegroundColorAttributeName:defGreenColor]
        
        self.searchTextField.textColor = defGreenColor
        self.upcomingButton.setTitleColor(defGreenColor, for: .normal)
        self.view.backgroundColor = defDarkBlueColor
        
        if let strPlaceHolder = self.searchTextField.placeholder {
            self.searchTextField.attributedPlaceholder = NSAttributedString(string: strPlaceHolder, attributes: [NSForegroundColorAttributeName: UIColor.init(white: 0.9, alpha: 1)])
        }
    }
    
    fileprivate func setLanguages(){
        self.languageSegmentedControl.removeAllSegments()
        for lang in Language.appResult{
            self.languageSegmentedControl.insertSegment(withTitle: lang, at: self.languageSegmentedControl.numberOfSegments, animated: true)
        }
        self.languageSegmentedControl.selectedSegmentIndex = Language.getDefaultIndex()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func showUpcomingMovies(_ sender: Any) {
        searchTextField.resignFirstResponder()
        
        self.performSegue(withIdentifier: Segues.resultMovieSegue.rawValue, sender: nil)
    }

    @IBAction func valueChanged(_ sender: UISegmentedControl) {
        
        let lang = Language.appResult[sender.selectedSegmentIndex]
        Language.setDefaultLanguage(lang)
        
    }
    // MARK: - Navigation
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
        searchTextField.resignFirstResponder()
        
        self.performSegue(withIdentifier: Segues.resultMovieSegue.rawValue, sender: textField.text)
        return true
    }
    
}
