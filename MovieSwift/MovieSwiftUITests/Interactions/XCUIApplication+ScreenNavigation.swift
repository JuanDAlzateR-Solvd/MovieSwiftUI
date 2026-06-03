//
//  ext.swift
//  MovieSwift
//
//  Created by Juan David Alzate Restrepo on 16/04/26.
//  Copyright © 2026 Thomas Ricouard. All rights reserved.
//

import XCTest

extension XCUIApplication {
    @discardableResult
    func on<T: Screen>(_ screenType: T.Type, timeout: TimeInterval = 10) -> T {
        let screen = T(app: self)
        return screen.waitUntilLoaded(timeout: timeout)
    }
}
