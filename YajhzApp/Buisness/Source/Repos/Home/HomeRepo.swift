//
//  HomeRepo.swift
//  RecipeSearch
//
//  Created by Esraa on 16/11/2023.
//  Copyright © 2023 EsraaOrganization. All rights reserved.
//

import Promises

protocol HomeRepo {
    func homeCategories() -> Promise<BaseResponse<CategoryModel>>
    func popularSeller(request: FilterRequest) -> Promise<BaseResponse<SellerModel>>
    func trendingSeller() -> Promise<BaseResponse<SellerModel>>
}
