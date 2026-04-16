//
//  MovieSwiftUITests.swift
//  MovieSwiftUITests
//
//  Created by Juan David Alzate Restrepo on 15/04/26.
//  Copyright © 2026 Thomas Ricouard. All rights reserved.
//

import XCTest

final class UITests2: XCTestCase {
    
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
        
        let boton = app.buttons["movies.movie.1226863"]
        
        if boton.waitForExistence(timeout: 5) {
            boton.tap()
        } else {
            XCTFail("No se encontró el elemento con el identificador proporcionado.")
        }
        
    }
    
    func test_appLaunches2() {
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
    
    
}

