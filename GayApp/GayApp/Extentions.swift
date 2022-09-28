//
//  Extentions.swift
//  GayApp
//
//  Created by Dmitry Zasenko on 28.09.22.
//

import Foundation

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
