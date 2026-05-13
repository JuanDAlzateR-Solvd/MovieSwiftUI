//
//  FanClubScreen.swift
//  MovieSwift
//
//  Created by Juan David Alzate Restrepo on 30/04/26.
//  Copyright © 2026 Thomas Ricouard. All rights reserved.
//

import XCTest

final class FanClubScreen: BaseScreen {
    
    private enum Identifiers {
        static let fabClubPeoplePrefix = "fanClub.people"
    }
    
    override var loadableElement: XCUIElement {
        people.firstMatch
    }
    
    private var people: XCUIElementQuery {
        let fanClubPredicate = NSPredicate(
            format: "identifier BEGINSWITH %@",
            Identifiers.fabClubPeoplePrefix
        )
        return app.descendants(matching: .any).matching(fanClubPredicate)
    }
    
    @discardableResult
    func assertFanClubScreenIsDisplayed(timeout: TimeInterval = 10) -> Self {
        waitUntilLoaded(timeout: timeout)
        return self
    }
}
