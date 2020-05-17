//
//  ViewController.swift
//  cats
//
//  Created by Olena on 12.05.2020.
//  Copyright © 2020 Elena Draguzya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var lifeSpanLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var name: String?
    var id: String?
    var descriptions: String?
    var origin: String?
    var lifeSpan: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        title = name
        breedImage()
        descriptionLabel.text = descriptions
        originLabel.text = origin
        lifeSpanLabel.text = "\(lifeSpan!) years"
    }
    
    func breedImage() {
        let key = ["x-api-key": "1bc70c1d-b3f7-42ac-bf25-ec47ed0a56c1"]
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.thecatapi.com/v1/images/search?breed_id=\(id!)")! as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = key
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let imageURL = try decoder.decode([Image].self, from: data)
                guard let url = URL(string: imageURL[0].url!) else {return}
                DispatchQueue.global(qos: .userInteractive).async {
                    let img = try? Data(contentsOf: url)
                    DispatchQueue.main.async{
                        self.image.isHidden = false
                        self.activityIndicator.stopAnimating()
                        self.image.image = UIImage(data: img!)}
                }
            } catch let error {
                print("JSON error", error)
            }
        }.resume()
    }
    
}
