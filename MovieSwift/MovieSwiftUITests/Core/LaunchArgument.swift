//
//  LaunchArgument.swift
//  MovieSwift
//
//  Created by Juan David Alzate Restrepo on 3/06/26.
//  Copyright © 2026 Thomas Ricouard. All rights reserved.
//

import Foundation

/// A namespace for all launch argument strings passed to XCUIApplication.
///
/// Using static constants instead of raw strings means:
/// - A typo is a compile error, not a silent bug
/// - Every argument is discoverable in one place
/// - Tests and the app side both import the same value
///
/// The app reads these at startup via `CommandLine.arguments`.
enum LaunchArgument {

    /// Tells the app it is running under XCUITest.
    /// Use this to opt out of first-launch onboarding, analytics, etc.
    static let uiTesting = "-ui-testing"

    /// Clears persisted user data before the test starts.
    /// Useful for tests that require a clean-slate app state.
    static let resetState = "-reset-state"

    /// Disables UIView and SwiftUI animations.
    /// Makes transitions instant so tests don't race against animations.
    static let disableAnimations = "-disable-animations"

    // MARK: - Network stubs (for future use once a stubbing layer is added)

    /// Instructs the app to return successful mock API responses.
    static let mockSuccess = "-mock-success"

    /// Instructs the app to return empty-list mock API responses.
    static let mockEmptyResults = "-mock-empty-results"

    /// Instructs the app to return error mock API responses.
    static let mockError = "-mock-error"
}
