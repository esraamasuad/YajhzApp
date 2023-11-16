//
//  HomeViewModel.swift
//  RecipeSearch
//
//  Created by Esraa on 15/11/2023.
//  Copyright © 2023 EsraaOrganization. All rights reserved.
//

import Bond
import Promises

class HomeVM: BaseVM {
    private var routingManeger: RouterManager
    private var homeRepo: HomeRepo =  HomeRepoImpl()
    private var userRepo: UserRepo = UserRepoImpl()

    var userName: Observable<String?> = Observable("")
    var userAddress: Observable<String?> = Observable("")
    
    var categoriesList: DynamicObjects<[CategoryDetailsModel]> = DynamicObjects([])
    var popularSellersList: DynamicObjects<[SellerDetailsModel]> = DynamicObjects([])
    var trendingSellersList: DynamicObjects<[SellerDetailsModel]> = DynamicObjects([])
    
    var pullToRefresh: DynamicObjects<Bool> = DynamicObjects(false)
    
    init(routingManeger: RouterManager) {
        self.routingManeger = routingManeger
    }
    
    func setData() {
        self.userName.value = self.userRepo.userModel?.name
        self.userAddress.value = self.userRepo.userModel?.addresses?.first?.address ?? "address ..."
    }
    
    func reloadData() {
        setData()
        homeEndPoint()
    }
    
    func routeToSettings(){
        routingManeger.push(vc: SettingsView(nibName: "SettingsView", bundle: nil))
    }
    
    func homeEndPoint() {
        showHudLoading()
        homeRepo.homeCategories().then { (result) -> Promise<BaseResponse<SellerModel>> in
            self.categoriesList.value = result.data?.data ?? []
            return self.homeRepo.popularSeller(request: FilterRequest(lat: "", lng: ""))
        }.then { (result) -> Promise<BaseResponse<SellerModel>> in
            self.popularSellersList.value = result.data?.data ?? []
            return self.homeRepo.trendingSeller()
        }.then { result in
            self.trendingSellersList.value = result.data?.data ?? []
        }.catch { (error) in
            self.showSystemError(error: error)
        }.always {
            self.hideLoading()
        }
    }
    
    func updateUserModel() {
        //        userRepo.getUserProfile().then {
        //            (response) in
        //            self.userName.value = response.data?.name ?? ""
        //            self.userAddress.value = response.data?.addresses?.first?.address ?? ""
        //        }.catch { (error) in
        //            self.showSystemError(error: error)
        //        }.always {
        //            self.hideLoading()
        //        }
    }
}

