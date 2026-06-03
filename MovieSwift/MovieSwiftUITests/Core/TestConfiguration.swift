//
//  TestConfiguration.swift
//  MovieSwift
//
//  Created by Juan David Alzate Restrepo on 3/06/26.
//  Copyright © 2026 Thomas Ricouard. All rights reserved.
//

import Foundation

/// A single source of truth for test-wide defaults.
///
/// Centralising these values means:
/// - A timeout change in CI requires editing one constant, not every screen object
/// - Every test gets the same baseline launch configuration without copy-paste
/// - Test authors can deviate deliberately (pass custom args to launchApp) while
///   the happy path stays zero-config
enum TestConfiguration {

    // MARK: - Timeouts

    /// Default wait for most UI interactions (element appears, becomes hittable, etc.)
    static let defaultTimeout: TimeInterval = 10

    /// Short wait for elements that should already be on screen.
    static let shortTimeout: TimeInterval = 5

    /// Extended wait for slow network responses or heavy transitions.
    static let longTimeout: TimeInterval = 20

    // MARK: - Launch arguments

    /// Applied automatically to every test unless overridden.
    ///
    /// - `-ui-testing` lets the app skip setup flows not relevant to tests.
    /// - `-disable-animations` makes transitions instant, reducing flakiness.
    static let defaultLaunchArguments: [String] = [
        LaunchArgument.uiTesting,
        LaunchArgument.disableAnimations
    ]

    // MARK: - Launch environment

    /// Applied automatically to every test unless overridden.
    /// Empty by default; add key-value pairs here when the app supports
    /// environment-driven configuration (e.g. a local API base URL).
    static let defaultLaunchEnvironment: [String: String] = [:]
}
