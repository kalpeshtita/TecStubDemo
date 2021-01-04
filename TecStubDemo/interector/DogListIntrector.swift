//
//  DogListIntrector.swift
//  TecStubDemo
//
//  Created by Apple on 03/01/21.
//  Copyright © 2021 Tita. All rights reserved.
//

import Foundation
//
//  DogListIntrector.swift
//  WeatherApp
//
//  Created by Kalpesh on 18/01/20.
//  Copyright © 2020 Kalpesh. All rights reserved.
//

import UIKit


class DogListIntrector: DogListPresenterToInteractorProtocol {
    
    
    var presenter: DogListInteractorToPresenterProtocol?
    

    func getDogList() {
        DogLISTAPIRequest.init(limit: 50).dispatch(onSuccess: { (dogs) in
            
            if self.presenter  != nil {
                self.presenter?.didRecieved(dogs: dogs)
            }
            
        }) { (errorResponse, error) in
            
        }

    }
    

    func didFailWithErrorToRecieveLocation(error: NSError) {
        
    }
    

    
}
