//
//  ViewController.swift
//  TMDBApp
//
//  Created by Richard Leh on 17/12/2016.
//  Copyright © 2016 Richard Leh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView:UITableView?
    let tableCellIReusedentifier:String = "MovieCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestMovies()
        tableView?.reloadData()
    }
    
    private func requestMovies(){
        let requestParameters = [Constants.TMDBMovieKeys.APIKEY: Constants.TMDBMovieValues.APIKEY+"1",
                                 Constants.TMDBMovieKeys.Language: Constants.TMDBMovieValues.Language,
                                 Constants.TMDBMovieKeys.Page : 1] as [String:Any]
        
        //if let movieURL = movieListURLFromParameters(requestParameters) {
        let movieURL = movieListURLFromParameters(requestParameters)
        let task = URLSession.shared.dataTask(with: movieURL) { (data, response, error) in
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                self.showError("There is an error with your request: \(error)")
                return
            }
            
            guard let data = data else {
                print("There isn't any data from request!")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                self.showError("Your request returned a status code other than 2xx!")
                return
            }
            
            // parse the data
            let parsedResult: [String:AnyObject]!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
                print(parsedResult)
            } catch {
                print("Could not parse the data as JSON: '\(data)'")
                return
            }
        }
        
        task.resume()

    }

    private func movieListURLFromParameters(_ parameters: [String:Any]) -> URL {
        
        var components = URLComponents()
        components.scheme = Constants.TMDBMovie.APIScheme
        components.host = Constants.TMDBMovie.APIHost
        components.path = Constants.TMDBMovie.APIPath + Constants.TMDBMovie.APIMethod
        components.queryItems = [URLQueryItem]()
        
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            components.queryItems!.append(queryItem)
        }
        
        return components.url!
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
        return 2
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIReusedentifier, for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
