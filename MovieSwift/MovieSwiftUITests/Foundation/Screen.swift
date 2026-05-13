//
//  Screen.swift
//  MovieSwift
//
//  Created by Juan David Alzate Restrepo on 16/04/26.
//  Copyright © 2026 Thomas Ricouard. All rights reserved.
//


import XCTest

protocol Screen: AnyObject {
    var app: XCUIApplication { get }
    var loadableElement: XCUIElement { get }

    init(app: XCUIApplication)

    @discardableResult
    func waitUntilLoaded(timeout: TimeInterval) -> Self
}