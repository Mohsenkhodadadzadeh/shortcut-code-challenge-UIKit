//
//  FavoriteVC.swift
//  shortcut code challenge UIKit
//
//  Created by Mohsen on 11/23/21.
//


import UIKit
import CoreData

class FavoriteVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var data: [ComicModel] = []
    
    var selectedComic: ComicModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailSegue" {
            if let destNav = segue.destination as? DetailVC {
                destNav.comicData = selectedComic
            }
        }
    }

    fileprivate func loadData() {
        
        let dataStorage = DataStorage()
        data = dataStorage.retrieveComics()
        tableView.reloadData()
        
    }
    
}
