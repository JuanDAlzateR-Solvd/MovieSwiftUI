//
//  TabBarComponent.swift
//  MovieSwift
//
//  Created by Juan David Alzate Restrepo on 30/04/26.
//  Copyright © 2026 Thomas Ricouard. All rights reserved.
//

import XCTest

final class TabBarComponent {
    private let app: XCUIApplication

    init(app: XCUIApplication) {
        self.app = app
    }

    private var tabBar: XCUIElement {
          app.tabBars.firstMatch
    }

    private var moviesTab: XCUIElement {
        tabBar.buttons[AccessibilityIdentifiers.Tab.movies]
    }

    private var discoverTab: XCUIElement {
        tabBar.buttons[AccessibilityIdentifiers.Tab.discover]
    }

    private lazy var fanClubTab: XCUIElement = app.tabBars.buttons[AccessibilityIdentifiers.Tab.fanClub]
    

    private var myListsTab: XCUIElement {
        tabBar.buttons[AccessibilityIdentifiers.Tab.myLists]
    }


    @discardableResult
    func assertIsVisible(timeout: TimeInterval = 10) -> Self {
        moviesTab.waitUntilExists(timeout: timeout)
        discoverTab.waitUntilExists(timeout: timeout)
        fanClubTab.waitUntilExists(timeout: timeout)
        myListsTab.waitUntilExists(timeout: timeout)
        return self
    }

    @discardableResult
    func tapMovies(timeout: TimeInterval = 10) -> HomeScreen {
        moviesTab.waitUntilExists(timeout: timeout)
        moviesTab.tapWhenHittable(timeout: timeout)
        return HomeScreen(app: app).waitUntilLoaded(timeout: timeout)
    }

    @discardableResult
    func tapDiscover(timeout: TimeInterval = 10) -> DiscoverScreen {
        discoverTab.waitUntilExists(timeout: timeout)
        discoverTab.tapWhenHittable(timeout: timeout)
        return DiscoverScreen(app: app).waitUntilLoaded(timeout: timeout)
    }

    @discardableResult
    func tapFanClub(timeout: TimeInterval = 10) -> FanClubScreen {
        fanClubTab.waitUntilExists(timeout: timeout)
        fanClubTab.tapWhenHittable(timeout: timeout)
        return FanClubScreen(app: app).waitUntilLoaded(timeout: timeout)
    }

    @discardableResult
    func tapMyLists(timeout: TimeInterval = 10) -> MyListsScreen {
        myListsTab.waitUntilExists(timeout: timeout)
        myListsTab.tapWhenHittable(timeout: timeout)
        return MyListsScreen(app: app).waitUntilLoaded(timeout: timeout)
    }
}
