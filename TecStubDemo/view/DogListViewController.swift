//
//  ViewController.swift
//  TecStubDemo
//
//  Created by Apple on 02/01/21.
//  Copyright © 2021 Tita. All rights reserved.
//

import UIKit
import AlamofireImage

class DogListViewController: UIViewController {

    var presentor: DogListViewToPresenterProtocol?
    var dogs : [Dog]?
    @IBOutlet weak var tblDogs: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presentor?.getDogList()
        tblDogs.rowHeight = UITableView.automaticDimension
        tblDogs.estimatedRowHeight = 60

    }


}


extension DogListViewController: DogListPresenterToViewProtocol{
    func didRecieved(dogs: [Dog]) {
     
        self.dogs = dogs
        self.tblDogs.reloadData()
    }
    
}

extension DogListViewController : UITableViewDelegate,UITableViewDataSource{
    
        func numberOfSections(in tableView: UITableView) -> Int
        {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
            return dogs?.count ?? 0
        }
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {
            let strIdentifier = "DogListCell"
            var cell: DogListCell! = tableView.dequeueReusableCell(withIdentifier: strIdentifier) as? DogListCell
            
            if cell == nil
            {
                tableView.register(UINib(nibName: strIdentifier, bundle: nil), forCellReuseIdentifier: strIdentifier)
                cell = tableView.dequeueReusableCell(withIdentifier: strIdentifier) as? DogListCell
            }
            
            cell.name.text = self.dogs![indexPath.row].name
            cell.lifeSpan.text = self.dogs![indexPath.row].lifeSpan
            cell.imageView?.setImageWithUrl(strUrl: self.dogs![indexPath.row].image ?? "", placeholderImage: nil,tableView: tableView)
            
            return cell

            
        }
        
}

import Foundation

extension UIImageView {
    func setImageWithUrl(strUrl: String, placeholderImage: String?, tableView : UITableView) {
        var strDefaultImage = "img-noimage"
        if placeholderImage != nil, placeholderImage != "" {
            strDefaultImage = placeholderImage!
        }
        if let tmpUrl = URL(string: strUrl) {
            let filter = AspectScaledToFillSizeFilter(size: CGSize(width: 100, height: 100))

            af.setImage(withURL: tmpUrl, placeholderImage: UIImage(named: strDefaultImage), filter: filter, imageTransition: .crossDissolve(0.3), completion: { (response) in
                
//                tableView.reloadData()
            })
        } else {
            image = UIImage(named: strDefaultImage)
        }
    }
}
