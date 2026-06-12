//
//  MovieSwiftUITests.swift
//  MovieSwiftUITests
//
//  Created by Juan David Alzate Restrepo on 15/04/26.
//  Copyright © 2026 Thomas Ricouard. All rights reserved.
//

import XCTest

final class UITests: BaseUITestCase {
      
    func test_appLaunches() {

        XCTAssertTrue(app.exists)
        
        // Create a predicate to look for identifiers that start with "movies.movie."
        let predicate = NSPredicate(format: "identifier BEGINSWITH %@", AccessibilityIdentifiers.Movies.moviePrefix)
        
        // Apply predicate to all elements (or specifically .buttons if they have that trait)
        let movieElements = app.buttons.matching(predicate)
        
        // Interact
        let totalMovies = movieElements.count
        print("Found \(totalMovies) movies")
        
        movieElements.element(boundBy: 0).tap()
        
    }
    
    func test_openMovieFromHome() {
        
        app
            .on(HomeScreen.self)
            .waitForHomeFeedToLoad()
            .tapOnFirstMovie()
            .on(MovieDetailsScreen.self)
            .assertMovieDetailsAreDisplayed()
    }
    
    func test_homeFeedLoads() {

        app
           .on(HomeScreen.self)
           .waitForHomeFeedToLoad()
       }

    func test_openMovieDetailsFromSearchResults() {

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

        app
            .on(HomeScreen.self)
            .waitForHomeFeedToLoad()
            .goToDiscover()
            .assertDiscoverScreenIsDisplayed()
        
            .on(DiscoverScreen.self)
            .goToFanClub()
            .assertFanClubScreenIsDisplayed()
        
            .on(FanClubScreen.self)
            .goToMyLists()
            .assertMyListsScreenIsDisplayed()
        
            .on(MyListsScreen.self)
            .goToMovies()
            .assertHomeScreenIsDisplayed()
    }
    
}

