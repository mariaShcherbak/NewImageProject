//
//  SecondViewController.swift
//  Image
//
//  Created by Tanya on 13.01.2022.
//

import Foundation
import UIKit

class SecondViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITabBarDelegate {
   
    var cellModel = [ForCell]()
    var delegateFirstViewProtocol: FirstViewProtocol!
    var localDatabaseSecondVC: LocalDatabaseProtocol!
    @IBOutlet weak var secondCollection: UICollectionView!
    @IBOutlet weak var tabItem: UITabBarItem!
    
    override func viewDidLoad() {
        localDatabaseSecondVC = LocalDatabase()
        delegateFirstViewProtocol = FirstViewController() // для использования метода  FirstViewController переделать на протокол отдельный только с методом
        self.secondCollection.dataSource = self
        self.secondCollection.delegate = self
        
        var filepathArray = localDatabaseSecondVC.getFilepathArray()
        print("массив filepathArray в SecondViewController \(filepathArray)")
        delegateFirstViewProtocol.createModelForCell(urlArrayForCell: filepathArray) { (completition: [ForCell]) in
            self.cellModel = completition
          //  print("модель для secondVC \(self.cellModel)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewDidLoad()
        secondCollection.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModel.count
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
    // нажатие на ячейку вызывает алерт, удалить - если да - вызывается метод удаления. он принимает url, вычленяется имя и удаляется файл из папки (папка тоже как часть пути), возвращается массив без выбранной картинки, таблица обновляется.
    //нажатие на ячейку
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let optionMenu = UIAlertController(title: nil, message: "Удалить изображение?", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        let saveActionHandler = {(action: UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: nil, message: "Изображение удалено", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
            
            //сохранение картинки в галерею
            let cell = self.cellModel[indexPath.row]
            // вызвать удаление, cохранить в userDefaults filepathArray
            self.localDatabaseSecondVC.deleteImage(cell)
            UserDefaults.standard.setValue(self.localDatabaseSecondVC.deleteImage(cell), forKey: "filepathArray")
            self.viewWillAppear(true)
        }
        
        let saveAction = UIAlertAction(title: "Удалить", style: .default, handler: saveActionHandler)
        optionMenu.addAction(cancelAction)
        optionMenu.addAction(saveAction)
        self.present(optionMenu, animated: true, completion: nil)
        //self.secondCollection.reloadData()
    }
}

    
   
   


