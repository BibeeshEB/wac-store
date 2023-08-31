//
//  ItemsListModel.swift
//  wac-machinetest
//
//  Created by bibeesh on 31.08.2023.
//

import Foundation

class ItemsListViewModel:NSObject{
    
    private var itemListService:ItemListServiceProtocol
    
    var reloadTableView: (() -> Void)?
    var reloadCollectionView:(() -> Void)?
    var homeDataArray:HomeDataResponse?
    
    init(itemListService: ItemListServiceProtocol = ItemListService()) {
        self.itemListService = itemListService
    }
    
    var  categoryCellViewModel = [CategoryCellViewModel]()

    
    var bannerCellViewModel = [BannerCellViewModel]()

    var productCellViewModel = [ProductCellViewModel](){
        didSet{
            reloadTableView?()
        }
    }
    
    
    func getItems(){
        itemListService.getItemList(){
            success,model,error in
            if success,let items = model{
                self.homeDataArray = items
                for homeDataType in items.homeData {
                        switch homeDataType {
                        case .category(let values):
                            print("Category values: \(values)")
                            self.setCategoryItems(items: values)
                        case .banners(let values):
                            self.setBannerItems(items: values)
                            print("Banner values: \(values)")
                        case .products(let values):
                            print("Product values: \(values)")
                            self.setProductItems(items: values)
                        }
                    }
                
            }
            else{
                print(error as Any)
            }
        }
    }
    
    func setCategoryItems(items: [CategoryValue]) {
        var vms = [CategoryCellViewModel]()
        for item in items {
            vms.append(createCellModel(item: item))
        }
        categoryCellViewModel = vms
    }
    
    func createCellModel(item:CategoryValue) -> CategoryCellViewModel{
        let id = item.id
        let name = item.name
        let image = item.imageUrl
        
        return CategoryCellViewModel(id: id, name: name, image: image)
        
    }
    
    func getCellViewModel(at index: Int) -> CategoryCellViewModel {
        return categoryCellViewModel[index]
    }
    
    
    func setBannerItems(items:[BannerValue]){
        var vms = [BannerCellViewModel]()
        for item in items {
            vms.append(createBannerCell(item:item))
        }
        bannerCellViewModel = vms
    }
    
    func createBannerCell(item:BannerValue) -> BannerCellViewModel{
        let id = item.id
        let image = item.bannerUrl
        
        return BannerCellViewModel(id: id, image: image)
        
    }
    
    func getBannerView(at index: Int) -> BannerCellViewModel {
        return bannerCellViewModel[index]
    }
    
    
    func setProductItems(items:[ProductValue]){
        var vms = [ProductCellViewModel]()
        for item in items {
            vms.append(createProductCell(item:item))
        }
        productCellViewModel = vms
    }
    
    func createProductCell(item:ProductValue) -> ProductCellViewModel{
        let id = item.id
        let image = item.image
        let name = item.name
        let offer = item.offer
        let offerPrice = item.offerPrice
        let actualPrice = item.actualPrice
        let isExpress = item.isExpress
        
        return ProductCellViewModel(id: id, name: name, image: image, actualPrice: actualPrice, offerPrice: offerPrice, offer: offer, isExpress: isExpress)
        
    }
    
    func getProductView(at index: Int) -> ProductCellViewModel {
        return productCellViewModel[index]
    }
}
