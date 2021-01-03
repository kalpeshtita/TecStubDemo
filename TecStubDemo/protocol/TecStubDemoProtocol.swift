//
//  TecStubDemoProtocol.swift
//  TecStubDemo
//
//  Created by Apple on 03/01/21.
//  Copyright © 2021 Tita. All rights reserved.
//

import Foundation

protocol DogListViewToPresenterProtocol: class{
    
    var view: DogListPresenterToViewProtocol? {get set}
    var interactor: DogListPresenterToInteractorProtocol? {get set}
    var router: DogListPresenterToRouterProtocol? {get set}
    func getDogList()

}

protocol DogListPresenterToViewProtocol: class{
    
    func didRecieved(dogs: [Dog])
}

protocol DogListPresenterToRouterProtocol: class {
    
}

protocol DogListPresenterToInteractorProtocol: class {
    var presenter:DogListInteractorToPresenterProtocol? {get set}
    func getDogList()
}

protocol DogListInteractorToPresenterProtocol: class {
    func didRecieved(dogs: [Dog])
    
}
