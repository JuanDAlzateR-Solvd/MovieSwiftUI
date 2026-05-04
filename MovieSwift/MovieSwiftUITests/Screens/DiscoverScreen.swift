//
//  DiscoverScreen.swift
//  MovieSwift
//
//  Created by Juan David Alzate Restrepo on 30/04/26.
//  Copyright © 2026 Thomas Ricouard. All rights reserved.
//

import XCTest

final class DiscoverScreen: BaseScreen {
    override var loadableElement: XCUIElement {
        app.images["tab.discover"]
    }
    
    @discardableResult
    func assertDiscoverScreenIsDisplayed(timeout: TimeInterval = 10) -> Self {
        waitUntilLoaded(timeout: timeout)
        return self
    }
}
