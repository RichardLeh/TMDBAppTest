//
//  ViewController.swift
//  TMDBApp
//
//  Created by Richard Leh on 17/12/2016.
//  Copyright © 2016 Richard Leh. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

enum jsonResult:String {
    case results = "results"
    case totalPages = "total_pages"
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView:UITableView!
    let tableCellIdentifier:String = "MovieCell"
    let noResultsCellIdentifier:String = "NoResultCell"
    var movies = [Movie]()
    var currentPage = 1
    var totalPages = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getMovies()
    }
    
    fileprivate func getMovies(fromJson json:DictionaryData){
        print(json)
    }
    
    fileprivate func getMovies(){
        
        //UIApplication.shared.isNetworkActivityIndicatorVisible = true
        SVProgressHUD.show()
        
        Requests.sharedInstance().requestUpcomingMovies(fromPage: currentPage){ [weak self] (result, error) in
            
            guard result != nil, let resultDict = result as? DictionaryData else{
                self?.showError(error.debugDescription)
                return
            }
            self?.parse(resultDict)
            
            self?.tableView?.reloadData()
            
            SVProgressHUD.dismiss()
        }
        //completion("", nil)
    }
    
    fileprivate func parse(_ data:DictionaryData){
        guard let results = data[jsonResult.results.rawValue] as? [DictionaryData],
              let totalPages = data[jsonResult.totalPages.rawValue] as? Int else {
            return
        }
        self.totalPages = totalPages
        
        for result in results{
            let movie = Movie(withDict: result)
            self.movies.append(movie)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func showError(_ error: String){
        print(error)
        updatesOnMain{
            // TODO
            // FIX.ME("Atualizar a UI")
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if movies.count > 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath) as! MovieTableViewCell
            let movie = movies[indexPath.row]
            cell.fill(withMovie: movie)
            
            print("page ", currentPage, totalPages)
            if movies.count - 1 == indexPath.row + 1 && currentPage + 1 <= totalPages {
                print("page ", currentPage, totalPages)
                currentPage = currentPage + 1
                self.getMovies()
            }
            
            return cell
        }
        
        return tableView.dequeueReusableCell(withIdentifier: noResultsCellIdentifier, for: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
