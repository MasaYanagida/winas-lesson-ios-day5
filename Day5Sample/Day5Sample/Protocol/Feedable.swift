//
//  Feedable.swift
//  Day5Sample
//
//  Created by 柳田昌弘 on 2021/01/02.
//

import Foundation

enum FeedContentType: Int {
    case hospital = 1, restraunt = 2
}

// MARK: - Feedable

protocol Feedable: class {
    var feedContentType: FeedContentType { get }
}
