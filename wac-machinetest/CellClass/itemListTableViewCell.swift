//
//  itemListTableViewCell.swift
//  wac-machinetest
//
//  Created by bibeesh on 30.08.2023.
//

import UIKit

class itemListTableViewCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var itemDetailscollectionView: UICollectionView!
    
    var type:HomeDataType!
    var section:Int!
    
    lazy var itemsViewModel = {
        ItemsListViewModel()
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        itemDetailscollectionView.delegate = self
        itemDetailscollectionView.dataSource = self
        let categorNib = UINib(nibName:"CategoryCollectionViewCell" , bundle: nil)
        itemDetailscollectionView.register(categorNib, forCellWithReuseIdentifier: "categoryCell")
        let bannerNib = UINib(nibName:"BannersCollectionViewCell" , bundle: nil)
        itemDetailscollectionView.register(bannerNib, forCellWithReuseIdentifier: "BannerCell")
        let productNib = UINib(nibName:"ProductsCollectionViewCell" , bundle: nil)
        itemDetailscollectionView.register(productNib, forCellWithReuseIdentifier: "ProductCell")
        
        initViewModel()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
    func initViewModel(){
        itemsViewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.itemDetailscollectionView.reloadData()
            }
        }
    }
//
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let items = itemsViewModel.homeDataArray?.homeData else{ return 0}


            switch type {
            case .category(let values):
                print("Category values: \(values)")
                return values.count
            case .banners(let values):
                print("Banner values: \(values)")
                return values.count
            case .products(let values):
                print("Product values: \(values)")
                return values.count
            default:
                return 0
            }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch type{
        case .category(values: _):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
            let thisObject = itemsViewModel.getCellViewModel(at: indexPath.row)
            cell.setCellData(thisObject)
            return cell
        case .banners(values: _):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannersCollectionViewCell
            let thisObject = itemsViewModel.getBannerView(at: indexPath.row)
            cell.setCellData(thisObject)
            return cell
        case .products(values: _):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductsCollectionViewCell
            let thisObject = itemsViewModel.getProductView(at: indexPath.row)
            cell.setCellData(thisObject)
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryCollectionViewCell
            cell.categoryLabel.text = "item \(indexPath.row)"
            cell.categoryImageView.image = UIImage(systemName: "barcode.viewfinder")
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch type{
        case .category(values: _):
            return CGSize(width: 90, height: 120)
        case .banners(values: _):
            return CGSize(width: 400, height: 240)
        case .products(values: _):
            return CGSize(width: 240, height: 350)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    
   
}
