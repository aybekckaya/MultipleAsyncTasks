//
//  Category.swift
//  MultipleAsyncTasks
//
//  Created by aybek can kaya on 15.05.2019.
//  Copyright © 2019 aybek can kaya. All rights reserved.
//

import Foundation

struct Category {
    let id:String
    let name:String
    let thumbnailImage:String
    
    init?(dct:[String:Any]?) {
        guard let dctValues = dct , let id:String = dctValues["idCategory"] as? String , let name:String = dctValues["strCategory"] as? String , let thumbImage:String = dctValues["strCategoryThumb"] as? String else { return nil }
        self.id = id
        self.name = name
        self.thumbnailImage = thumbImage
    }
    
}
