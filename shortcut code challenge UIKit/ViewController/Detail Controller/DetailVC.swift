//
//  DetailVC.swift
//  shortcut code challenge UIKit
//
//  Created by Mohsen on 11/23/21.
//

import UIKit
import CoreData

class DetailVC: UIViewController {
    
    @IBOutlet weak var comicImageView: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var comicDetailLabel: UILabel!
    @IBOutlet weak var comicTitleLabel: UILabel!
    @IBOutlet weak var bookmarkImage: UIImageView!
    
    
    var comicData: ComicModel!
    let dataStorage: DataStorage = DataStorage()
    
    fileprivate var isFavorite: Bool = false {
        didSet {
            if isFavorite {
                bookmarkImage.image = UIImage(systemName: "bookmark.fill")
            } else {
                bookmarkImage.image = UIImage(systemName: "bookmark")
            }
        }
    }
    
    fileprivate var isImageLoaded: Bool = false {
        didSet {
            if isImageLoaded {
                bookmarkImage.isHidden = false
            } else {
                bookmarkImage.isHidden = false
            }
        }
    }
    
    fileprivate var comicImage: UIImage? {
        didSet {
            if comicImage != nil {
                comicImageView.image = comicImage
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPage()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func bookMarkButtonPress(_ sender: Any) {
        if isImageLoaded {
            bookmark(newStatus: !isFavorite)
        }
    }
    
    @IBAction func shareButtonPress(_ sender: Any) {
        
        if let image = comicImage {
            let item = [image]
            let ac = UIActivityViewController(activityItems: item, applicationActivities: nil)
            if UIScreen.main.traitCollection.userInterfaceIdiom == .pad {
                ac.popoverPresentationController?.sourceView = self.view
                let w = UIScreen.main.bounds.width
                ac.popoverPresentationController?.sourceRect = CGRect(origin: CGPoint(x: (w / 2) , y: 50), size: CGSize(width: 300, height: 400))
            }
            present(ac, animated: true)
        }
        
    }
    
    private func setupPage() {
        
        
        loadFavorite()
        
        if comicData.image == nil {
            loadComicImage()
        }
        
        if let date = comicData.publishedDate?.convertToLongDate() {
            dateLabel.text = "Published on: \(date)"
        } else {
            dateLabel.isHidden = true
        }
        
        comicTitleLabel.text = comicData.safeTitle
        
        comicDetailLabel.text = comicData.description
        
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        comicImageView.addGestureRecognizer(imageTapGesture)
        
    }
    
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    
    fileprivate func loadComicImage() {
        if let url = URL(string: comicData.imageAddress) {
            Services.loadRemoteImage(url: url) { [weak self] image in
                self?.comicImage = image
                
                self?.isImageLoaded = true
            } failure: { err in
                print(err.errorDescription)
            }

            
        }
         
    }
    
    fileprivate func bookmark(newStatus: Bool) {
        
        
        if newStatus {
            
            dataStorage.saveComic(comicData, image: comicImage)
            isFavorite = true
            
        } else {
            
            dataStorage.removeComic(for: comicData.num)
            isFavorite = false
        }
    }
    
    private func loadFavorite() {
        if let image = dataStorage.retriveComicImage(for: comicData.num) {
            comicImage = image
            isFavorite = true
        }
    }
}
