//
//  ProductCellViewModel.swift
//  wac-machinetest
//
//  Created by bibeesh on 31.08.2023.
//

import Foundation


class ProductCellViewModel{
    var id: Int
    var name: String
    var image: String
    var actualPrice: String
    var offerPrice: String
    var offer: Int
    var isExpress: Bool
    
    init(id: Int!, name:String!, image:String!, actualPrice:String!,offerPrice:String,offer:Int,isExpress:Bool) {
        self.id = id
        self.name = name
        self.image = image
        self.actualPrice = actualPrice
        self.offerPrice = offerPrice
        self.offer = offer
        self.isExpress = isExpress
    }
}
