//
//  TrendingCollectionViewCell.swift
//  RecipeSearch
//
//  Created by Esraa on 16/11/2023.
//  Copyright © 2023 EsraaOrganization. All rights reserved.
//

import UIKit

class TrendingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var avater: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ model: SellerDetailsModel?) {
        avater.loadWebImageWithUrl(imageUrl: model?.image ?? "")
    }
}
