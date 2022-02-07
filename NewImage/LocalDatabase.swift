//
//  LocalDatabase.swift
//  NewImage
//
//  Created by Tanya on 31.01.2022.
//

import Foundation
import UIKit
import SDWebImage

protocol LocalDatabaseProtocol: class {
    var filepathArray: [String] { get set }
    func saveImageToDocumentDirectory(_ chosen: ForCell) -> String
    func createFilepathArray(string: String)
    func getFilepathArray() -> [String]
}

class LocalDatabase: LocalDatabaseProtocol {
    var savedCellModel: [ForCell] = []
    var filepathArray: [String] = UserDefaults.standard.object(forKey: "filepathArray") as! [String]

    func saveImageToDocumentDirectory(_ chosen: ForCell) -> String {
            let directoryPath =  NSHomeDirectory().appending("/Documents/")
        print("directoryPath \(directoryPath)")
            if !FileManager.default.fileExists(atPath: directoryPath) {
                do {
                    try FileManager.default.createDirectory(at: NSURL.fileURL(withPath: directoryPath), withIntermediateDirectories: true, attributes: nil)
                } catch {
                    print(error)
                }
            }
        let chosenImageView = UIImageView()
        chosenImageView.sd_setImage(with: URL(string: chosen.urlCell), completed: nil)
        print("ииииииимяяяяя")
            let filename = nameImageInUrl(url: chosen.urlCell)
            let filepath = directoryPath.appending(filename)
            let url = NSURL.fileURL(withPath: filepath)
        if check(url: filepath) == false {
            do {
                try chosenImageView.image!.jpegData(compressionQuality: 1.0)?.write(to: url, options: .atomic)
                print("изображение прошло проверку и сохранилось")
                return String.init("\(directoryPath)\(filename)")
            }
             catch {
                print(error)
                print("file cant not be save at path \(filepath), with error : \(error)")
                return ""
            }
        }
        else {
            print("Изображение сохранено ранее")
            return ""
        }
    }
    
    func deleteImage(_ chosen: ForCell) -> String {
      //  let name = nameImageInUrl(url: chosen.urlCell)
        let delete = FileManager.removeItem(<#T##self: FileManager##FileManager#>)
        removeItem(atPath: chosen.urlCell)
        
    }
    
    func nameImageInUrl(url: String) -> String {
        let components = url.components(separatedBy: "/")
        let countComponents = components.count - 1
        let lastComponents = components[countComponents]
        let nameWithParameters = lastComponents.components(separatedBy: "?")
        let name = nameWithParameters[0]
        return name
    }
    
    // проверка url на сохранение ранее
    func check(url: String) -> Bool {
        if filepathArray.contains(url) {
            return true
        }
        else {
            return false
        }
    }
    
    //создать и сохранить в UserDefaults filepathArray
    func createFilepathArray(string: String) {
        if string == "" {
            print("изображение не сохранилось повторно")
        }
        else {
            filepathArray.append(string)
        }
        UserDefaults.standard.setValue(filepathArray, forKey: "filepathArray")
    }
    
    //filepathArray из UserDefaults
    func getFilepathArray() -> [String] {
        return filepathArray
    }
}



/* func deleteImageToDocumentDirectory(_ chosenImage: UIImage) -> String {
        let directoryPath =  NSHomeDirectory().appending("/Documents/")
    print("directoryPath \(directoryPath)")
        if !FileManager.default.fileExists(atPath: directoryPath) {
            do {
                try FileManager.default.createDirectory(at: NSURL.fileURL(withPath: directoryPath), withIntermediateDirectories: true, attributes: nil)
            } catch {
                print(error)
            }
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddhhmmss"

        let filename = dateFormatter.string(from: Date()).appending(".jpg")
        let filepath = directoryPath.appending(filename)
        let url = NSURL.fileURL(withPath: filepath)
        do {
            try chosenImage.jpegData(compressionQuality: 1.0)?.write(to: url, options: .atomic)
            //let urlImage = String.init("/Documents/\(filename)")
           // filepathArray.append(urlImage)
           // print("пути к сохраненным картинкам \(filepathArray)")
          //  return filepathArray
            return String.init("\(directoryPath)\(filename)")

        } catch {
            print(error)
            print("file cant not be save at path \(filepath), with error : \(error)")
            return filepath
        }
    }
*/
