//
//  AsyncAction.swift
//  MultipleAsyncTasks
//
//  Created by aybek can kaya on 14.05.2019.
//  Copyright © 2019 aybek can kaya. All rights reserved.
//

import UIKit

struct Task {
    let id:Int
    
    init(id:Int ) {
       self.id = id
    }
}


class AsyncAction: NSObject {

    func asyncAction(with tasks:[Task] , completion:@escaping ((_ finished:Bool , _ completedTask:Task?)->()) ) {
        let group:DispatchGroup = DispatchGroup()
        tasks.forEach { task in
            group.enter()
            self.asyncTask(task: task, completion: { task in
                completion(false, task)
                group.leave()
            })
        }
        
        group.notify(queue: DispatchQueue.main) {
             completion(true , nil )
        }

    }
    
    private func asyncTask(task:Task , completion:@escaping ( (_ task:Task)->() ) ) {
        let randomWaitingTime:Int = Int.random(in: 1..<3)
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + .seconds(randomWaitingTime)) {
            DispatchQueue.main.async {
                 completion(task)
            }
        }
    }
    
}
