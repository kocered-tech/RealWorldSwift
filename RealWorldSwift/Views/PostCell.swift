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

class PostCell: UITableViewCell{
    
    var post : Article? {
        didSet {
            let url = URL(string: (post?.author?.image)!)
            userImage.sd_setImage(with: url) { (image, error, cache, url) in
                if let error = error {
                    print("Error setting image")
                }
                
            }
            authorName.text = post?.author?.username
            descriptionLabel.text = post?.description
        }
        
    }
    
    let descriptionLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .clear
        
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
        image.contentMode = .scaleAspectFit
        
       return image
    }()
    
    let seperator: UIView = {
       let view = UIView()
        view.backgroundColor = .darkGray
        
        return view
        
        
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
//        let stack = UIStackView(arrangedSubviews: [userImage,postLabel])
//        addSubview(stack)
//        stack.axis = .horizontal
        
        userImage.snp.makeConstraints { (make) in
            make.width.equalTo(30)
            make.height.equalTo(30)
            make.top.equalTo(self).offset(30)
            make.left.equalTo(self).offset(20)
//            make.bottom.equalTo(descriptionLabel.snp.top).offset(10)
        }
        
        authorName.snp.makeConstraints { (make) in
            make.left.equalTo(userImage.snp.right).offset(10)
            make.top.equalTo(self).offset(30)
            make.right.equalTo(self).offset(20)
//            make.bottom.equalTo(descriptionLabel.snp.top).offset(10)
            
        }
        
        descriptionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(authorName.snp.bottom).offset(20)
            make.left.equalTo(self).offset(20)
            make.right.equalTo(self).offset(20)
//            make.bottom.equalTo(self).offset(20)
        }
        
        seperator.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.left.right.bottom.equalTo(self).offset(5)
            make.height.equalTo(0.75)
        }
    

    }

}
