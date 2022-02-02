//
//  SecondViewController.swift
//  Image
//
//  Created by Tanya on 13.01.2022.
//

import Foundation
import UIKit

class SecondViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
   
    
    var cellModel = [ForCell]()
    var delegateFirstViewProtocol: FirstViewProtocol!
    var localDatabaseSecondVC: LocalDatabaseProtocol!
    @IBOutlet weak var secondCollection: UICollectionView!
    
    override func viewDidLoad() {
        localDatabaseSecondVC = LocalDatabase()
        delegateFirstViewProtocol = FirstViewController() // хочу использовать метод который есть в FirstViewController
        self.secondCollection.dataSource = self
        self.secondCollection.delegate = self
        delegateFirstViewProtocol.createModelForCell(urlArrayForCell: localDatabaseSecondVC.filepathArray) { (completition: [ForCell]) in
            self.cellModel = completition
            print("модель для secondVC \(self.cellModel)")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModel.count
        //return localDatabaseSecondVC.savedImageArray.count
       // print("количество сохраненных картинок \(localDatabaseSecondVC.savedImageArray.count)")
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SecondCell", for: indexPath) as? MySecondCollectionViewCell {
            var model = cellModel[indexPath.row]
            if cellModel.isEmpty {
                print("нет сохраненных изображений")
            } else {
                cell.secondImageView.sd_setImage(with: URL(string: model.urlCell), completed: nil)
            }
        return cell
            
        }
        return UICollectionViewCell()
    }
 
    }

    
   
   


