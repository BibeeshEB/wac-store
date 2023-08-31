//
//  CategoryCollectionViewCell.swift
//  wac-machinetest
//
//  Created by bibeesh on 30.08.2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var categoryItem:CategoryCellViewModel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        categoryImageView.layer.cornerRadius = categoryImageView.frame.height / 2
    }
    
    func setCellData(_ category:CategoryCellViewModel){
        
        categoryLabel.text = category.name
        categoryImageView.loadImageUrl(urlString: category.image)
        categoryImageView.backgroundColor = #colorLiteral(red: 0.9996628165, green: 0.9915212989, blue: 0.6723452806, alpha: 1)
        
        
    }

}
