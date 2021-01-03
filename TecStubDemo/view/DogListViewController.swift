//
//  ViewController.swift
//  TecStubDemo
//
//  Created by Apple on 02/01/21.
//  Copyright © 2021 Tita. All rights reserved.
//

import UIKit

class DogListViewController: UIViewController {

    var presentor: DogListViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


extension DogListViewController: DogListPresenterToViewProtocol{
    func didRecieved(dogs: [Dog]) {
        
    }
    
}
