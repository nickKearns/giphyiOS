//
//  ViewController.swift
//  GiohySearchIOS
//
//  Created by Nicholas Kearns on 4/10/20.
//  Copyright © 2020 Nicholas Kearns. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var network = GifNetwork()
    
    var gifs = [Gif]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        //Search bar
        searchBar.searchTextField.delegate = self
        searchBar.searchTextField.placeholder = "Whats your favorite gif?"
        searchBar.returnKeyType = .search
        
    }
    
    func searchGifs(for searchTerm: String) {
        network.fetchGifs(searchTerm: searchTerm) { gifArray in
            if gifArray != nil {
//                print(gifArray!.gifs.count)
                self.gifs = gifArray!.gifs
                self.tableView.reloadData()
            }
        }
        
    }


}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.gifs.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gifCell") as! GifCell
        cell.gif = self.gifs[indexPath.row]
        return cell
    }
}

extension ViewController: UISearchTextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text != nil {
            searchGifs(for: textField.text!)
        }
        return true
    }
}

