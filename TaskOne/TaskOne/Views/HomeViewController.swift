//
//  ViewController.swift
//  TaskOne
//
//  Created by Sumanth Maddela on 08/06/25.
//

import UIKit

class HomeViewController: UIViewController {

    
    let urlString = Constants.Urls.apiUrl
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = URL(string: self.urlString)
        NetworkManager.shared.networkCall(request: request) { (result: Result<[Product], Error>) in
            switch result {
            case .success(let products):
                print(products)
            case .failure(let error):
                print(error)
            }
        }
    }


}

