Rick and Morty Character Browser 
This iOS application showcases a paginated list of characters from the Rick and Morty API, with filtering options and a detailed view for each character. The project demonstrates a mix of UIKit and SwiftUI, adhering to clean architecture principles with the use of MVVM, Combine, and the Coordinator pattern.

———————————————————————————————————————————————————————————————————————— 

 Features 
Screen 1: Character List
* Displays a list of Rick and Morty characters, paginated to load 20 characters at a time.
* Each character is presented with the following:
    * Name
    * Image
    * Species
* Filtering:
    * Users can filter characters by their status: Alive, Dead, or Unknown.
    * The filter is implemented using a horizontal UICollectionView.  
Screen 2: Character Details
* Displays detailed information about the selected character:
    * Name
    * Image
    * Species
    * Status
    * Gender
* Built entirely with SwiftUI for a clean and modern UI.

———————————————————————————————————————————————————————————————————————— 

Architecture 
Patterns
* MVVM:
    * ViewModel handles business logic and interacts with Use Cases.
    * Combine is used for reactive state management.
* Coordinator Pattern:
    * Handles navigation and ensures a clear separation between views and routing logic.
Technology Stack
* UIKit:
    * UITableView for the main character list.
    * UICollectionView for the filter section.
* SwiftUI:
    * Used for reusable table view cells and the detailed character view.
* Combine:
    * Provides a reactive data-binding mechanism between the ViewModel and Views.

———————————————————————————————————————————————————————————————————————— 

Project Highlights 
1. Dynamic Filtering:
    * A horizontal UICollectionView allows users to select a filter.
    * The filter state is managed in the CharacterListViewModel and updates the table view dynamically.
2. Pagination:
    * Fetches characters in batches of 20 from the Rick and Morty API.
    * Implements a seamless scrolling experience.
3. Mix of UIKit and SwiftUI:
    * UITableView and UICollectionView for high-performance rendering of the list and filter.
    * SwiftUI for table view cells and the detailed character view, demonstrating interoperability.
4. Code-Only UI:
    * All UI components are built programmatically for flexibility and maintainability.  

————————————————————————————————————————————————————————————————————————

Setup and Installation 
Prerequisites
* macOS 12.0 or later
* Xcode 14.0 or later
* Swift 5.6 or later

—————————————————————————————————————————————————————————————— 

 Assumptions and Decisions 
1. Mix of UIKit and SwiftUI:
    * UIKit was chosen for the main list and filter for its superior handling of large data sets and better scrolling performance.
    * SwiftUI was used for table view cells and detailed views for its declarative and modern approach.
2. Error Handling:
    * Errors during API calls are logged to the console. A future enhancement would involve showing a user-friendly error message.
3. No External Dependencies:
    * The app uses only native Swift and iOS frameworks to meet the test requirements.

——————————————————————————————————————————————————————————————

Challenges and Solutions
1. Interoperability Between UIKit and SwiftUI:
    * Leveraged UIHostingController to embed SwiftUI views within UITableView cells and view controllers.
2. Pagination Logic:
    * Ensured smooth pagination by keeping track of the current page and checking when the user scrolls to the bottom of the list.
3. State Management:
    * Managed state and updates with Combine to keep views responsive and consistent.

——————————————————————————————————————————————————————————————

Testing 
Unit Tests
* The project includes unit tests for the following:
    * Use Cases: Testing API integration and data transformation logic.
    * ViewModels: Testing state updates and filtering logic.
Future Improvements
* Add integration tests for UI interactions using XCTest.

—————————————————————————————————————————————————————————————— 

Acknowledgments 
* Rick and Morty API:
    * API Documentation

Feel free to adapt or expand this README.md to fit your exact project details!
