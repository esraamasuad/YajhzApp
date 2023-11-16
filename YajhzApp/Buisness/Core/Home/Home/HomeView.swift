//
//  HomeView.swift
//  RecipeSearch
//
//  Created by Esraa on 15/11/2023.
//  Copyright © 2023 EsraaOrganization. All rights reserved.
//

import UIKit

class HomeView: BaseView<HomeVM, BaseItem> {
    
    let categoryCellIdintifier = String(describing: CategoryCollectionViewCell.self)
    let popularCellIdintifier = String(describing: PopularCollectionViewCell.self)
    let trendingCellIdintifier = String(describing: TrendingCollectionViewCell.self)
    //MARK: -  OUTLET
    
    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var categryCollectionView: UICollectionView!{
        didSet{
            self.categryCollectionView.registerCell(idintifier: categoryCellIdintifier)
        }
    }
    @IBOutlet weak var popularCollectionView: UICollectionView!{
        didSet{
            self.popularCollectionView.registerCell(idintifier: popularCellIdintifier)
        }
    }
    @IBOutlet weak var trendingCollectionView: UICollectionView!{
        didSet{
            self.trendingCollectionView.registerCell(idintifier: trendingCellIdintifier)
        }
    }
    
    //MARK: -  DATA
        
    //MARK: - LifeCycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setTransparentNavagtionBar("Home", false)
        viewModel = HomeVM(routingManeger: RouterManagerImpl(self))
        /// binding
        viewModel.userName.bind(to: nameLbl)
        viewModel.userAddress.bind(to: addressLbl)
        viewModel.categoriesList.bind { (list) in
            self.refreshControl.endRefreshing()
            self.categryCollectionView.reloadData()
        }
        viewModel.popularSellersList.bind { (list) in
            self.refreshControl.endRefreshing()
            self.popularCollectionView.reloadData()
        }
        viewModel.trendingSellersList.bind { (list) in
            self.refreshControl.endRefreshing()
            self.trendingCollectionView.reloadData()
        }
        /// add pull to refresh
        initRefreshController()
        
        viewModel.setData()
        viewModel.homeEndPoint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func initRefreshController() {
        if #available(iOS 10.0, *) {
            scrollView.refreshControl = refreshControl
        } else {
            scrollView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(pullToRefresh(_:)), for: .valueChanged)
    }
    
    @objc private func pullToRefresh(_ sender: Any) {
        viewModel.pullToRefresh.value = true
        viewModel.reloadData()
    }
    
    //MARK: - Setup -
    
    func setUp() {
        [categryCollectionView, popularCollectionView, trendingCollectionView].forEach { collectionView in
            collectionView?.dataSource = self
            collectionView?.delegate = self
        }
        
        let cartIcon = UIBarButtonItem(image: UIImage(named: "cart_icon")!,
                                       style: .plain,
                                       target: self,
                                       action: #selector(cartPressed))
        let settingIcon = UIBarButtonItem(image: UIImage(named: "setting_icon")!,
                                          style: .plain,
                                          target: self,
                                          action: #selector(settingPressed))
        
        navigationItem.rightBarButtonItems = [settingIcon, cartIcon]
    }
    
    @objc func cartPressed() {
        
    }
    
    @objc func settingPressed() {
        viewModel.routeToSettings()
    }
    
}

// MARK: - Colection Delegate -

extension HomeView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case categryCollectionView:
            return viewModel.categoriesList.value.count
        case popularCollectionView:
            return viewModel.popularSellersList.value.count
        case trendingCollectionView:
            return viewModel.trendingSellersList.value.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case categryCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellIdintifier, for: indexPath) as! CategoryCollectionViewCell
            let category = viewModel.categoriesList.value[indexPath.row]
            cell.configure(category)
            return cell
            
        case popularCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: popularCellIdintifier, for: indexPath) as! PopularCollectionViewCell
            let seller = viewModel.popularSellersList.value[indexPath.row]
            cell.configure(seller)
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: trendingCellIdintifier, for: indexPath) as! TrendingCollectionViewCell
            let seller = viewModel.trendingSellersList.value[indexPath.row]
            cell.configure(seller)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let h = collectionView.bounds.height
        return CGSize(width: h+30, height: h)
    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//
//    }
}
