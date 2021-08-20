//
//  Box.swift
//  Demo_MVVM
//
//  Created by Rahul Sharma on 20/08/21.
//  Copyright © 2021 Rahul Sharma. All rights reserved.
//

import Foundation

class Box<T> { // Creating generic class
    typealias Listener = (T) -> Void
    var listener: Listener?
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(value:T) {
        self.value = value
    }
    
    func bind(listener : Listener?){
        self.listener = listener
        listener?(value)// adding value to listeneer so that whosover is listening can update UI immediately
    }
    
}
