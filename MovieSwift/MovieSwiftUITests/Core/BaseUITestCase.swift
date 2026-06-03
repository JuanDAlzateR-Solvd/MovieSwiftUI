//
//  BaseUITestCase.swift
//  MovieSwift
//
//  Created by Juan David Alzate Restrepo on 6/05/26.
//  Copyright © 2026 Thomas Ricouard. All rights reserved.
//

import XCTest

class BaseUITestCase: XCTestCase {

    // The single application instance shared across all helpers and screen objects.
    // Declared here so subclasses and screens never need to create their own.
    private(set) var app: XCUIApplication!

    // MARK: - Lifecycle

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = makeApplication()
        launchApp()
    }

    override func tearDownWithError() throws {
        if let testRun, testRun.failureCount > 0 {
            TestTrace.attachScreenshot(name: "Failure screenshot - \(name)", app: app)
        }
        app = nil
    }

    // MARK: - App launch

    /// Creates a fresh XCUIApplication pointed at the main app bundle.
    /// Override in a subclass if you need to target a different bundle identifier.
    func makeApplication() -> XCUIApplication {
        XCUIApplication()
    }

    /// Launches the app with the given arguments and environment variables.
    ///
    /// Defaults come from `TestConfiguration`, so every test gets a consistent
    /// baseline without any extra setup. Override only when a specific test
    /// needs different launch conditions — for example, to inject mock data:
    ///
    /// ```swift
    /// launchApp(arguments: [LaunchArgument.uiTesting, LaunchArgument.mockError])
    /// ```
    ///
    /// - Parameters:
    ///   - arguments: Passed to `CommandLine.arguments` inside the app.
    ///   - environment: Key-value pairs available via `ProcessInfo.processInfo.environment`.
    @discardableResult
    func launchApp(
        arguments: [String] = TestConfiguration.defaultLaunchArguments,
        environment: [String: String] = TestConfiguration.defaultLaunchEnvironment
    ) -> XCUIApplication {
        app.launchArguments = arguments
        app.launchEnvironment = environment

        TestTrace.step("Launch app") {
            app.launch()
        }

        return app
    }
}
