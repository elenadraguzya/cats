//
//  ViewController.swift
//  cats
//
//  Created by Olena on 06.05.2020.
//  Copyright © 2020 Elena Draguzya. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        data()
    }
    
    var breeds = [Breeds]()
    var name: String?
    var id: String?
    var descriptions: String?
    var origin: String?
    var lifeSpan: String?
    
    func data() {
        let key = ["x-api-key": "1bc70c1d-b3f7-42ac-bf25-ec47ed0a56c1"]
    
    let request = NSMutableURLRequest(url: NSURL(string: "https://api.thecatapi.com/v1/breeds")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = key
    
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                self.breeds = try decoder.decode([Breeds].self, from: data)
                DispatchQueue.main.async {
                    self.activityIndicatorView.isHidden = true
                    self.activityIndicatorView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
                    self.tableView.reloadData()
                }
            } catch let error {
                print("JSON error", error)
            }
        }.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! Cell
        let breed = breeds[indexPath.row]
        cell.label.text = breed.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let breed = breeds[indexPath.row]
        name = breed.name
        id = breed.id
        descriptions = breed.description
        origin = breed.origin
        lifeSpan = breed.life_span
        
        performSegue(withIdentifier: "show", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let ViewController = segue.destination as! ViewController
        ViewController.name = name
        ViewController.id = id
        ViewController.descriptions = descriptions
        ViewController.origin = origin
        ViewController.lifeSpan = lifeSpan
    }
}

