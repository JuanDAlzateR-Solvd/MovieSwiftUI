//
//  MovieDetailsScreen.swift
//  MovieSwift
//
//  Created by Juan David Alzate Restrepo on 16/04/26.
//  Copyright © 2026 Thomas Ricouard. All rights reserved.
//


import XCTest

final class MovieDetailsScreen: BaseScreen {

    private enum Identifiers {
        static let screen = "movieDetail.screen"
        static let addButton = "movieDetail.addButton"
        static let overview = "movieDetail.overview"
    }

    private var addButton: XCUIElement {
        app.descendants(matching: .any)[Identifiers.addButton]
    }

    private var overview: XCUIElement {
        app.descendants(matching: .any)[Identifiers.overview]
    }

    override var loadableElement: XCUIElement {
        app.descendants(matching: .any)[Identifiers.screen]
    }

    @discardableResult
    func assertMovieDetailsAreDisplayed(timeout: TimeInterval = 10) -> Self {
        TestTrace.step("Movie Details: assert details screen is displayed") {
            waitUntilLoaded(timeout: timeout)
            addButton.waitUntilExists(timeout: timeout)
        }
        return self
    }
}
