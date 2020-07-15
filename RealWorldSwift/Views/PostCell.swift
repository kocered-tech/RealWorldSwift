//
//  PostCell.swift
//  RealWorldSwift
//
//  Created by Erdem Koçer on 9.07.2020.
//  Copyright © 2020 Erdem Koçer. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage
import ChameleonFramework

protocol PostCellDelegate: class {
    func handleFavoriteTapped(_ cell: PostCell)
    func handleArticleTapped(_ cell: PostCell)
}

class PostCell: UITableViewCell{
    var localTagsList : [String]?
    var isFavorite : Bool?
    weak var delegate : PostCellDelegate?
    var labelList : [UILabel]?
    
    var post : Article? {
        didSet {
            let url = URL(string: (post?.author?.image)!)
            userImage.sd_setImage(with: url) { (image, error, cache, url) in
                if let error = error {
                    print("Error setting image \(error)")
                }
                
            }
            authorName.text = post?.author?.username
            descriptionLabel.text = post?.description
            if let my = post?.favoritesCount! {
                favoriteLabel.text = String(my)
            }
            localTagsList = post?.tagList
            
            
        }
        
    }
    let tagStack : UIStackView = {
        let stack = UIStackView()
        stack.spacing = 10
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .clear
        label.numberOfLines = 0
        return label
    }()
    
    let authorName : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .clear
        return label
    }()
    
    let userImage : UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 35/2
        image.layer.masksToBounds = true
        
       return image
    }()
    
    let seperator: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.1)
        return view
        
        
    }()
    
    let favoriteImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "suit.heart.fill")
    
        
        
        return image
    }()
    
    let favoriteLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .white
        
        return label
        
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
        
        if labelList?.count == nil {
        for tag in post!.tagList! {
            
            let label = UILabel()
            labelList = []
            label.textAlignment = .center
            label.text = tag
            label.layer.cornerRadius = 10
            label.layer.masksToBounds = true
            
            
            label.backgroundColor = RandomFlatColorWithShade(.dark)
            label.textColor = ContrastColorOf(
            label.backgroundColor!, returnFlat: true)
            label.adjustsFontSizeToFitWidth = true
            labelList!.append(label)

        }

        }
        if tagStack.arrangedSubviews.first == nil && labelList?.count != nil  {
        for label in labelList! {
            tagStack.addArrangedSubview(label)
            
        }
        }
        
        
        
        
        
        
        
        
        
        
        
        
        addSubview(userImage)
        addSubview(authorName)
        addSubview(descriptionLabel)
        addSubview(seperator)
        addSubview(favoriteImage)
        addSubview(favoriteLabel)
        addSubview(tagStack)
    
        
        if isFavorite == false  {
            favoriteImage.tintColor = .lightGray
        } else {
            favoriteImage.tintColor = .systemRed
        }
        
        let favoriteTap = UITapGestureRecognizer(target: self, action: #selector(favoriteTapped))
        favoriteImage.isUserInteractionEnabled = true
        favoriteImage.addGestureRecognizer(favoriteTap)
        
        let articleTap = UITapGestureRecognizer(target: self, action: #selector(articleTapped))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(articleTap)

        
        userImage.snp.makeConstraints { (make) in
            make.width.equalTo(35)
            make.height.equalTo(35)
            make.top.equalTo(self).offset(30)
            make.left.equalTo(self).offset(20)

        }
        
        authorName.snp.makeConstraints { (make) in
            make.left.equalTo(userImage.snp.right).offset(10)
            make.top.equalTo(self).offset(30)
            make.right.equalTo(self).offset(20)
            
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(authorName.snp.bottom).offset(20)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(20)
//            make.bottom.equalTo(self).offset(20)
        }
        
        favoriteLabel.snp.makeConstraints { (make) in
                make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.right.equalTo(favoriteImage.snp.left).offset(-5)
                
            }
        
            
        favoriteImage.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.right.equalTo(self).offset(-10)
        }
        
        seperator.snp.makeConstraints { (make) in
            if (tagStack.arrangedSubviews.first != nil) {
                make.top.equalTo(tagStack.snp.bottom).offset(7)
            } else {
                make.top.equalTo(favoriteLabel.snp.bottom).offset(7)
            }
            
            make.bottom.equalTo(self).inset(2)
            make.right.equalTo(self).inset(5)
            make.left.equalTo(self).offset(5)
            make.height.equalTo(0.50)
        }
        
        tagStack.snp.makeConstraints { (make) in
            make.bottom.equalTo(favoriteLabel.snp.bottom)
            make.left.equalTo(self).offset(15)
            make.right.equalTo(self).offset(-100)
        }
        
        
        
        

    }
    
    //MARK: - Helpers
    
    @objc func favoriteTapped() {
        
        if isFavorite! {
            favoriteImage.tintColor = .lightGray
        } else {
            favoriteImage.tintColor = .systemRed
        }
        
        delegate?.handleFavoriteTapped(self)
        
        
        isFavorite!.toggle()
    }
    
    @objc func articleTapped() {
        delegate?.handleArticleTapped(self)
        
        
    }

}
