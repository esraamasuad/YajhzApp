//
//  HomeRepoImpl.swift
//  RecipeSearch
//
//  Created by Esraa on 16/11/2023.
//  Copyright © 2023 EsraaOrganization. All rights reserved.
//

import Promises

class HomeRepoImpl: HomeRepo {
    private var network: NetworkService
    
    init(network: NetworkService = NetworkServiceImpl()) {
        self.network = network
    }
    
    func homeCategories() -> Promise<BaseResponse<CategoryModel>> {
        return self.network.callModel(BaseResponse<CategoryModel>.self, endpoint: HomeCategoriesEndPoint())
    }
    
    func popularSeller(request: FilterRequest) -> Promise<BaseResponse<SellerModel>> {
        return self.network.callModel(BaseResponse<SellerModel>.self, endpoint: PopularSellersEndPoint(request: request))
    }
    
    func trendingSeller() -> Promise<BaseResponse<SellerModel>> {
        return self.network.callModel(BaseResponse<SellerModel>.self, endpoint: TrendingSellerEndPoint())
    }
}
