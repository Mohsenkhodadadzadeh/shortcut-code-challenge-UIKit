//
//  SetupDetailVCUI.swift
//  shortcut code challenge UIKit
//
//  Created by Mohsen on 11/24/21.
//

import UIKit

extension DetailVC {
    
    func setUpView() {
        setUpComicImageView()
        setUpbookmarkImageView()
        setUpBookmarkButton()
        setUpDateLabel()
        setUpMainScrollView()
    }
    
    private func setUpComicImageView() {
        comicImageView = {
            let obj = UIImageView()
            obj.contentMode = .scaleAspectFit
            return obj
        }()
        
        self.view.addSubview(comicImageView)
        
        comicImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let widthConstraint = NSLayoutConstraint(item: comicImageView, attribute: .width, relatedBy: .equal, toItem: self.view, attribute: .width, multiplier: 0.966184, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: comicImageView, attribute: .trailing, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: comicImageView, attribute: .leading, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 0)
        
        let topConstraint = NSLayoutConstraint(item: comicImageView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0)
        
        let heightConstraint = NSLayoutConstraint(item: comicImageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 350)
        
        self.view.addConstraints([widthConstraint, trailingConstraint, leadingConstraint, topConstraint])
        
        comicImageView.addConstraint(heightConstraint)
        
        let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:)))
        comicImageView.isUserInteractionEnabled = true
        comicImageView.addGestureRecognizer(imageTapGesture)
    }
    
    private func setUpbookmarkImageView() {
        bookmarkImageView = {
           let obj = UIImageView()
            obj.image = UIImage(systemName: "bookmark")
            obj.contentMode = .scaleAspectFit
            obj.tintColor = UIColor.systemYellow
            return obj
        }()
        
        self.view.addSubview(bookmarkImageView)
        
        bookmarkImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let widthConstraint = NSLayoutConstraint(item: bookmarkImageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 33)
        
        let trailingConstraint = NSLayoutConstraint(item: bookmarkImageView, attribute: .trailing, relatedBy: .equal, toItem: comicImageView, attribute: .trailing, multiplier: 1, constant: -20)
        
        let bottomConstraint = NSLayoutConstraint(item: bookmarkImageView, attribute: .bottom, relatedBy: .equal, toItem: comicImageView, attribute: .bottom, multiplier: 1, constant: -20)
        
        let ratioConstraint = NSLayoutConstraint(item: bookmarkImageView, attribute: .width, relatedBy: .equal, toItem: bookmarkImageView, attribute: .height, multiplier: 1, constant: 0)
        
        self.view.addConstraints([trailingConstraint, bottomConstraint])
        
        bookmarkImageView.addConstraints([widthConstraint, ratioConstraint])
        
    }
    
    private func setUpBookmarkButton() {
        bookmarkButton = {
            let obj = UIButton()
            obj.setTitle("", for: .normal)
            return obj
        }()
        
        self.view.addSubview(bookmarkButton)
        
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        
        let centerXConstraint = NSLayoutConstraint(item: bookmarkButton, attribute: .centerX, relatedBy: .equal, toItem: bookmarkImageView, attribute: .centerX, multiplier: 1, constant: 0)
        
        let centerYConstraint = NSLayoutConstraint(item: bookmarkButton, attribute: .centerY, relatedBy: .equal, toItem: bookmarkImageView, attribute: .centerY, multiplier: 1, constant: 0)
        
        let widthConstraint = NSLayoutConstraint(item: bookmarkButton, attribute: .width, relatedBy: .equal, toItem: bookmarkImageView, attribute: .width, multiplier: 1.5, constant: 0)
        
        let heighConstraint = NSLayoutConstraint(item: bookmarkButton, attribute: .height, relatedBy: .equal, toItem: bookmarkImageView, attribute: .height, multiplier: 1.5, constant: 0)
        
        self.view.addConstraints([centerXConstraint, centerYConstraint, widthConstraint, heighConstraint])
        
        bookmarkButton.addTarget(self, action: #selector(bookMarkButtonPress(_:)), for: .touchUpInside)
    }
    
    private func setUpDateLabel() {
        dateLabel = {
           let obj = UILabel()
            obj.textColor = .white
            obj.font = UIFont.preferredFont(forTextStyle: .subheadline)
            obj.backgroundColor = .black
            return obj
        }()
        
        self.view.addSubview(dateLabel)
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = NSLayoutConstraint(item: dateLabel, attribute: .leading, relatedBy: .equal, toItem: comicImageView, attribute: .leading, multiplier: 1, constant: 20)
        
        let heightConstraint = NSLayoutConstraint(item: dateLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 26)
        
        let bottomConstraint = NSLayoutConstraint(item: bookmarkImageView, attribute: .bottom, relatedBy: .equal, toItem: dateLabel, attribute: .bottom, multiplier: 1, constant: 0)
        
        self.view.addConstraints([bottomConstraint, leadingConstraint])
        
        dateLabel.addConstraint(heightConstraint)
    }
    
    func setUpMainScrollView() {
        mainScrollView = {
            let obj = UIScrollView()
            obj.showsHorizontalScrollIndicator = false
            obj.showsVerticalScrollIndicator = true
            return obj
        }()
        
        self.view.addSubview(mainScrollView)
        
        mainScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let trailingConstraint = NSLayoutConstraint(item: mainScrollView, attribute: .trailing, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: 0)
        
        let leadingConstraint = NSLayoutConstraint(item: mainScrollView, attribute: .leading, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(item: mainScrollView, attribute: .bottom, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: 0)
        
        let topConstraint = NSLayoutConstraint(item: mainScrollView, attribute: .top, relatedBy: .equal, toItem: comicImageView, attribute: .bottom, multiplier: 1, constant: 0)
        
        self.view.addConstraints([trailingConstraint, leadingConstraint, bottomConstraint, topConstraint])
        
        setUpMainViewInScrollView()
        
    }
    
    private func setUpMainViewInScrollView() {
        mainViewInScrollView = {
           let obj = UIView()
            obj.backgroundColor = .clear
            return obj
        }()
        
        mainScrollView.addSubview(mainViewInScrollView)
        
        mainViewInScrollView.translatesAutoresizingMaskIntoConstraints = false
        
        let widthConstraint = NSLayoutConstraint(item: mainViewInScrollView, attribute: .width, relatedBy: .equal, toItem: comicImageView, attribute: .width, multiplier: 1, constant: 0)
        
        let trailingConstraint = NSLayoutConstraint(item: mainViewInScrollView, attribute: .trailing, relatedBy: .equal, toItem: mainScrollView, attribute: .trailing, multiplier: 1, constant: 0)
        
        let leadingConstraint = NSLayoutConstraint(item: mainViewInScrollView, attribute: .leading, relatedBy: .equal, toItem: mainScrollView, attribute: .leading, multiplier: 1, constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(item: mainViewInScrollView, attribute: .bottom, relatedBy: .equal, toItem: mainScrollView, attribute: .bottom, multiplier: 1, constant: 0)
        
        
        let topConstraint = NSLayoutConstraint(item: mainViewInScrollView, attribute: .top, relatedBy: .equal, toItem: mainScrollView, attribute: .top, multiplier: 1, constant: 0)
        self.view.addConstraints([widthConstraint, trailingConstraint, leadingConstraint, bottomConstraint, topConstraint])
        
        setUpComicTitleLabel()
        setUpComicDetailLabel()
        setUpshareButton()
        
    }
    
    private func setUpComicTitleLabel() {
        comicTitleLabel = {
            let obj = UILabel()
            obj.textColor = .lightGray
            obj.font = UIFont.preferredFont(forTextStyle: .largeTitle)
            return obj
        }()
        
        mainViewInScrollView.addSubview(comicTitleLabel)
        comicTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let trailingConstraint = NSLayoutConstraint(item: comicTitleLabel, attribute: .trailing, relatedBy: .equal, toItem: mainViewInScrollView, attribute: .trailing, multiplier: 1, constant: 20)
        
        let leadingConstraint = NSLayoutConstraint(item: comicTitleLabel, attribute: .leading, relatedBy: .equal, toItem: mainViewInScrollView, attribute: .leading, multiplier: 1, constant: 20)
        
        let topConstraint = NSLayoutConstraint(item: comicTitleLabel, attribute: .top, relatedBy: .equal, toItem: mainViewInScrollView, attribute: .top, multiplier: 1, constant: 20)
        
        let heightConstraint = NSLayoutConstraint(item: comicTitleLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 37)
        
        mainViewInScrollView.addConstraints([trailingConstraint, leadingConstraint, topConstraint])
        
        comicTitleLabel.addConstraint(heightConstraint)
    }
    
    private func setUpComicDetailLabel() {
        comicDetailLabel = {
           let obj = UILabel()
            obj.textColor = UIColor(red: 229, green: 229, blue: 225, alpha: 0.89)
            obj.font = UIFont.preferredFont(forTextStyle: .body)
            obj.numberOfLines = 0
            obj.lineBreakMode = .byWordWrapping
            return obj
        }()
        
        mainViewInScrollView.addSubview(comicDetailLabel)
        comicDetailLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let leadingConstraint = NSLayoutConstraint(item: comicDetailLabel, attribute: .leading, relatedBy: .equal, toItem: comicTitleLabel, attribute: .leading, multiplier: 1, constant: 0)
        
        let widthConstraint = NSLayoutConstraint(item: comicDetailLabel, attribute: .width, relatedBy: .equal, toItem: comicTitleLabel, attribute: .width, multiplier: 1, constant: 0)
        
        let topConstraint = NSLayoutConstraint(item: comicDetailLabel, attribute: .top, relatedBy: .equal, toItem: comicTitleLabel, attribute: .bottom, multiplier: 1, constant: 40)
        
        mainViewInScrollView.addConstraints([leadingConstraint, widthConstraint, topConstraint])
    }
    
    private func setUpshareButton() {
        shareButton = {
           let obj = CustomButton()
            obj.cornerRadius = 12
            obj.shadowColorLayer = UIColor.secondaryLabel
            obj.shadowRadius = 12
            obj.shadowOpacity = 0.1
            obj.shadowOffsetLayer = CGSize(width: 2, height: 5)
            obj.setTitle("share this comic".uppercased(), for: .normal)
            obj.tintColor = .lightGray
            obj.backgroundColor = .systemGray5
            return obj
        }()
        
        mainViewInScrollView.addSubview(shareButton)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        
        let trailingConstraint = NSLayoutConstraint(item: shareButton, attribute: .trailing, relatedBy: .equal, toItem: mainViewInScrollView, attribute: .trailing, multiplier: 1, constant: -30)
        
        let leadingConstraint = NSLayoutConstraint(item: shareButton, attribute: .leading, relatedBy: .equal, toItem: mainViewInScrollView, attribute: .leading, multiplier: 1, constant: 30)
        
        let bottomConstraint = NSLayoutConstraint(item: shareButton, attribute: .bottom, relatedBy: .equal, toItem: mainViewInScrollView, attribute: .bottom, multiplier: 1, constant: 20)
        
        let heightConstraint = NSLayoutConstraint(item: shareButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 50)
        
        let topConstraint = NSLayoutConstraint(item: shareButton, attribute: .top, relatedBy: .equal, toItem: comicDetailLabel, attribute: .bottom, multiplier: 1, constant: 20)
        
        mainViewInScrollView.addConstraints([trailingConstraint, leadingConstraint, bottomConstraint, topConstraint])
        
        shareButton.addConstraints([heightConstraint])
        
        shareButton.addTarget(self, action: #selector(shareButtonPress(_:)), for: .touchUpInside)
    }
    
    
}
