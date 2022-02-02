//
//  LocalDatabase.swift
//  NewImage
//
//  Created by Tanya on 31.01.2022.
//

import Foundation
import UIKit

protocol LocalDatabaseProtocol: class {
    var filepathArray: [String] { get set }
    func saveImageToDocumentDirectory(_ chosenImage: UIImage) -> [String]
}

class LocalDatabase: LocalDatabaseProtocol {
    var savedCellModel: [ForCell] = []
    var filepathArray: [String] = []
    
    func saveImageToDocumentDirectory(_ chosenImage: UIImage) -> [String] {
            let directoryPath =  NSHomeDirectory().appending("/Documents/")
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
                let urlImage = String.init("/Documents/\(filename)")
                filepathArray.append(urlImage)
                print("пути к сохраненным картинкам \(filepathArray)")
                return filepathArray
               // return String.init("/Documents/\(filename)")

            } catch {
                print(error)
                print("file cant not be save at path \(filepath), with error : \(error)")
                return []
                
            }
        }
}

/* func saveImageFromUrl(url: String) {
     let localImageView = UIImageView()
     localImageView.sd_setImage(with: URL(string: url), completed: nil)
     if localImageView.image != nil {
         savedImageArray.append(localImageView.image!)
         print(savedImageArray)
     }
 }
*/
