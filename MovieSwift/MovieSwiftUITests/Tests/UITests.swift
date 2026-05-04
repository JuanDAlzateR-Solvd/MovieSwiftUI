//
//  MovieSwiftUITests.swift
//  MovieSwiftUITests
//
//  Created by Juan David Alzate Restrepo on 15/04/26.
//  Copyright © 2026 Thomas Ricouard. All rights reserved.
//

import XCTest

final class UITests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    

    func test_appLaunches() {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.exists)
        
        // Create a predicate to look for identifiers that start with "movies.movie."
        let predicate = NSPredicate(format: "identifier BEGINSWITH %@", "movies.movie.")
        
        // Apply predicate to all elements (or specifically .buttons if they have that trait)
        let movieElements = app.buttons.matching(predicate)
        
        // Interact
        let totalMovies = movieElements.count
        print("Found \(totalMovies) movies")
        
        movieElements.element(boundBy: 0).tap()
        
    }
    
    func test_openMovieFromHome() {
        let app = XCUIApplication()
        app.launch()
        XCTAssertTrue(app.exists)
        
        app
            .on(HomeScreen.self)
            .waitForHomeFeedToLoad()
            .tapOnFirstMovie()
            .on(MovieDetailsScreen.self)
            .assertMovieDetailsAreDisplayed()
    }
    
    func test_homeFeedLoads() {
           let app = XCUIApplication()
           app.launch()

           app
               .on(HomeScreen.self)
               .waitForHomeFeedToLoad()
       }

    func test_openMovieDetailsFromSearchResults() {
        let app = XCUIApplication()
        app.launch()

        app
            .on(HomeScreen.self)
            .waitForHomeFeedToLoad()
            .searchMovie("batman")
            .waitForSearchResultsToLoad()
            .tapOnFirstMovie()
            .on(MovieDetailsScreen.self)
            .assertMovieDetailsAreDisplayed()
    }
    
    func test_searchChangesDisplayedContent() {
        let app = XCUIApplication()
        app.launch()

        let homeScreen = app
            .on(HomeScreen.self)
            .waitForHomeFeedToLoad()

        let initialSnapshot = homeScreen.captureDisplayedMoviesSnapshot()

        homeScreen
            .searchMovie("batman")
            .waitForSearchResultsToLoad()
            .assertDisplayedMoviesChanged(comparedTo: initialSnapshot)
    }
    
    func test_homeSwipeChangesSections() {
        let app = XCUIApplication()
        app.launch()

        app
            .on(HomeScreen.self)
            .waitForHomeFeedToLoad()
            .assertCurrentSectionIs("nowplaying")
        
            .swipeToNextSection()
            .waitForHomeFeedToLoad()
            .assertCurrentSectionIs("upcoming")
                
            .swipeToNextSection()
            .waitForHomeFeedToLoad()
            .assertCurrentSectionIs("trending")
            
            .swipeToNextSection()
            .waitForHomeFeedToLoad()
            .assertCurrentSectionIs("popular")
            .assertCurrentNavigationTitleIs("Popular")
        
            .swipeToNextSection()
            .waitForHomeFeedToLoad()
            .assertCurrentSectionIs("toprated")
            .assertCurrentNavigationTitleIs("Top Rated")
        
            .swipeToNextSection()
            .assertCurrentSectionIs("genres")
            .assertCurrentNavigationTitleIs("Genres")

    }
    
    func test_tabBar() {
        let app = XCUIApplication()
        app.launch()

        app
            .on(HomeScreen.self)
            .waitForHomeFeedToLoad()
            .goToDiscover()
            .assertDiscoverScreenIsDisplayed()
            .goToFanClub()
            .assertFanClubScreenIsDisplayed()
            .goToMyLists()
            .assertMyListsScreenIsDisplayed()
            .goToMovies()
            .assertHomeScreenIsDisplayed()
    }
    
}

