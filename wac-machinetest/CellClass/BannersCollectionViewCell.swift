//
//  BannersCollectionViewCell.swift
//  wac-machinetest
//
//  Created by bibeesh on 31.08.2023.
//

import UIKit

class BannersCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!
    
    var bannerItem:BannerCellViewModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bannerImageView.layer.cornerRadius = 5
    }
    
    func setCellData(_ banner:BannerCellViewModel){
        
        bannerImageView.loadImageUrl(urlString: banner.image)
        
        
    }

}
