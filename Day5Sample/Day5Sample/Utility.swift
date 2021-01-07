//
//  Utility.swift
//  Day5Sample
//
//  Created by 柳田昌弘 on 2021/01/02.
//

import Foundation

func randomValue<T>(_ array: [T]) -> T {
    let random = Int(arc4random()) % array.count
    return array[random]
}
