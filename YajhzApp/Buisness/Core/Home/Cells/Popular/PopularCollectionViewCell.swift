//
//  PopularCollectionViewCell.swift
//  RecipeSearch
//
//  Created by Esraa on 16/11/2023.
//  Copyright © 2023 EsraaOrganization. All rights reserved.
//

import UIKit
import Cosmos

class PopularCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var avater: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var ratingCount: UILabel!
    @IBOutlet weak var favoriteBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ model: SellerDetailsModel?) {
        avater.loadWebImageWithUrl(imageUrl: model?.image ?? "")
        titleLbl.text = model?.name
        distanceLbl.text = model?.distance
        ratingView.rating = Double(model?.rate ?? "") ?? 0
        ratingCount.text = ""//model?.rate
        
        let favIcon =  UIImage(named: (model?.isFavorite ?? false) ? "follow_icon" : "unfollow_icon")!
        favoriteBtn.setImage(favIcon, for: .normal)
    }
}
