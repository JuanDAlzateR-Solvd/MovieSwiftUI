//
//  BaseScreen.swift
//  MovieSwift
//
//  Created by Juan David Alzate Restrepo on 16/04/26.
//  Copyright © 2026 Thomas Ricouard. All rights reserved.
//


import XCTest

class BaseScreen: Screen {
    let app: XCUIApplication

    required init(app: XCUIApplication) {
        self.app = app
    }

    /// Each concrete screen must override this with a stable anchor element.
    var loadableElement: XCUIElement {
        preconditionFailure("\(String(describing: Self.self)) must override loadableElement.")
    }
    
    var tabBar: TabBarComponent {
        TabBarComponent(app: app)
    }

    @discardableResult
    func waitUntilLoaded(timeout: TimeInterval = 10) -> Self {
        let screenLoaded = loadableElement.waitForExistence(timeout: timeout)

        XCTAssertTrue(
            screenLoaded,
            """
            Failed to load screen: \(String(describing: type(of: self))).
            Expected anchor element did not appear within \(timeout) seconds.
            """,
            file: #filePath,
            line: #line
        )

        return self
    }
    
    @discardableResult
    func on<T: Screen>(_ screenType: T.Type, timeout: TimeInterval = 10) -> T {
        let screen = T(app: app)
        return screen.waitUntilLoaded(timeout: timeout)
    }
      
//    @discardableResult
//    func goToDiscover() -> Screen {
//        TabBarComponent(app: app).tapDiscover()
//        return on(DiscoverScreen.self)
//    }
    
    @discardableResult
    func goToMovies() -> HomeScreen {
        TabBarComponent(app: app).tapMovies()
    }
    
    @discardableResult
    func goToDiscover() -> DiscoverScreen {
        TabBarComponent(app: app).tapDiscover()
    }
    
    @discardableResult
    func goToFanClub() -> FanClubScreen {
        TabBarComponent(app: app).tapFanClub()
    
    }
    
    @discardableResult
    func goToMyLists() -> MyListsScreen {
        TabBarComponent(app: app).tapMyLists()
    }
    
    
}
