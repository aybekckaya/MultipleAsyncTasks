//
//  ImageKit.swift
//  MultipleAsyncTasks
//
//  Created by aybek can kaya on 16.05.2019.
//  Copyright © 2019 aybek can kaya. All rights reserved.
//

import UIKit

class ImageKit: NSObject {
    
    private let group:DispatchGroup = DispatchGroup()
    
    override init() {
        super.init()
    }
    
    func download(images:[String] , completion:@escaping ((_ finished:Bool , _ downloadedImage:UIImage?)->()) ) {
        images.forEach { imgURL in
            group.enter()
            self.asyncTask(imageURL: imgURL, completion: { [weak self] image in
                guard let self = self else { return }
                completion(false, image)
                self.group.leave()
            })
        }
        group.notify(queue: DispatchQueue.main) { completion(true , nil ) }
    }
    
    private func asyncTask(imageURL:String , completion:@escaping ( (_ image:UIImage?)->() ) ) {
        DispatchQueue.global(qos: .background).async {
            guard let url:URL = URL(string: imageURL) ,   let imageData:Data = try? Data(contentsOf: url) ,  let image:UIImage = UIImage(data: imageData) else {
                completion(nil)
                return
            }
            DispatchQueue.main.async { completion(image) }
        }
    }
    
}
