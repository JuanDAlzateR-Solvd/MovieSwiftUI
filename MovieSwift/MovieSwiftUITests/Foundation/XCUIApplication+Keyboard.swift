//
//  Untitled.swift
//  MovieSwift
//
//  Created by Juan David Alzate Restrepo on 23/04/26.
//  Copyright © 2026 Thomas Ricouard. All rights reserved.
//

import XCTest

extension XCUIApplication {

    func dismissKeyboardIfPresent() {
        let keyboard = keyboards.firstMatch

        guard keyboard.exists else {
            return
        }

        let dismissButtonLabels = ["Hide keyboard", "Done", "Return", "Search", "Go"]

        for label in dismissButtonLabels {
            let button = keyboard.buttons[label]
            if button.exists && button.isHittable {
                button.tap()
                return
            }
        }

        // Fallback: tap outside the keyboard on a safe area of the app
        coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.1)).tap()
    }
}
