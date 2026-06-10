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
        TestTrace.step("\(String(describing: Self.self)): wait until loaded"){
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

        }

        return self
    }
    
    @discardableResult
    func on<T: Screen>(_ screenType: T.Type, timeout: TimeInterval = 10) -> T {
        TestTrace.step("Navigate context to \(String(describing: screenType))"){
            let screen = T(app: app)
            return screen.waitUntilLoaded(timeout: timeout)
        }

    }
      
//    @discardableResult
//    func goToDiscover() -> Screen {
//        TabBarComponent(app: app).tapDiscover()
//        return on(DiscoverScreen.self)
//    }
    
    @discardableResult
    func goToMovies() -> HomeScreen {
        TestTrace.step("TabBar: go to Movies") {            
            TabBarComponent(app: app).tapMovies()
        }
    }
    
    @discardableResult
    func goToDiscover() -> DiscoverScreen {
        TestTrace.step("TabBar: go to Discover") {
            TabBarComponent(app: app).tapDiscover()
        }
    }
    
    @discardableResult
    func goToFanClub() -> FanClubScreen {
        TestTrace.step("TabBar: go to Fan Club") {
            TabBarComponent(app: app).tapFanClub()
        }
    
    }
    
    @discardableResult
    func goToMyLists() -> MyListsScreen {
        TestTrace.step("TabBar: go to My Lists") {
            TabBarComponent(app: app).tapMyLists()
        }
    }
    
    
}
