![Xcode build](https://github.com/Dimillian/MovieSwiftUI/workflows/Xcode%20build/badge.svg?branch=master)

# MovieSwiftUI

MovieSwiftUI is an application that uses the MovieDB API and is built with SwiftUI. 
It demos some SwiftUI (& Combine) concepts. The goal is to make a real world application using SwiftUI only. It'll be updated with new features as they come to the SwiftUI framework. 

I have written a series of articles that document the design and architecture of the app: [Making a Real World Application With SwiftUI](https://medium.com/better-programming/collection-making-a-real-world-application-with-swiftui-4f9bc8c7fb71).

![App Image](images/MovieSwiftUI_promo_new.png?)

## Architecture

MovieSwiftUI data flow is a subset and a custom implementation of the Flux part of [Redux](https://redux.js.org/). 
It implement the State in an [ObservableObject](https://developer.apple.com/documentation/combine/observableobject) as a @Published wrapped property, so changes are published whenever a dispatched action produces a new state after being reduced. 
The state is injected as an environment object in the root view of the application, and is easily accessible anywhere in the application. 
SwiftUI does all aspects of diffing on the render pass when your state changes. No need to be clever when extracting props from your State, they're simple dynamic vars at the view level. No matter your objects' graph size, SwiftUI speed depends on the complexity of your views hierarchy, not the complexity of your object graph.

## SwiftUI

MovieSwiftUI is in pure Swift UI, the goal is to see how far SwiftUI can go in its current implementation without using anything from UIKit (basically no UIView/UIViewController representable).

It'll evolve with SwiftUI, every time Apple edits existing or adds new features to the framework.

## Platforms

Currently MovieSwiftUI runs on iPhone, iPad, and macOS. 

Follow me on [Twitter](https://twitter.com/dimillian) to get the latest update about features, code and SwiftUI tips and tricks! 

## UI Test Framework

The `MovieSwiftUITests` target is organized into eight layers under `MovieSwift/MovieSwiftUITests/`:

| Layer | Contents |
|---|---|
| **Core** | `Screen` protocol, `BaseScreen`, `BaseUITestCase` — the foundation every screen object and test class inherits from |
| **Screens** | One class per app screen (`HomeScreen`, `MovieDetailsScreen`, etc.) using the Page Object Model; each exposes fluent navigation and assertion methods |
| **Components** | Reusable UI pieces that appear across screens (`TabBarComponent`) |
| **Interactions** | `XCUIElement` and `XCUIApplication` extensions for low-level actions: tapping, typing, keyboard dismissal, and screen navigation |
| **Assertions** | `XCUIElement` wait extensions (`waitUntilExists`, `waitUntilHittable`, `waitUntilNotExists`) that assert and return `Self` for chaining |
| **Data** | Reserved for test fixtures and mock responses (empty until network stubbing is introduced) |
| **Diagnostics** | `TestTrace` — wraps test steps in `XCTContext.runActivity` and attaches screenshots on failure |
| **Tests** | The actual `XCTestCase` subclasses containing test methods |

### Test configuration

Three files in `Core/` define how every test starts:

**`BaseUITestCase`** is the base class for all test classes. It owns the single `XCUIApplication` instance, sets `continueAfterFailure = false`, calls `launchApp()` automatically in `setUp`, and attaches a failure screenshot in `tearDown`. Test classes inherit from it — they never create or launch the app themselves.

**`TestConfiguration`** is the single source of truth for shared defaults: timeout values (`defaultTimeout`, `shortTimeout`, `longTimeout`) and the baseline `defaultLaunchArguments` and `defaultLaunchEnvironment` applied to every test run. Changing a timeout or adding a global launch flag requires editing one constant here, not hunting through every screen object or test file.

**`LaunchArgument`** is a namespace of static string constants for all recognized launch arguments. Using constants instead of raw strings means a typo is a compile error rather than a silent bug at runtime.

#### Launch arguments

| Constant | String passed | Purpose |
|---|---|---|
| `LaunchArgument.uiTesting` | `-ui-testing` | Signals the app is under test; skip onboarding, analytics, etc. |
| `LaunchArgument.disableAnimations` | `-disable-animations` | Makes all transitions instant, reducing animation-related flakiness |
| `LaunchArgument.resetState` | `-reset-state` | Clears persisted user data for a clean-slate test |
| `LaunchArgument.mockSuccess` | `-mock-success` | App returns happy-path mock API responses |
| `LaunchArgument.mockEmptyResults` | `-mock-empty-results` | App returns empty-list mock responses |
| `LaunchArgument.mockError` | `-mock-error` | App returns error mock responses |

#### Overriding defaults in a test

The default setup requires zero configuration. When a specific test needs different conditions, pass custom arguments to `launchApp`:

```swift
// All other tests — no setUp override needed, defaults apply automatically

// A test that needs error-state UI:
override func setUpWithError() throws {
    continueAfterFailure = false
    app = makeApplication()
    launchApp(arguments: [LaunchArgument.uiTesting, LaunchArgument.mockError])
}
```

This approach keeps test isolation explicit: the deviation is visible at the call site, and the default path stays zero-noise.
