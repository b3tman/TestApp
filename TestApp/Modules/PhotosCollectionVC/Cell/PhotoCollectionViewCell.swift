//
//  PhotoCollectionViewCell.swift
//  TestApp
//
//  Created by Максим Бриштен on 17.01.2018.
//  Copyright © 2018 Максим Бриштен. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

