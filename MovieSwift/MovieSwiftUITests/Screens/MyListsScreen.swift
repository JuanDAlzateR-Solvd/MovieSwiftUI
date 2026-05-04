//
//  MyListsScreen.swift
//  MovieSwift
//
//  Created by Juan David Alzate Restrepo on 30/04/26.
//  Copyright © 2026 Thomas Ricouard. All rights reserved.
//

import XCTest

final class MyListsScreen: BaseScreen {
    override var loadableElement: XCUIElement {
        app.buttons["myLists.customList"]
    }
    @discardableResult
    func assertMyListsScreenIsDisplayed(timeout: TimeInterval = 10) -> Self {
        waitUntilLoaded(timeout: timeout)
        return self
    }
}
