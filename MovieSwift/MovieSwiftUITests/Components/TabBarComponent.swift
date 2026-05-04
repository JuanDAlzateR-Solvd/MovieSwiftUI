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
//        static let movies = "tab.movies"
//        static let discover = "tab.discover"
//        static let fanClub = "tab.fanClub"
//        static let myLists = "tab.myLists"
        static let movies = "film"
        static let discover = "square.stack"
        static let fanClub = "star.circle.fill"
        static let myLists = "heart.circle"
    }

    init(app: XCUIApplication) {
        self.app = app
    }

    private var tabBar: XCUIElement {
          app.tabBars.firstMatch
      }

      private var moviesTab: XCUIElement {
          tabBar.buttons["Movies"]
      }

      private var discoverTab: XCUIElement {
          tabBar.buttons["Discover"]
      }

      private var fanClubTab: XCUIElement {
          tabBar.buttons["Fan Club"]
      }

      private var myListsTab: XCUIElement {
          tabBar.buttons["My Lists"]
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
