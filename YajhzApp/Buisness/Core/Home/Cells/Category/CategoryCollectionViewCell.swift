//
//  CategoryCollectionViewCell.swift
//  RecipeSearch
//
//  Created by Esraa on 16/11/2023.
//  Copyright © 2023 EsraaOrganization. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var avater: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ model: CategoryDetailsModel?) {
        avater.loadWebImageWithUrl(imageUrl: model?.image ?? "")
        titleLbl.text = model?.name ?? ""
    }

}
