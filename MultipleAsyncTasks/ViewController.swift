//
//  ViewController.swift
//  MultipleAsyncTasks
//
//  Created by aybek can kaya on 14.05.2019.
//  Copyright © 2019 aybek can kaya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        makeMultipleAsyncTasks()
    }


    private func makeMultipleAsyncTasks() {
        guard let jsonDct:[String:Any] = readJsonFile() , let arrCategoriesDct:[[String:Any]] = jsonDct["categories"] as? [[String:Any]]  else { return }
        let categories:[Category] = arrCategoriesDct.compactMap { dct -> Category? in
            return Category(dct: dct)
        }
        
        //print(categories)
        // progress bar koy , collectionview içerisinde resimleri göster
        ImageKit().download(images:  categories.map{ $0.thumbnailImage }) { (finished, image) in
            print("downloaded : \(image)")
            if finished {
               print("IMAGES DOWNLOADED")
            }
        }
       
    }
    
    
    
    private func readJsonFile<T>()->T? {
        if let path = Bundle.main.path(forResource: "Categories", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let json = jsonResult as? Dictionary<String, AnyObject> , let result:T = json as? T  {
                    return result
                }
            } catch {
                // handle error
            }
           
        }
        return nil
    }

}

