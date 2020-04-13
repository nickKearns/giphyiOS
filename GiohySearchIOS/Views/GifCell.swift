//
//  GifCell.swift
//  GiohySearchIOS
//
//  Created by Nicholas Kearns on 4/12/20.
//  Copyright © 2020 Nicholas Kearns. All rights reserved.
//

import UIKit
class GifCell: UITableViewCell {
    
    var gif: Gif?
    
    var gifView: UIImageView = {
        let v = UIImageView()
        v.contentMode = .scaleAspectFit
        return v
    }()
    override func layoutSubviews() {
        
        super.layoutSubviews()

        if gif != nil {

            let gifURL = gif!.getGifURL()
            gifView.image = UIImage.gif(url: gifURL)
            gifView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
            addSubview(gifView)
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
