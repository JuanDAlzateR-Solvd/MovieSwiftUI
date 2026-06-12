//
//  HomeScreen.swift
//  MovieSwift
//
//  Created by Juan David Alzate Restrepo on 16/04/26.
//  Copyright © 2026 Thomas Ricouard. All rights reserved.
//


import XCTest

final class HomeScreen: BaseScreen {
    
    struct DisplayedMoviesSnapshot: Equatable {
        let movieIdentifiers: [String]
    }

    private var lastSearchQuery: String?

    private var searchField: XCUIElement {
        app.textFields[AccessibilityIdentifiers.Movies.searchField]
    }
    
    override var loadableElement: XCUIElement {
        movieItems.firstMatch
    }

    private var movieItems: XCUIElementQuery {
        let homePredicate = NSPredicate(
            format: "identifier BEGINSWITH %@",
            AccessibilityIdentifiers.Home.moviePrefix
        )

        let moviesPredicate = NSPredicate(
            format: "identifier BEGINSWITH %@",
            AccessibilityIdentifiers.Movies.moviePrefix
        )

        let combinedPredicate = NSCompoundPredicate(
            orPredicateWithSubpredicates: [homePredicate, moviesPredicate]
        )

        return app.descendants(matching: .any).matching(combinedPredicate)
    }
    
    private var sectionContainers: XCUIElementQuery {
        app.descendants(matching: .any)
            .matching(NSPredicate(format: "identifier BEGINSWITH %@", AccessibilityIdentifiers.Home.sectionPrefix))
    }

    private var currentVisibleSection: XCUIElement {
        let visibleCandidates = min(sectionContainers.count, 5)

        for index in 0..<visibleCandidates {
            let section = sectionContainers.element(boundBy: index)
            if section.exists && section.isHittable {
                return section
            }
        }

        return sectionContainers.firstMatch
    }

    private func sectionRoot(_ sectionId: String) -> XCUIElement {
        app.descendants(matching: .any)[AccessibilityIdentifiers.Home.section(sectionId)]
    }

    @discardableResult
    func waitForHomeFeedToLoad(timeout: TimeInterval = 10) -> Self {
        TestTrace.step("Home: wait for home feed to load") {
            waitUntilLoaded(timeout: timeout)
        }
        return self
    }

    @discardableResult
    func tapOnFirstMovie(timeout: TimeInterval = 10) -> Self {
        TestTrace.step("Home: tap on first movie") {
            let firstMovie = movieItems.firstMatch
            firstMovie.waitUntilExists(timeout: timeout)
            firstMovie.tapWhenHittable(timeout: timeout)
        }
        return self
    }

    @discardableResult
    func searchMovie(_ query: String, timeout: TimeInterval = 10) -> Self {
        TestTrace.step("Home: search movie '\(query)'") {
            lastSearchQuery = query
            searchField.waitUntilExists(timeout: timeout)
            searchField.typeTextWhenHittable(query, timeout: timeout)
        }
        return self
    }

    @discardableResult
    func waitForSearchResultsToLoad(timeout: TimeInterval = 10) -> Self {
        TestTrace.step("Home: wait for search results to load") {
            guard let query = lastSearchQuery, !query.isEmpty else {
                XCTFail("Search query was not set before waiting for search results.")
                return
            }
            
            app.dismissKeyboardIfPresent()
            
            let resultsHeader = app.staticTexts["Results for \(query)"]
            resultsHeader.waitUntilExists(timeout: timeout)
            
            let firstMovie = movieItems.firstMatch
            firstMovie.waitUntilExists(timeout: timeout)
        }
        
        return self
    }
        
    func captureDisplayedMoviesSnapshot(
        limit: Int = 3,
        timeout: TimeInterval = 10
    ) -> DisplayedMoviesSnapshot {
        let firstMovie = movieItems.firstMatch
        firstMovie.waitUntilExists(timeout: timeout)

        let visibleCount = min(movieItems.count, limit)
        var identifiers: [String] = []

        for index in 0..<visibleCount {
            let movie = movieItems.element(boundBy: index)
            movie.waitUntilExists(timeout: timeout)
            identifiers.append(movie.identifier)
        }

        return DisplayedMoviesSnapshot(movieIdentifiers: identifiers)
    }

    @discardableResult
    func assertDisplayedMoviesChanged(
        comparedTo previousSnapshot: DisplayedMoviesSnapshot,
        timeout: TimeInterval = 10,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Self {
        let currentSnapshot = captureDisplayedMoviesSnapshot(limit: previousSnapshot.movieIdentifiers.count, timeout: timeout)

        XCTAssertNotEqual(
            currentSnapshot,
            previousSnapshot,
            "Expected displayed movies to change, but the visible movie identifiers remained the same.",
            file: file,
            line: line
        )

        return self
    }
    
    @discardableResult
    func assertCurrentSectionIs(_ sectionId: String, timeout: TimeInterval = 10) -> Self {
        sectionRoot(sectionId).waitUntilExists(timeout: timeout)
        return self
    }

    @discardableResult
    func swipeToNextSection(timeout: TimeInterval = 10) -> Self {
        let visibleSection = currentVisibleSection
        visibleSection.waitUntilExists(timeout: timeout)
        visibleSection.swipeLeft()
        return self
    }
    
    @discardableResult
    func assertCurrentNavigationTitleIs(
        _ title: String,
        timeout: TimeInterval = 10
    ) -> Self {
        let header = app.staticTexts[title]
        header.waitUntilExists(timeout: timeout)
        return self
    }
    
    @discardableResult
    func assertHomeScreenIsDisplayed(timeout: TimeInterval = 10) -> Self {
        waitUntilLoaded(timeout: timeout)
        return self
    }
}
