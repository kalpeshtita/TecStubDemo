//
//  DogListPresenter.swift
//  TecStubDemo
//
//  Created by Apple on 03/01/21.
//  Copyright © 2021 Tita. All rights reserved.
//

import Foundation
import UIKit

class DogListPresenter:DogListViewToPresenterProtocol,DogListInteractorToPresenterProtocol  {
    
    var view: DogListPresenterToViewProtocol?
    var interactor: DogListPresenterToInteractorProtocol?
    var router: DogListPresenterToRouterProtocol?
    
    // MARK: override method from DogListInteractorToPresenterProtocol
    func didRecieved(dogs: [Dog]) {
        view?.didRecieved(dogs: dogs)
    }
    
    func getDogList() {
        interactor!.getDogList()
    }

}
