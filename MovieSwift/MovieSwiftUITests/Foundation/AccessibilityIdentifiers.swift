enum AccessibilityIdentifiers {
    
    private static var enableLabelIdentifiers: Bool { false }
        
    enum Tab {
        
        static var movies: String {
            enableLabelIdentifiers ? "Movies" : "tab.movies"
        }
        static var discover: String {
            enableLabelIdentifiers ? "Discover" : "tab.discover"
        }
        static var fanClub: String {
            enableLabelIdentifiers ? "Fan Club" : "tab.fanClub"
        }
        static var myLists: String {
            enableLabelIdentifiers ? "My Lists" : "tab.myLists"
        }
    }
    
    enum MovieDetail {
        static let screen    = "movieDetail.screen"
        static let overview  = "movieDetail.overview"
        static let addButton = "movieDetail.addButton"
    }
    enum Discover {
        static let screen = "discover.screen"
    }
    enum FanClub {
        static let screen       = "fanClub.screen"
        static let peoplePrefix = "fanClub.people"
    }
    enum Home {
        static let sectionPrefix = "home.section."
        static let moviePrefix   = "home.movie."
        static func section(_ id: String) -> String { "\(sectionPrefix)\(id)" }
    }
    enum Movies {
        static let searchField = "movies.searchField"
        static let moviePrefix = "movies.movie."
    }
    enum MyLists {
        static let createList = "myLists.createList"
        static let customList = "myLists.customList"
    }
}
