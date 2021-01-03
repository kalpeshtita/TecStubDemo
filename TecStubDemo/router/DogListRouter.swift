//
//  DogListRouter.swift
//  TecStubDemo
//
//  Created by Apple on 03/01/21.
//  Copyright © 2021 Tita. All rights reserved.
//

import UIKit

class DogListRouter : DogListPresenterToRouterProtocol {
    

    static func createDogListView() -> DogListViewController {
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "DogListViewController") as! DogListViewController
        
        let presenter: DogListViewToPresenterProtocol & DogListInteractorToPresenterProtocol = DogListPresenter()
        let interactor: DogListPresenterToInteractorProtocol = DogListIntrector()
        let router: DogListPresenterToRouterProtocol = DogListRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }



}
