//
//  CategoryViewModel.swift
//  wac-machinetest
//
//  Created by bibeesh on 31.08.2023.
//

import Foundation


class CategoryCellViewModel{
    var id:Int!
    var name:String!
    var image:String!
    
    init(id: Int!, name: String!, image: String!) {
        self.id = id
        self.name = name
        self.image = image
    }
}
