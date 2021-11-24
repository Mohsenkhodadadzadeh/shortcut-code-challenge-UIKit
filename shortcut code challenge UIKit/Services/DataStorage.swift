//
//  DataStorage.swift
//  shortcut code challenge UIKit
//
//  Created by Mohsen on 11/23/21.
//

import Foundation
import CoreData
import UIKit

public final class DataStorage {
    
    fileprivate var managedContext : NSManagedObjectContext!
    
    init () {
        self.managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func saveComic(_ ComicItem: ComicModel, image: UIImage?) {
        let fetch = prepareFetchRequestForComicEntity(query: "num == \(ComicItem.num)")
        let count = try! managedContext.count(for: fetch)
        
        if count > 0 {
            return
        }//: row has been saved before
        
        let entity = NSEntityDescription.entity(forEntityName: "ComicEntity", in: managedContext)!
        let comicEntity = ComicEntity(entity: entity, insertInto: managedContext)
        
        comicEntity.num = Int32(ComicItem.num)
        comicEntity.title = ComicItem.title
        comicEntity.comicDescription = ComicItem.description
        comicEntity.link = ComicItem.link
        comicEntity.news = ComicItem.news
        comicEntity.publishedDate = ComicItem.publishedDate
        comicEntity.safeTitle = ComicItem.safeTitle
        comicEntity.transcript = ComicItem.transcript
        let photoData = image?.pngData()
        comicEntity.imageData = photoData
        try? managedContext.save()
    }
    
    func removeComic(for id: Int) {
        let fetch = prepareFetchRequestForComicEntity(query: "num == \(id)")
        
        if let object = (try? managedContext.fetch(fetch))?.first {
            managedContext.delete(object)
        }
        try? managedContext.save()
    }
    
    func retrieveComics() -> [ComicModel] {
        
        let fetch = prepareFetchRequestForComicEntity(query: "num > -1")
        var retObj: [ComicModel] = []
        if let fetchData = try? managedContext.fetch(fetch) {
            for item in fetchData {
                var image: UIImage?
                if let imageData = item.imageData {
                    image = UIImage(data: imageData)
                }
                let dbData: ComicModel = ComicModel(num: Int(item.num), description: item.comicDescription ?? "" , publishedDate: item.publishedDate ?? Date(), link: item.link ?? "", image: image, news: item.news ?? "", safeTitle: item.safeTitle ?? "", title: item.title ?? "", transcript: item.transcript ?? "")
                retObj.append(dbData)
            }
            return retObj
        }
        return []
        
    }
    
    func retrieveComicImage(for id: Int) -> UIImage? {
        
        let fetch = prepareFetchRequestForComicEntity(query: "num == \(id)")
        if let object = (try? managedContext.fetch(fetch))?.first {
                if let imageData = object.imageData {
                    return UIImage(data: imageData)
                }
           
        }
        return nil
    }
    
    
    private func prepareFetchRequestForComicEntity(query: String) -> NSFetchRequest<ComicEntity> {
        let fetch = NSFetchRequest<ComicEntity>(entityName: "ComicEntity")
        fetch.predicate = NSPredicate(format: query)
        return fetch
    }
    
}
