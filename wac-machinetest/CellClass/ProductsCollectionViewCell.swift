//
//  ProductsCollectionViewCell.swift
//  wac-machinetest
//
//  Created by bibeesh on 31.08.2023.
//

import UIKit

class ProductsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var offerLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var offerPriceLabel: UILabel!
    @IBOutlet weak var deliverTruckImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var subDescriptionLabel: UILabel!
    @IBOutlet weak var AddButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        AddButton.layer.cornerRadius = 2
    }
    
    func setCellData(_ product:ProductCellViewModel){
        
        offerLabel.text = " \(product.offer)%  "
        offerLabel.isHidden = product.offer > 0 ? false : true
        productImageView.loadImageUrl(urlString: product.image)
        productPriceLabel.text = product.actualPrice
        offerPriceLabel.text = product.offerPrice
        productPriceLabel.isHidden = product.actualPrice == product.offerPrice ? true : false
        descriptionLabel.text = product.name
        deliverTruckImageView.isHidden = product.isExpress
        
        
    }

}
