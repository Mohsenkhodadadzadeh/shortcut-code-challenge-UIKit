//
//  ComicModel.swift
//  shortcut code challenge UIKit
//
//  Created by Mohsen on 11/23/21.
//

import UIKit

struct ComicModel: Codable {
    
    var num: Int
    
    var description: String
    
    private var publishedDay: String
    
    var imageAddress: String
    
    var link: String
    
    private var publishedYear: String
    
    var news: String
    
    var safeTitle: String
    
    var title: String
    
    var transcript: String
    
    private var publishedMonth: String
    
    private var _publishdate: Date?
    
    var image: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case num
        case description = "alt"
        case publishedDay = "day"
        case imageAddress = "img"
        case link
        case publishedYear = "year"
        case news
        case safeTitle = "safe_title"
        case title
        case transcript
        case publishedMonth = "month"
    }
    
    
    var publishedDate: Date? {
        if _publishdate != nil {
            return _publishdate
        }
        return Date.convertToDate(publishedYear, publishedMonth, publishedDay)
    }
    
    mutating func setPublishDate(_ date: Date) {
        _publishdate = date
    }
    
    init(num: Int, description: String, publishedDate: Date, link: String, image: UIImage?, news: String, safeTitle: String, title: String, transcript: String) {
        self.num = num
        self.description = description
        let calenderDate = Calendar.current.dateComponents([.day, .year, .month], from: publishedDate)
        self.publishedDay = "\(calenderDate.day ?? 0)"
        self.publishedMonth = "\(calenderDate.month ?? 0)"
        self.publishedYear = "\(calenderDate.year ?? 0)"
        self.link = link
        self.image = image
        self.news = news
        self.safeTitle = safeTitle
        self.title = title
        self.transcript = transcript
        self.imageAddress = ""
    }
    
}
