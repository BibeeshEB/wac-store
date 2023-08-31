//
//  ViewController.swift
//  wac-machinetest
//
//  Created by bibeesh on 30.08.2023.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
   
    
    @IBOutlet weak var textFieldContainerView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var itemListTableView: UITableView!
    
    lazy var itemListModel = {
        ItemsListViewModel()
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchTextField()
        setTableView()
        initViewModel()
       
    }
    
    func initViewModel(){
        itemListModel.getItems()
        itemListModel.reloadTableView = {[weak self] in
            DispatchQueue.main.async {
                self?.itemListTableView.reloadData()
            }
        }
    }


     func setSearchTextField() {
        textFieldContainerView.layer.borderWidth = 0.5
        textFieldContainerView.layer.cornerRadius = 5
        textFieldContainerView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        searchTextField.leftView = setImage(imageName: "magnifyingglass")
        searchTextField.leftViewMode = .unlessEditing
        
        searchTextField.rightView = setImage(imageName: "barcode.viewfinder")
        searchTextField.rightViewMode = .always
    }
    
    func setImage(imageName:String) -> UIView{
        let imageView = UIImageView()
        let image = UIImage(systemName:imageName)
        imageView.image = image
        return imageView as UIView
    }
    
    
    func setTableView() {
        itemListTableView.delegate = self
        itemListTableView.dataSource = self
        
        let itemCellNib = UINib(nibName: "itemListTableViewCell", bundle: nil)
        itemListTableView.register(itemCellNib, forCellReuseIdentifier: "itemListCell")
        
        itemListTableView.rowHeight = UITableView.automaticDimension
        itemListTableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
//        return UITableView.automaticDimension
        switch indexPath.row{
        case 0:
            return 160
        case 1:
            return 200
        case 2:
            return 400
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemListModel.homeDataArray?.homeData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let thisCell = tableView.dequeueReusableCell(withIdentifier: "itemListCell", for: indexPath) as! itemListTableViewCell
        let items = itemListModel.homeDataArray?.homeData
        let itemType = items?[indexPath.row]
        thisCell.type = itemType
        thisCell.itemsViewModel = itemListModel
        return thisCell
        
    }
}

