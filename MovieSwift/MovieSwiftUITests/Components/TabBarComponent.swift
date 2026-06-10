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

    private enum Identifiers {
        static let movies   = "tab.movies"
        static let discover = "tab.discover"
        static let fanClub  = "tab.fanClub"
        static let myLists  = "tab.myLists"
    }

    init(app: XCUIApplication) {
        self.app = app
    }

    private var tabBar: XCUIElement {
          app.tabBars.firstMatch
    }

    private var moviesTab: XCUIElement {
        tabBar.buttons[Identifiers.movies]
    }

    private var discoverTab: XCUIElement {
        tabBar.buttons[Identifiers.discover]
    }

    private lazy var fanClubTab: XCUIElement = app.tabBars.buttons[Identifiers.fanClub]
    

    private var myListsTab: XCUIElement {
        tabBar.buttons[Identifiers.myLists]
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
