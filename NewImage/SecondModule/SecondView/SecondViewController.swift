//
//  SecondViewController.swift
//  Image
//
//  Created by Tanya on 13.01.2022.
//

import Foundation
import UIKit

class SecondViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var localDatabaseSecondVC: LocalDatabaseProtocol!
    @IBOutlet weak var secondCollection: UICollectionView!
    
    override func viewDidLoad() {
        localDatabaseSecondVC = LocalDatabase()
        self.secondCollection.dataSource = self
        self.secondCollection.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 2
        //return localDatabaseSecondVC.savedImageArray.count
       // print("количество сохраненных картинок \(localDatabaseSecondVC.savedImageArray.count)")
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondCell", for: indexPath) as? MySecondCollectionViewCell {
            //var model = localDatabaseSecondVC.savedImageArray[indexPath.row]
           // print("dfdfdfdfd \(localDatabaseSecondVC.savedImageArray)")
           // if localDatabaseSecondVC.savedImageArray.isEmpty {
           //     print("нет сохраненных изображений")
          //  } else {
          //      cell.secondImageView.image = model
          //  }
       // return cell
            
        }
        return UICollectionViewCell()
    }
 
    }

    
   
   


