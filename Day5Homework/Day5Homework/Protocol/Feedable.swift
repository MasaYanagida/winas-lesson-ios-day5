//
//  Feedable.swift
//  Day5Homework
//
//  Created by 杉浦祐一 on 2021/01/16.
//

import Foundation

enum FeedContentType: Int {
    case hospital = 1, restaurant = 2
}

// MARK: - Feedable
protocol Feedable: class {
    var feedContentType: FeedContentType { get }
}
