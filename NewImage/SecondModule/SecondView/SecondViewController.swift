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
        delegateFirstViewProtocol = FirstViewController() // для использования метода  FirstViewController
        self.secondCollection.dataSource = self
        self.secondCollection.delegate = self
        let filepathArray = localDatabaseSecondVC.getFilepathArray()
        print("массив filepathArray в SecondViewController \(filepathArray)")
        delegateFirstViewProtocol.createModelForCell(urlArrayForCell: filepathArray) { (completition: [ForCell]) in
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
                cell.secondImageView.sd_setImage(with: URL(fileURLWithPath: model.urlCell), completed: nil)
                
            }
        return cell
            
        }
        return UICollectionViewCell()
    }
 
    }

    
   
   


