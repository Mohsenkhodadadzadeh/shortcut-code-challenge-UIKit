//
//  FavoriteTVHandler.swift
//  shortcut code challenge UIKit
//
//  Created by Mohsen on 11/23/21.
//


import UIKit
import CoreData

extension FavoriteVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BrowseTVC", for: indexPath) as! BrowseTVC
        cell.fillData(data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let itemId = data[indexPath.row].num
            DataStorage().removeComic(for: itemId)
            data.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedComic = data[indexPath.row]
        performSegue(withIdentifier: "DetailSegue", sender: self)
    }
}
