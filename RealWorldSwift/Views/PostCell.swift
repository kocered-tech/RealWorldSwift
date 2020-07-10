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

protocol PostCellDelegate: class {
    func handleFavoriteTapped(_ cell: PostCell)
}

class PostCell: UITableViewCell{
    
    var isFavorite : Bool?
    weak var delegate : PostCellDelegate?
    
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
            
            
        }
        
    }
    
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
        addSubview(userImage)
        addSubview(authorName)
        addSubview(descriptionLabel)
        addSubview(seperator)
        addSubview(favoriteImage)
        addSubview(favoriteLabel)
        
        if isFavorite == false  {
            favoriteImage.tintColor = .lightGray
        } else {
            favoriteImage.tintColor = .systemRed
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(favoriteTapped))
        favoriteImage.isUserInteractionEnabled = true
        favoriteImage.addGestureRecognizer(tap)

        
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
            make.top.equalTo(favoriteLabel.snp.bottom).offset(10)
            make.left.right.bottom.equalTo(self).offset(5)
            make.height.equalTo(0.75)
        }
        
        

    }
    
    //MARK: - Helpers
    
    @objc func favoriteTapped() {
        //
        print("Tap tap")
        if isFavorite! {
            favoriteImage.tintColor = .lightGray
        } else {
            favoriteImage.tintColor = .systemRed
        }
        
        delegate?.handleFavoriteTapped(self)
        
        
        isFavorite!.toggle()
    }

}
