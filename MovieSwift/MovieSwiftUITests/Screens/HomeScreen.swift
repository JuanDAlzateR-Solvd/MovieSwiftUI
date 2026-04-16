//
//  HomeScreen.swift
//  MovieSwift
//
//  Created by Juan David Alzate Restrepo on 16/04/26.
//  Copyright © 2026 Thomas Ricouard. All rights reserved.
//


import XCTest

final class HomeScreen: BaseScreen {

    private enum Identifiers {
        static let searchField = "movies.searchField"
        static let homeMoviePrefix = "home.movie."
        static let moviesMoviePrefix = "movies.movie."
    }

    private var searchField: XCUIElement {
        app.descendants(matching: .any)[Identifiers.searchField]
    }
    
    override var loadableElement: XCUIElement {
        searchField
    }

    private var movieItems: XCUIElementQuery {
           let homePredicate = NSPredicate(
               format: "identifier BEGINSWITH %@",
               Identifiers.homeMoviePrefix
           )

           let moviesPredicate = NSPredicate(
               format: "identifier BEGINSWITH %@",
               Identifiers.moviesMoviePrefix
           )

           let combinedPredicate = NSCompoundPredicate(
               orPredicateWithSubpredicates: [homePredicate, moviesPredicate]
           )

           return app.descendants(matching: .any).matching(combinedPredicate)
       }

    @discardableResult
    func waitForHomeFeedToLoad(timeout: TimeInterval = 10) -> Self {
        waitUntilLoaded(timeout: timeout)

        let firstMovie = movieItems.firstMatch
        XCTAssertTrue(
            firstMovie.waitForExistence(timeout: timeout),
            "Expected at least one movie item in Home feed."
        )

        return self
    }

    @discardableResult
    func tapOnFirstMovie(timeout: TimeInterval = 10) -> Self {
        let firstMovie = movieItems.firstMatch

        XCTAssertTrue(
            firstMovie.waitForExistence(timeout: timeout),
            "Could not find first movie item in Home feed."
        )

        firstMovie.tap()
        return self
    }
}
