# BBQuotes

A SwiftUI iOS application that provides random quotes, characters, and episodes from Breaking Bad, Better Call Saul, and El Camino. The app fetches data from the Breaking Bad API in real-time and displays character information, episode details, and death records.

## Features

- **Multi-Show Support**: Browse quotes and episodes from three shows:
  - Breaking Bad
  - Better Call Saul
  - El Camino

- **Random Quote Generator**: Get random quotes from your favorite show with a single tap

- **Character Details**: View comprehensive information about characters including:
  - Character images
  - Occupations
  - Aliases
  - Birthday
  - Status (alive/deceased)
  - Actor/actress name
  - Death details (when available)

- **Episode Information**: Fetch random episodes with:
  - Episode title
  - Season and episode number
  - Air date
  - Episode description

- **Dark Mode UI**: Beautiful dark-themed interface optimized for readability

- **Real-time API Integration**: Fetches live data from the Breaking Bad API

## Tech Stack

- **Language**: Swift
- **Framework**: SwiftUI
- **Architecture**: MVVM (Model-View-ViewModel)
- **Concurrency**: Swift Async/Await
- **Networking**: URLSession
- **API**: [Breaking Bad API](https://breaking-bad-api-six.vercel.app/api)

## Project Structure

```
BBQuotes/
├── BBQuotesApp.swift              # App entry point
├── Constants.swift                 # Static constants for show names and UI text
├── StringExtension.swift           # String utility extensions
├── Assets.xcassets/               # Images and color sets
│   ├── Colors (theme colors for each show)
│   ├── Images (show artwork)
│   └── AppIcon
├── Components/
│   └── ProgressBarView.swift      # Custom progress indicator view
├── Model/
│   ├── Quote.swift                # Quote data model
│   ├── MovieCharacter.swift       # Character data model
│   ├── Episode.swift              # Episode data model
│   └── Death.swift                # Character death data model
├── Services/
│   └── FetchServices.swift        # Network service layer for API calls
├── ViewModel/
│   └── ViewModel.swift            # Main view model with data management
├── Screen/
│   ├── ContentView.swift          # Root tab view (tab navigation)
│   ├── FetchView.swift            # Main content view with fetch logic
│   ├── CharacterView.swift        # Character details display
│   └── EpisodeView.swift          # Episode details display
├── SampleData/                    # JSON sample data for previews
│   ├── samplequote.json
│   ├── samplecharacter.json
│   ├── sampleepisode.json
│   └── sampledeath.json
└── README.md                      # Project documentation
```

## Data Models

### Quote
- `quote: String` - The quote text
- `character: String` - Character who said the quote

### MovieCharacter
- `name: String` - Character name
- `birthday: String` - Character's birthday
- `occupations: [String]` - Character's occupations
- `images: [URL]` - Character images
- `aliases: [String]` - Alternative names
- `status: String` - Alive or deceased
- `portrayedBy: String` - Actor name
- `death: Death?` - Death details (optional)

### Episode
- Episode title, season, episode number, air date, and description

### Death
- Character death information including how and where they died

## Key Features in Code

### FetchServices
Handles all API communication:
- `fetchQuote(from:)` - Retrieves random quote from specified show
- `fetchCharacter(_:)` - Gets detailed character information
- `fetchDeath(for:)` - Retrieves death details for a character
- `fetchEpisode(from:)` - Gets random episode from specified show

### ViewModel
Manages app state with:
- `FetchStatus` enum for tracking loading states
- Data persistence with sample JSON files
- Async data fetching with proper error handling
- Character and quote caching

### UI Components
- **ContentView**: Tab-based navigation between three shows
- **FetchView**: Main content view with quote/episode fetching
- **CharacterView**: Detailed character information display
- **EpisodeView**: Episode details presentation
- **ProgressBarView**: Custom loading indicator

## Getting Started

### Requirements
- iOS 17.0+
- Xcode 16.0+
- Swift 5.10+

### Installation

1. Clone the repository:
```bash
git clone https://github.com/infinityvaibhav/BBQuotes.git
```

2. Open the project in Xcode:
```bash
cd BBQuotes
open BBQuotes.xcodeproj
```

3. Build and run the app on your preferred simulator or device

## Usage

1. **Launch the app** - The app opens with Breaking Bad tab selected
2. **Get a Quote** - Tap "Get random quote" button to fetch a random quote
3. **View Character Details** - After getting a quote, character information automatically loads
4. **Switch Shows** - Use the tab bar to switch between Breaking Bad, Better Call Saul, and El Camino
5. **Get Episodes** - Tap "Get random Episode" to fetch episode information

## Future Enhancements

- El Camino tab support with full feature parity
- Utilize all character images on CharacterView
- Auto-scroll to bottom in CharacterView after character loads
- Extended string formatting utilities
- Character search and filtering
- Favorites system
- Offline caching

## API Reference

This app uses the [Breaking Bad API](https://breaking-bad-api-six.vercel.app/api):

**Base URL**: `https://breaking-bad-api-six.vercel.app/api`

### Endpoints Used
- `/quotes/random?production={show}` - Random quote from a show
- `/characters?name={character}` - Character details
- `/deaths` - All character deaths
- `/episodes` - Episode information

## Error Handling

The app includes comprehensive error handling:
- Network request failures are caught and displayed
- Bad HTTP responses trigger `FetchError.badResponse`
- JSON decoding errors are handled gracefully
- Sample data is used for preview and initial state

## Code Highlights

### Async/Await Pattern
```swift
func getQuoteData(for show: String) async {
    status = .fetching
    do {
        quote = try await fetchService.fetchQuote(from: show)
        character = try await fetchService.fetchCharacter(quote.character)
        status = .successQuote
    } catch {
        status = .failed(error: error)
    }
}
```

### Observable ViewModel
The app uses Swift 6's `@Observable` macro for reactive state management without external dependencies.

### JSON Decoding Strategy
Custom key decoding strategy handles snake_case API responses:
```swift
let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase
```

## Contributing

Feel free to fork this project and submit pull requests with improvements.

## License

This project is available under the MIT License.

## Acknowledgments

- Built with SwiftUI and Swift Async/Await
- Data sourced from [Breaking Bad API](https://breaking-bad-api-six.vercel.app/api)
- Created by Vaibhav Upadhyay

## Contact

For questions or feedback, please reach out through GitHub issues.

---

**Version**: 2.0
**Last Updated**: December 2025
