# Project Instructions for AI Coding Agents

**Last updated:** 2025-12-23

<!-- {mission} -->

## Mission Statement

**Bonjour Browser** is a native macOS application for discovering and browsing network services using the Bonjour/mDNS protocol. Built with Swift and Apple's modern Network framework, it provides automatic service discovery with real-time updates, comprehensive protocol support (TCP/UDP), and detailed service information including addresses, ports, and TXT record metadata. The application uses a clean MVC architecture with intuitive hierarchical service organization and live filtering capabilities.

## Technology Stack

- **Language:** Swift 5.0+
- **Platform:** macOS 15.2+
- **Framework:** AppKit, Network framework (NWBrowser API)
- **IDE:** Cursor with Sweetpad extension (or Xcode 16.0+)
- **Build System:** xcodebuild via Sweetpad
- **Version Control:** Git
- **License:** MIT

<!-- {principles} -->

## Primary Instructions

- Avoid making assumptions. If you need additional context to accurately answer the user, ask the user for the missing information. Be specific about which context you need.
- Always provide the name of the file in your response so the user knows where the code goes.
- Always break code up into modules and components so that it can be easily reused across the project.
- All code you write MUST be fully optimized. ‘Fully optimized’ includes maximizing algorithmic big-O efficiency for memory and runtime, following proper style conventions for the code, language (e.g. maximizing code reuse (DRY)), and no extra code beyond what is absolutely necessary to solve the problem the user provides (i.e. no technical debt). If the code is not fully optimized, you will be fined $100.

### Working Together

This file (`AGENTS.md`) is the primary instructions file for AI coding assistants working on this project. Agent-specific instruction files (such as `.github/copilot-instructions.md`, `CLAUDE.md`) reference this document, maintaining a single source of truth.

When initializing a session or analyzing the workspace, refer to instruction files in this order:

1. `AGENTS.md` (this file - primary instructions and single source of truth)
2. Agent-specific reference file (if present - points back to AGENTS.md)

### Update Protocol (CRITICAL)

**PROACTIVELY update this file (`AGENTS.md`) as we work together.** Whenever you make a decision, choose a technology, establish a convention, or define a standard, you MUST update AGENTS.md immediately in the same response.

**Update ONLY this file (`AGENTS.md`)** when coding standards, conventions, or project decisions evolve. Do not modify agent-specific reference files unless the reference mechanism itself needs changes.

**When to update** (do this automatically, without being asked):

- Technology choices (build tools, languages, frameworks)
- Directory structure decisions
- Coding conventions and style guidelines
- Architecture decisions
- Naming conventions
- Build/test/deployment procedures

**How to update AGENTS.md:**

- Maintain the "Last updated" timestamp at the top
- Add content to the relevant section (Project Overview, Coding Standards, etc.)
- Add entries to the "Recent Updates & Decisions" log at the bottom with:
  - Date (with time if multiple updates per day)
  - Brief description
  - Reasoning for the change
- Preserve this structure: title header → timestamp → main instructions → "Recent Updates & Decisions" section

## Best Practices

### When Updating This Repository

1. **Maintain Consistency**: Keep code style consistent across the codebase
2. **Test First**: Write tests before implementing features when applicable
3. **Document Changes**: Update documentation when changing functionality
4. **Code Review**: [Describe your code review process]
5. **Date Changes**: Update the "Last updated" timestamp in this file when making changes
6. **Log Updates**: Add entries to "Recent Updates & Decisions" section below

### Development Guidelines

**Architecture:**
- Follow MVC pattern with clear separation of concerns
- Use delegation pattern for network events and UI updates
- Implement proper memory management with weak references to avoid retain cycles

**Key Components:**
- `BonjourBrowser` - Main service discovery engine using Network framework
- `ViewController` - Primary UI controller managing outline view and search
- `ServiceNode` - Hierarchical data model for services
- `ServiceTypeBrowser` - Discovers available service types
- `ServiceResolutionDelegate` - Handles service resolution
- `TXTRecordDelegate` - Manages TXT record metadata

**Best Practices:**
- Use modern Network framework (NWBrowser) instead of legacy NSNetService APIs
- Ensure real-time UI updates using closures and callbacks
- Implement efficient filtering for handling hundreds of services
- Document all public APIs with DocC-style comments

### Security & Safety

- Never include API keys, tokens, or credentials in code
- Always require explicit human confirmation before commits
- Maintain conventional commit message standards
- Keep change history transparent through commit messages
- [Add project-specific security guidelines]

### Testing

**Testing Approach:**
- Manual testing with real network services on local network
- Test with various service types (HTTP, SSH, AirPlay, printers, etc.)
- Verify service discovery, resolution, and real-time updates
- Test filtering and search functionality with large service counts

**Testing Scenarios:**
- Services appearing and disappearing dynamically
- Multiple services of same type
- Services with complex TXT records
- Network connectivity changes
- Performance with hundreds of discovered services

### Documentation

**Code Documentation:**
- Use DocC-style triple-slash (`///`) comments for all public APIs
- Include parameter descriptions and return value documentation
- Add MARK comments to organize code sections logically
- Explain complex network operations and memory management decisions

**Project Documentation:**
- README.md - User-facing documentation with features, usage, and architecture
- Code comments - Explain "why" not "what" for non-obvious implementations
- Update README when adding new features or changing UI/UX
- Document any network protocol specifics or Bonjour/mDNS edge cases

<!-- {languages} -->

# Swift Coding Conventions for DoomKit

*Last updated: November 16, 2025*

This document establishes comprehensive coding standards and style guidelines for the DoomKit Swift Package. These conventions ensure consistency, maintainability, and adherence to Swift best practices across the entire codebase.

---

## Table of Contents

1. [File Organization](#file-organization)
2. [Naming Conventions](#naming-conventions)
3. [Code Structure](#code-structure)
4. [Access Control](#access-control)
5. [Type Declarations](#type-declarations)
6. [Property Declarations](#property-declarations)
7. [Function Declarations](#function-declarations)
8. [Control Flow](#control-flow)
9. [Error Handling](#error-handling)
10. [Concurrency & Async/Await](#concurrency--asyncawait)
11. [Protocols & Extensions](#protocols--extensions)
12. [Generics](#generics)
13. [Comments & Documentation](#comments--documentation)
14. [Formatting & Whitespace](#formatting--whitespace)
15. [Swift-Specific Patterns](#swift-specific-patterns)
16. [Package-Specific Conventions](#package-specific-conventions)

---

## File Organization

### Import Statements

```swift
// CORRECT: Organize imports alphabetically, Foundation first if needed
import Foundation
import CoreLocation
import MapKit
import WeatherKit

// INCORRECT: Random order
import WeatherKit
import Foundation
import CoreLocation
```

### File Structure Order

1. Import statements
2. Type declarations (class, struct, enum, protocol)
3. Properties (in order: static, instance)
4. Initializers
5. Lifecycle methods
6. Public methods
7. Internal methods
8. Private methods
9. Nested types (if applicable)

### Single Responsibility

- **One primary type per file** (exceptions for small, tightly-coupled helper types)
- File name must match the primary type name: `ProcessManager.swift` contains `ProcessManager` class
- Place closely related types in the same file only when they form a cohesive unit

---

## Naming Conventions

### General Rules

- Use clear, descriptive names that convey intent
- Prefer full words over abbreviations
- Use American English spelling

### Types (Classes, Structs, Enums, Protocols)

```swift
// CORRECT: PascalCase for types
public class ProcessManager { }
public struct Location { }
public enum ProcessQuality { }
public protocol ProcessController { }

// INCORRECT
public class processManager { }  // Wrong case
public struct location { }       // Wrong case
```

### Properties & Variables

```swift
// CORRECT: camelCase for properties and variables
let locationManager = LocationManager()
var subscriptions: [ProcessSubscription] = []
private let updateInterval: TimeInterval = 60

// INCORRECT
let LocationManager = LocationManager()  // Wrong case
var Subscriptions: [ProcessSubscription] = []  // Wrong case
```

### Functions & Methods

```swift
// CORRECT: camelCase, descriptive action verbs
func refreshData(for location: Location) async throws -> ProcessSensor?
func updateLocation(location: Location) -> Void
private func significantLocationChange(previous: Location?, current: Location) -> Bool

// INCORRECT
func RefreshData() { }  // Wrong case
func upd() { }  // Too abbreviated
func location_update() { }  // Snake case
```

### Constants

```swift
// CORRECT: Use static let for type-level constants
public class LocationManager {
    public static let houseOfWorldCultures = Location(latitude: 52.51889, longitude: 13.36528)
}

// CORRECT: camelCase for constant properties
private let updateInterval: TimeInterval = 60
```

### Enums

```swift
// CORRECT: PascalCase for enum name, camelCase for cases
public enum ProcessQuality {
    case good
    case uncertain
    case bad
    case unknown
}

// CORRECT: Associated value enums
public enum ProcessSelector: Hashable {
    case weather(Weather)
    case forecast(Forecast)
    case covid(Covid)
}
```

### Protocols

```swift
// CORRECT: Use descriptive protocol names
public protocol ProcessController { }
public protocol LocationManagerDelegate: Identifiable where ID == UUID { }

// CORRECT: Protocol names ending in -able, -ible indicate capability
protocol Sendable { }  // Standard library example
```

---

## Code Structure

### Braces

```swift
// CORRECT: Opening brace on same line, closing brace on new line
public class ProcessManager {
    func updateSubscriptions() {
        for subscription in subscriptions {
            subscription.update(timeout: updateInterval)
        }
    }
}

// INCORRECT
public class ProcessManager
{  // Opening brace on new line
    func updateSubscriptions()
    {
        for subscription in subscriptions {
            subscription.update(timeout: updateInterval) }  // Closing brace on same line
    }
}
```

### Indentation

- Use **4 spaces** for indentation (no tabs)
- Align continuation lines with the opening delimiter

```swift
// CORRECT: 4-space indentation
public init(
    name: String, location: Location, placemark: String?, customData: [String: Any]?,
    measurements: [ProcessSelector: [ProcessValue<Dimension>]], timestamp: Date?
) {
    self.name = name
    self.location = location
    self.placemark = placemark
    self.customData = customData
    self.measurements = measurements
    self.timestamp = timestamp
}
```

### Line Length

- Target maximum: **120 characters** per line
- Break long lines at logical points (parameters, operators, closures)

```swift
// CORRECT: Break long function signatures
public func dataWithRetry(
    from url: URL, retryCount: Int = 3, retryInterval: TimeInterval = 1.0,
    delegate: (any URLSessionTaskDelegate)? = nil
) async throws -> (Data, URLResponse) {
    // Implementation
}
```

---

## Access Control

### Access Levels (Most to Least Restrictive)

1. `private` - Only visible within the current declaration
2. `fileprivate` - Visible within the same source file
3. `internal` - Visible within the module (default)
4. `public` - Visible to consumers of the module
5. `open` - Visible and subclassable outside the module

### Package Guidelines

```swift
// CORRECT: Explicit public for exported API
public class ProcessManager: Identifiable, LocationManagerDelegate {
    public let id = UUID()
    public static let shared = ProcessManager()

    private let locationManager = LocationManager()  // Internal implementation
    private var location: Location?  // Private state

    public func refreshSubscriptions() {  // Public API
        // Implementation
    }

    private func updateSubscriptions() {  // Private helper
        // Implementation
    }
}
```

### Rules

- **Always explicit**: Mark APIs as `public` explicitly; avoid relying on default `internal`
- **Minimize exposure**: Only expose what consumers need
- **Private by default**: Start with `private`, increase visibility as needed
- **No `open` classes**: Package doesn't require subclassing from consumers

---

## Type Declarations

### Classes

```swift
// CORRECT: Class with protocol conformance
public class ProcessManager: Identifiable, LocationManagerDelegate {
    public let id = UUID()
    public static let shared = ProcessManager()

    private init() {
        // Singleton pattern
    }
}

// CORRECT: Subclass with inheritance
public class WeatherController: ProcessController {
    public func refreshData(for location: Location) async throws -> ProcessSensor? {
        // Implementation
    }
}
```

### Structs

```swift
// CORRECT: Simple value type
public struct Location: Equatable, Hashable {
    public let latitude: Double
    public let longitude: Double

    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

// CORRECT: Generic struct with computed properties
public struct ProcessValue<T: Dimension>: Identifiable {
    public let id = UUID()
    public let value: Measurement<T>
    public let quality: ProcessQuality
    public let timestamp: Date
}
```

### Enums

```swift
// CORRECT: Simple enum
public enum ProcessQuality {
    case good
    case uncertain
    case bad
    case unknown
}

// CORRECT: Enum with raw values
public enum Weather: Int, CaseIterable {
    case temperature = 0
    case apparentTemperature = 1
    case dewPoint = 2
}

// CORRECT: Enum with associated values
public enum ProcessSelector: Hashable {
    case weather(Weather)
    case forecast(Forecast)
    case covid(Covid)
}
```

### Protocols

```swift
// CORRECT: Protocol with associated type constraints
public protocol LocationManagerDelegate: Identifiable where ID == UUID {
    func locationManager(didUpdateLocation location: Location) -> Void
}

// CORRECT: Simple protocol
public protocol ProcessController {
    func refreshData(for location: Location) async throws -> ProcessSensor?
}
```

---

## Property Declarations

### Stored Properties

```swift
// CORRECT: Property declarations with explicit types
public class ProcessManager {
    public let id = UUID()  // Type inferred from initializer
    private let locationManager = LocationManager()
    private var location: Location?  // Optional type explicit
    private let updateInterval: TimeInterval = 60  // Explicit type
    private var subscriptions: [ProcessSubscription] = []  // Explicit initialization
}
```

### Computed Properties

```swift
// CORRECT: Computed property
public struct Location {
    public let latitude: Double
    public let longitude: Double

    public var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}

// CORRECT: Read-only computed property (implicit get)
var isReady: Bool {
    return location != nil && subscriptions.isEmpty == false
}
```

### Property Observers

```swift
// CORRECT: willSet and didSet
var location: Location? {
    willSet {
        print("About to set location to \(newValue)")
    }
    didSet {
        if location != oldValue {
            refreshSubscriptions()
        }
    }
}
```

### Lazy Properties

```swift
// CORRECT: Lazy initialization for expensive resources
lazy var dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    return formatter
}()
```

---

## Function Declarations

### Basic Structure

```swift
// CORRECT: Function signature formatting
public func refreshData(for location: Location) async throws -> ProcessSensor? {
    var measurements: [ProcessSelector: [ProcessValue<Dimension>]] = [:]
    // Implementation
    return ProcessSensor(name: "", location: location, measurements: measurements, timestamp: Date.now)
}
```

### Parameter Labels

```swift
// CORRECT: Descriptive external labels
func updateLocation(location: Location) -> Void { }
func add(subscriber: any ProcessSubscriber, timeout: TimeInterval) { }

// CORRECT: Omit external label with underscore when appropriate
func process(_ data: Data) -> Result { }

// INCORRECT: Redundant labels
func updateLocation(location location: Location) -> Void { }  // Redundant
```

### Default Parameters

```swift
// CORRECT: Default parameters at end
public func dataWithRetry(
    from url: URL,
    retryCount: Int = 3,
    retryInterval: TimeInterval = 1.0,
    delegate: (any URLSessionTaskDelegate)? = nil
) async throws -> (Data, URLResponse) {
    // Implementation
}
```

### Multiple Initializers

```swift
// CORRECT: Convenience initializers calling designated initializers
public struct ProcessValue<T: Dimension> {
    // Designated initializer (most comprehensive)
    public init(value: Measurement<T>, customData: [String: Any]?, quality: ProcessQuality, timestamp: Date) {
        self.value = value
        self.customData = customData
        self.quality = quality
        self.timestamp = timestamp
    }

    // Convenience initializers
    public init(value: Measurement<T>, quality: ProcessQuality, timestamp: Date) {
        self.init(value: value, customData: nil, quality: quality, timestamp: timestamp)
    }

    public init(value: Measurement<T>, quality: ProcessQuality) {
        self.init(value: value, quality: quality, timestamp: Date.now)
    }

    public init(value: Measurement<T>) {
        self.init(value: value, quality: .unknown)
    }
}
```

### Return Type Void

```swift
// CORRECT: Explicit Void return type
public func updateLocation(location: Location) -> Void {
    // Implementation
}

// ALSO CORRECT: Omit return type for Void
public func updateLocation(location: Location) {
    // Implementation
}
```

---

## Control Flow

### If Statements

```swift
// CORRECT: Standard if statement
if location != nil {
    refreshSubscriptions()
}

// CORRECT: If-let for optional binding
if let location = self.location {
    delegate.locationManager(didUpdateLocation: location)
}

// CORRECT: Guard for early return
guard let location = self.location else {
    return
}

// CORRECT: Multiple conditions
if needsUpdate == true {
    self.location = location
    if let delegate = self.delegate {
        delegate.locationManager(didUpdateLocation: location)
    }
}
```

### Guard Statements

```swift
// CORRECT: Guard for preconditions and early exits
guard ReachabilityManager.shared.isConnected else {
    throw URLError(.notConnectedToInternet)
}

guard let url = URL(string: "https://api.example.com/data") else {
    return nil
}

// CORRECT: Multiple guard conditions
guard let data = data,
      let response = response as? HTTPURLResponse,
      (200...299).contains(response.statusCode) else {
    throw NetworkError.invalidResponse
}
```

### For Loops

```swift
// CORRECT: For-in loops
for subscription in subscriptions {
    subscription.update(timeout: updateInterval)
}

// CORRECT: Enumeration with index
for (index, item) in items.enumerated() {
    print("\(index): \(item)")
}

// CORRECT: Filtering in loop
for subscription in subscriptions where subscription.isPending() {
    subscription.reset()
}
```

### Switch Statements

```swift
// CORRECT: Exhaustive switch on enum
switch quality {
    case .good:
        return "✓"
    case .uncertain:
        return "~"
    case .bad:
        return "✗"
    case .unknown:
        return "?"
}

// CORRECT: Switch with multiple cases
switch connectionType {
    case .wifi, .ethernet:
        return true
    case .cellular:
        return false
    case .unknown:
        return false
}
```

### Ternary Operator

```swift
// CORRECT: Simple conditions
let result = condition ? trueValue : falseValue

// AVOID: Nested ternary (use if-else instead)
let result = condition1 ? value1 : (condition2 ? value2 : value3)  // Hard to read
```

---

## Error Handling

### Error Definitions

```swift
// CORRECT: Custom error enum
enum NetworkError: Error {
    case invalidResponse
    case serverError(statusCode: Int)
    case noData
}
```

### Throwing Functions

```swift
// CORRECT: Function that can throw
public func refreshData(for location: Location) async throws -> ProcessSensor? {
    let weather = try await WeatherService.shared.weather(for: clLocation)
    // Process weather data
    return sensor
}
```

### Try-Catch Blocks

```swift
// CORRECT: Standard try-catch
do {
    let (data, response) = try await self.data(from: url, delegate: delegate)
    return (data, response)
} catch {
    lastError = error
    if attempt < retryCount - 1 {
        try await Task.sleep(nanoseconds: UInt64(retryInterval * 1_000_000_000))
        continue
    }
}

// CORRECT: Specific error catching
do {
    let result = try riskyOperation()
    return result
} catch NetworkError.invalidResponse {
    print("Invalid response")
    return nil
} catch {
    print("Unknown error: \(error)")
    return nil
}
```

### Optional Try

```swift
// CORRECT: try? for optional result
if let placemark = try? await geocoder.reverseGeocodeLocation(location).first {
    // Use placemark
}

// CORRECT: try! only when failure is impossible
let config = try! Configuration.load()  // Only if guaranteed to succeed
```

---

## Concurrency & Async/Await

### Async Functions

```swift
// CORRECT: Async function declaration
public func refreshData(for location: Location) async throws -> ProcessSensor? {
    let weather = try await WeatherService.shared.weather(for: clLocation)
    let placemark = await LocationManager.reverseGeocodeLocation(location: location)
    return ProcessSensor(/* ... */)
}
```

### Task Creation

```swift
// CORRECT: Create task for async work
Task {
    await delegate.refreshData(location: location)
}

// CORRECT: Task with error handling
Task {
    do {
        let result = try await fetchData()
        process(result)
    } catch {
        print("Error: \(error)")
    }
}
```

### Actor Usage

```swift
// CORRECT: Actor for thread-safe state management
actor NetworkManager {
    private var isConnected = true

    func updateConnectionStatus(_ status: Bool) {
        self.isConnected = status
    }

    func checkConnection() -> Bool {
        return isConnected
    }
}
```

### Sendable Conformance

```swift
// CORRECT: @unchecked Sendable for custom Dimension types
public class UnitRadiation: Dimension, @unchecked Sendable {
    public static let sieverts = UnitRadiation(
        symbol: "Sv/h",
        converter: UnitConverterLinear(coefficient: 1.0)
    )
}
```

### Async Sequences

```swift
// CORRECT: Iterating async sequence
for await value in asyncSequence {
    process(value)
}
```

---

## Protocols & Extensions

### Protocol Declarations

```swift
// CORRECT: Protocol with requirements
public protocol ProcessController {
    func refreshData(for location: Location) async throws -> ProcessSensor?
}

// CORRECT: Protocol with associated type constraints
public protocol LocationManagerDelegate: Identifiable where ID == UUID {
    func locationManager(didUpdateLocation location: Location) -> Void
}
```

### Protocol Conformance

```swift
// CORRECT: Conformance in type definition
public class ProcessManager: Identifiable, LocationManagerDelegate {
    // Implementation
}

// CORRECT: Conformance in extension (when appropriate)
extension ProcessManager: CustomStringConvertible {
    public var description: String {
        return "ProcessManager with \(subscriptions.count) subscriptions"
    }
}
```

### Extensions

```swift
// CORRECT: Extension to add functionality
extension URLSession {
    public func dataWithRetry(
        from url: URL, retryCount: Int = 3, retryInterval: TimeInterval = 1.0
    ) async throws -> (Data, URLResponse) {
        // Implementation
    }
}

// CORRECT: Extension for protocol conformance
extension Location: Equatable, Hashable {
    // Compiler synthesizes conformance for structs with Equatable/Hashable properties
}
```

### Extension Organization

```swift
// CORRECT: Organize extensions by purpose
// File: ProcessManager.swift

public class ProcessManager {
    // Core implementation
}

// MARK: - LocationManagerDelegate
extension ProcessManager: LocationManagerDelegate {
    public func locationManager(didUpdateLocation location: Location) {
        // Implementation
    }
}

// MARK: - Subscription Management
extension ProcessManager {
    public func add(subscriber: any ProcessSubscriber, timeout: TimeInterval) {
        // Implementation
    }
}
```

---

## Generics

### Generic Types

```swift
// CORRECT: Generic struct with type constraints
public struct ProcessValue<T: Dimension>: Identifiable {
    public let id = UUID()
    public let value: Measurement<T>
    public let quality: ProcessQuality
}
```

### Generic Functions

```swift
// CORRECT: Generic function with constraints
func measure<T: Dimension>(_ value: Double, unit: T) -> Measurement<T> {
    return Measurement(value: value, unit: unit)
}
```

### Associated Types

```swift
// CORRECT: Protocol with associated type
protocol Container {
    associatedtype Item
    var items: [Item] { get set }
    mutating func add(_ item: Item)
}
```

### Type Erasure

```swift
// CORRECT: Using 'any' for existential types
private var subscribers: [UUID: any ProcessSubscriber] = [:]

public func add(subscriber: any ProcessSubscriber, timeout: TimeInterval) {
    subscribers[subscriber.id] = subscriber
}
```

---

## Comments & Documentation

### Single-Line Comments

```swift
// CORRECT: Comment explains why, not what
// Check if device is connected before attempting network request
guard ReachabilityManager.shared.isConnected else {
    throw URLError(.notConnectedToInternet)
}

// INCORRECT: States the obvious
// Set location to new location
self.location = location
```

### Multi-Line Comments

```swift
// CORRECT: Use single-line style for multi-line comments
// This function performs exponential backoff retry logic
// for network requests. It checks connectivity before each
// attempt and throws immediately if connection is lost.
```

### Documentation Comments

```swift
// CORRECT: DocC-style documentation
/// A simple and fast logging facility with support for different log levels and detailed timestamps.
public class Trace {
    /// Represents different log levels
    public enum Level: String {
        case debug = "DEBUG"
        case info = "INFO"
    }

    /// Creates a new Logger instance
    /// - Parameters:
    ///   - minimumLevel: Minimum level of logs to display
    ///   - showColors: Whether to use ANSI colors in console output
    ///   - dateFormat: Format string for timestamps (default: "yyyy-MM-dd HH:mm:ss.SSS")
    ///   - logFile: Path to file for writing logs (optional)
    public init(
        minimumLevel: Level = .debug,
        showColors: Bool = true,
        dateFormat: String = "yyyy-MM-dd HH:mm:ss.SSS",
        logFile: String? = nil
    ) {
        // Implementation
    }
}
```

### MARK Comments

```swift
// CORRECT: Use MARK to organize code sections
public class WeatherController {
    // MARK: - Properties
    private let service = WeatherService.shared

    // MARK: - Initialization
    public init() { }

    // MARK: - Public Methods
    public func refreshData(for location: Location) async throws -> ProcessSensor? {
        // Implementation
    }

    // MARK: - Private Helpers
    private func processWeatherData(_ data: WeatherData) -> ProcessSensor {
        // Implementation
    }
}
```

### TODO/FIXME Comments

```swift
// TODO: Implement caching mechanism for weather data
// FIXME: Handle edge case when location is exactly on boundary
// NOTE: This assumes the API always returns valid data
```

---

## Formatting & Whitespace

### Blank Lines

```swift
// CORRECT: Blank line between logical sections
public class ProcessManager {
    public let id = UUID()
    public static let shared = ProcessManager()

    private let locationManager = LocationManager()
    private var location: Location?

    private init() {
        self.locationManager.delegate = self
    }

    public func refreshSubscriptions() {
        // Implementation
    }
}
```

### Spacing

```swift
// CORRECT: Space after comma, around operators
let values = [1, 2, 3, 4]
let sum = a + b
let range = 0.0 ... 100.0

// CORRECT: No space around range operators
for i in 0..<count { }
let range = 0...10

// CORRECT: No space before colon, space after
var measurements: [ProcessSelector: [ProcessValue<Dimension>]] = [:]
func add(subscriber: any ProcessSubscriber, timeout: TimeInterval) { }

// INCORRECT
let values=[1,2,3,4]  // Missing spaces
let sum=a+b  // Missing spaces
var dict : [String : Int]  // Spaces before colons
```

### Trailing Whitespace

```swift
// AVOID: Trailing whitespace at end of lines
func process() {
    let value = 10___
}  // Remove trailing spaces

// CORRECT: No trailing whitespace
func process() {
    let value = 10
}
```

### Empty Lines at File End

```swift
// CORRECT: Single empty line at end of file
public class ProcessManager {
    // Implementation
}

// ← One blank line here, then EOF
```

---

## Swift-Specific Patterns

### Optionals

```swift
// CORRECT: Optional binding with if-let
if let location = self.location {
    process(location)
}

// CORRECT: Optional binding with guard
guard let location = self.location else {
    return
}

// CORRECT: Optional chaining
let count = subscribers[id]?.subscriptions.count

// CORRECT: Nil coalescing
let value = optionalValue ?? defaultValue

// AVOID: Force unwrapping (use only when absolutely certain)
let value = optionalValue!  // Only if guaranteed non-nil
```

### Type Inference

```swift
// CORRECT: Let Swift infer obvious types
let manager = ProcessManager.shared
let id = UUID()
let values = [1, 2, 3]

// CORRECT: Explicit types for clarity
let timeout: TimeInterval = 60
let measurements: [ProcessSelector: [ProcessValue<Dimension>]] = [:]

// AVOID: Redundant type annotations
let manager: ProcessManager = ProcessManager.shared  // Type obvious
```

### Closures

```swift
// CORRECT: Trailing closure syntax
Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: true) { _ in
    self.updateSubscriptions()
}

// CORRECT: Explicit closure parameters
items.map { item in
    return item.value * 2
}

// CORRECT: Shorthand when simple
items.map { $0.value * 2 }

// CORRECT: Multiple trailing closures (Swift 5.3+)
UIView.animate(withDuration: 0.3) {
    view.alpha = 0
} completion: { _ in
    view.removeFromSuperview()
}
```

### Collections

```swift
// CORRECT: Array initialization
var subscriptions: [ProcessSubscription] = []
let values = [1, 2, 3, 4, 5]

// CORRECT: Dictionary initialization
var measurements: [ProcessSelector: [ProcessValue<Dimension>]] = [:]
let dict = ["key": "value"]

// CORRECT: Set initialization
let uniqueIds: Set<UUID> = []
```

### Lazy Evaluation

```swift
// CORRECT: Lazy sequences for performance
let largeArray = (0..<1_000_000)
let evenNumbers = largeArray.lazy.filter { $0 % 2 == 0 }
```

### Property Wrappers

```swift
// CORRECT: Custom property wrapper usage
@Published var measurements: [ProcessValue<Dimension>] = []

// CORRECT: UserDefaults property wrapper
@AppStorage("refreshInterval") var refreshInterval: TimeInterval = 60
```

---

## Package-Specific Conventions

### Public API Patterns

```swift
// CORRECT: Controller pattern
public class WeatherController: ProcessController {
    public func refreshData(for location: Location) async throws -> ProcessSensor? {
        // Fetch data from service
        // Process into ProcessSensor
        // Return structured data
    }
}

// CORRECT: Service pattern (stateless)
public class CovidService {
    static func fetchDistricts(for location: Location, radius: Double) async throws -> Data? {
        // Perform HTTP request
        // Return raw data
    }
}

// CORRECT: Transformer pattern
public class WeatherTransformer: ProcessTransformer {
    override public func renderCurrent(measurements: [ProcessSelector: [ProcessValue<Dimension>]])
        -> [ProcessSelector: ProcessValue<Dimension>] {
        // Transform raw measurements into current values
    }
}
```

### Data Flow Pattern

```swift
// Service (HTTP) → Controller (Parse) → Transformer (Process) → Consumer (Display)

// 1. Service: Fetch raw data
let data = try await CovidService.fetchIncidence(id: districtId)

// 2. Controller: Parse and structure
let sensor = try await controller.refreshData(for: location)

// 3. Transformer: Process for display
let transformer = WeatherTransformer()
try transformer.renderData(sensor: sensor)

// 4. Consumer uses: transformer.current, transformer.faceplate, etc.
```

### Process Architecture

```swift
// CORRECT: ProcessValue with quality assessment
let temperature = Measurement<Dimension>(value: 20.5, unit: UnitTemperature.celsius)
let processValue = ProcessValue(value: temperature, quality: .good, timestamp: Date.now)

// CORRECT: ProcessSensor with measurements
let sensor = ProcessSensor(
    name: "Weather Station",
    location: location,
    placemark: "Berlin, Germany",
    customData: ["icon": "cloud.sun"],
    measurements: measurements,
    timestamp: Date.now
)

// CORRECT: ProcessSelector for data organization
measurements[.weather(.temperature)] = [processValue]
measurements[.weather(.humidity)] = [humidityValue]
```

### Custom Units Pattern

```swift
// CORRECT: Custom Dimension subclass with @unchecked Sendable
public class UnitRadiation: Dimension, @unchecked Sendable {
    public static let sieverts = UnitRadiation(
        symbol: "Sv/h",
        converter: UnitConverterLinear(coefficient: 1.0)
    )

    public static let microsieverts = UnitRadiation(
        symbol: "µSv/h",
        converter: UnitConverterLinear(coefficient: 0.000001)
    )

    override public class func baseUnit() -> Self {
        return sieverts as! Self
    }
}
```

### Subscription Pattern

```swift
// CORRECT: ProcessManager subscription system
public func add(subscriber: any ProcessSubscriber, timeout: TimeInterval) {
    subscriptions.append(ProcessSubscription(id: subscriber.id, timeout: timeout * 60))
    subscribers[subscriber.id] = subscriber
}

// CORRECT: ProcessSubscriber protocol implementation
public protocol ProcessSubscriber: Identifiable {
    func refreshData(location: Location) async
    func resetData() async
}
```

### Location-Based Updates

```swift
// CORRECT: LocationManagerDelegate pattern
public protocol LocationManagerDelegate: Identifiable where ID == UUID {
    func locationManager(didUpdateLocation location: Location) -> Void
}

// CORRECT: Significant location change detection
private func significantLocationChange(previous: Location?, current: Location) -> Bool {
    guard let previous = previous else { return true }
    let deadband = Measurement(value: 100.0, unit: UnitLength.meters)
    let distance = haversineDistance(location_0: previous, location_1: current)
    return distance > deadband
}
```

### Network Resilience Pattern

```swift
// CORRECT: URLSession extension with retry logic
extension URLSession {
    public func dataWithRetry(
        from url: URL, retryCount: Int = 3, retryInterval: TimeInterval = 1.0
    ) async throws -> (Data, URLResponse) {
        var lastError: Error?

        guard ReachabilityManager.shared.isConnected else {
            throw URLError(.notConnectedToInternet)
        }

        for attempt in 0..<retryCount {
            do {
                let (data, response) = try await self.data(from: url)
                return (data, response)
            } catch {
                lastError = error
                if attempt < retryCount - 1 {
                    try await Task.sleep(nanoseconds: UInt64(retryInterval * 1_000_000_000))
                }
            }
        }
        throw lastError ?? URLError(.unknown)
    }
}
```

### Logging Pattern

```swift
// CORRECT: Use Trace utility for structured logging
trace.debug("Fetching covid measurement districts...")
let data = try await service.fetch()
trace.debug("Fetched covid measurement districts.")

trace.error("Failed to parse response: \(error)")
```

### Platform Independence

```swift
// CORRECT: Platform conditionals for OS-specific code
#if os(iOS)
locationManager.allowsBackgroundLocationUpdates = true
locationManager.pausesLocationUpdatesAutomatically = false
#else
locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
#endif

// AVOID: UI framework dependencies (SwiftUI, UIKit, AppKit) in package
// Keep package focused on business logic and data processing
```

---

## Summary Checklist

### Before Committing Code

- [ ] All public APIs have explicit `public` access control
- [ ] All types, functions, and properties follow naming conventions
- [ ] Code is formatted with 4-space indentation
- [ ] No trailing whitespace
- [ ] Documentation comments for public APIs
- [ ] Error handling is comprehensive
- [ ] Async/await used consistently throughout
- [ ] No platform-specific UI dependencies (SwiftUI, UIKit, AppKit)
- [ ] Custom `Dimension` types conform to `@unchecked Sendable`
- [ ] Protocol conformance is clear and explicit
- [ ] MARK comments organize code sections
- [ ] No force unwrapping (!) unless absolutely safe
- [ ] Follows established package patterns (Controller/Service/Transformer)

### Code Review Focus Areas

1. **Access Control**: Correct use of public/private/internal
2. **Naming**: Clear, descriptive, follows conventions
3. **Error Handling**: Comprehensive try-catch, meaningful errors
4. **Concurrency**: Proper async/await, actor usage, Sendable conformance
5. **Architecture**: Follows Controller/Service/Transformer pattern
6. **Documentation**: Public APIs documented, complex logic explained
7. **Platform Independence**: No UI framework dependencies
8. **Performance**: Efficient algorithms, lazy evaluation where appropriate
9. **Safety**: No force unwrapping, proper optional handling
10. **Consistency**: Matches existing codebase patterns

---

*This document is maintained alongside AGENTS.md and should be updated when new patterns emerge or conventions change.*

## Build Commands

### Prerequisites

```bash
# Check Xcode version
xcodebuild -version

# Check Swift version
swift --version

# Install Xcode Command Line Tools (if not already installed)
xcode-select --install

# List available simulators (for testing)
xcrun simctl list devices
```

### Opening the Project

```bash
# Clone the repository
git clone https://github.com/ultralove/bonjour-browser.git
cd bonjour-browser

# Open in Xcode
open BonjourBrowser.xcodeproj
```

### Building with Sweetpad (Cursor/VSCode)

This project is configured to build with the **Sweetpad extension** in Cursor:

1. **Run Task**: Use Command Palette (`⌘⇧P`) → "Tasks: Run Task" → "sweetpad: Launch"
2. **Or use shortcuts** configured in Sweetpad
3. Sweetpad handles building and launching automatically using xcodebuild

### Building with Xcode GUI (Alternative)

1. **Open Project**: `⌘O` or File → Open → Select `BonjourBrowser.xcodeproj`
2. **Build**: `⌘B` or Product → Build
3. **Run**: `⌘R` or Product → Run
4. **Clean Build Folder**: `⇧⌘K` or Product → Clean Build Folder
5. **Archive**: Product → Archive (for distribution)

### Building from Command Line

```bash
# Build for Debug (development)
xcodebuild -project BonjourBrowser.xcodeproj \
  -scheme BonjourBrowser \
  -configuration Debug \
  build

# Build for Release (optimized)
xcodebuild -project BonjourBrowser.xcodeproj \
  -scheme BonjourBrowser \
  -configuration Release \
  build

# Run the app after building (Debug)
open build/Debug/BonjourBrowser.app

# Clean build artifacts
xcodebuild -project BonjourBrowser.xcodeproj \
  -scheme BonjourBrowser \
  clean

# Clean derived data (complete reset)
rm -rf ~/Library/Developer/Xcode/DerivedData/BonjourBrowser-*
```

### Building for Distribution

```bash
# Archive the application
xcodebuild -project BonjourBrowser.xcodeproj \
  -scheme BonjourBrowser \
  -configuration Release \
  -archivePath ./build/BonjourBrowser.xcarchive \
  archive

# Export the archive (requires export options plist)
xcodebuild -exportArchive \
  -archivePath ./build/BonjourBrowser.xcarchive \
  -exportPath ./build/Release \
  -exportOptionsPlist ExportOptions.plist

# Create a DMG for distribution (requires create-dmg tool)
# Install: brew install create-dmg
create-dmg \
  --volname "Bonjour Browser" \
  --window-pos 200 120 \
  --window-size 600 400 \
  --icon-size 100 \
  --app-drop-link 450 185 \
  "BonjourBrowser.dmg" \
  "./build/Release/"
```

### Advanced Build Options

```bash
# Build with verbose output
xcodebuild -project BonjourBrowser.xcodeproj \
  -scheme BonjourBrowser \
  -configuration Debug \
  build \
  -verbose

# Show build settings
xcodebuild -project BonjourBrowser.xcodeproj \
  -scheme BonjourBrowser \
  -showBuildSettings

# List available schemes
xcodebuild -project BonjourBrowser.xcodeproj \
  -list

# Build for specific architecture
xcodebuild -project BonjourBrowser.xcodeproj \
  -scheme BonjourBrowser \
  -arch arm64 \
  build

# Build universal binary (Apple Silicon + Intel)
xcodebuild -project BonjourBrowser.xcodeproj \
  -scheme BonjourBrowser \
  -configuration Release \
  ARCHS="arm64 x86_64" \
  ONLY_ACTIVE_ARCH=NO \
  build
```

### Code Signing

```bash
# List available code signing identities
security find-identity -v -p codesigning

# Build with specific signing identity
xcodebuild -project BonjourBrowser.xcodeproj \
  -scheme BonjourBrowser \
  -configuration Release \
  CODE_SIGN_IDENTITY="Developer ID Application: Your Name" \
  build

# Verify code signature
codesign -dv --verbose=4 ./build/Release/BonjourBrowser.app

# Check entitlements
codesign -d --entitlements :- ./build/Release/BonjourBrowser.app
```

### Code Quality

```bash
# Analyze code (static analysis)
xcodebuild -project BonjourBrowser.xcodeproj \
  -scheme BonjourBrowser \
  analyze

# Format code (requires swift-format)
# Install: brew install swift-format
swift-format format --in-place --recursive BonjourBrowser/

# Lint code (requires SwiftLint)
# Install: brew install swiftlint
swiftlint lint --path BonjourBrowser/

# Auto-fix lint issues
swiftlint --fix --path BonjourBrowser/
```

### Debugging

```bash
# Run with debugger from command line
lldb ./build/Debug/BonjourBrowser.app/Contents/MacOS/BonjourBrowser

# View crash logs
open ~/Library/Logs/DiagnosticReports/

# Console logs
log stream --predicate 'processImagePath contains "BonjourBrowser"' --level debug
```

**Important**: Always use Debug configuration during development. Debug builds compile faster and include full debugging symbols. Only use Release configuration for final testing and distribution.

<!-- {integration} -->

## Commit Protocol (CRITICAL)

- **NEVER commit automatically** - always wait for explicit confirmation

Whenever asked to commit changes:

- Stage the changes
- Write a detailed but concise commit message using conventional commits format
- Commit the changes

This is **CRITICAL**!

## **Commit Message Guidelines - CRITICAL**

Follow these rules to prevent VSCode terminal crashes and ensure clean git history:

**Message Format (Conventional Commits):**

```text
<type>(<scope>): <subject>

<body>

<footer>
```

**Character Limits:**

- **Subject line**: Maximum 50 characters (strict limit)
- **Body lines**: Wrap at 72 characters per line
- **Total message**: Keep under 500 characters total
- **Blank line**: Always add blank line between subject and body

**Subject Line Rules:**

- Use conventional commit types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `build`, `ci`, `perf`
- Scope is optional but recommended: `feat(api):`, `fix(build):`, `docs(readme):`
- Use imperative mood: "add feature" not "added feature"
- No period at end of subject line
- Keep concise and descriptive

**Body Rules (if needed):**

- Add blank line after subject before body
- Wrap each line at 72 characters maximum
- Explain what and why, not how
- Use bullet points (`-`) for multiple items with lowercase text after bullet
- Keep it concise

**Special Character Safety:**

- Avoid nested quotes or complex quoting
- Avoid special shell characters: `$`, `` ` ``, `!`, `\`, `|`, `&`, `;`
- Use simple punctuation only
- No emoji or unicode characters

**Best Practices:**

- **Break up large commits**: Split into smaller, focused commits with shorter messages
- **One concern per commit**: Each commit should address one specific change
- **Test before committing**: Ensure code builds and works
- **Reference issues**: Use `#123` format in footer if applicable

**Examples:**

Good:

```text
feat(api): add KStringTrim function

- add trimming function to remove whitespace from
  both ends of string
- supports all encodings
```

Good (short):

```text
fix(build): correct static library output name
```

Bad (too long):

```text
feat(api): add a new comprehensive string trimming function that handles all edge cases including UTF-8, UTF-16LE, UTF-16BE, and ANSI encodings with proper boundary checking and memory management
```

Bad (special characters):

```text
fix: update `KString` with "nested 'quotes'" & $special chars!
```

## Versioning Protocol

**Follow semantic versioning (SemVer) for releases.**

The version is defined in the Xcode project settings under the app's target:
- **Version** (`CFBundleShortVersionString` in Info.plist): User-facing version (e.g., "1.2.3")
- **Build** (`CFBundleVersion` in Info.plist): Internal build number (e.g., "42")

### Version Format: MAJOR.MINOR.PATCH

**When to increment the version:**

1. **PATCH version** (X.Y.Z → X.Y.Z+1)
   - Bug fixes and minor corrections
   - Performance improvements without feature changes
   - UI polish and minor improvements
   - Documentation updates
   - Example: `1.0.0` → `1.0.1`

2. **MINOR version** (X.Y.Z → X.Y+1.0)
   - New features added
   - New service discovery capabilities
   - UI enhancements that add functionality
   - Backward-compatible improvements
   - Example: `1.0.1` → `1.1.0`

3. **MAJOR version** (X.Y.Z → X+1.0.0)
   - Breaking changes to saved data or settings
   - Major UI/UX redesign
   - Minimum macOS version requirement changes
   - Architectural changes affecting compatibility
   - Example: `1.1.0` → `2.0.0`

### Process

**For releases:**
1. Update version in Xcode project target settings
2. Update `CFBundleShortVersionString` in Info.plist
3. Increment `CFBundleVersion` build number for each build
4. Tag the release in Git: `git tag v1.2.3`
5. Create GitHub release with changelog

**Build number:** Increment for every build, even within the same version. Resets to 1 when version changes.

---

## Recent Updates & Decisions

### 2025-12-23 (Evening)

- Fixed service discovery issue that prevented services from appearing
- Fixed ServiceTypeBrowser.swift: Changed from low-level DNS-SD API to static service type list (40+ common types)
- Fixed Info.plist: Added NSLocalNetworkUsageDescription for macOS local network permission
- Fixed BonjourBrowser.entitlements: Simplified to only required network client entitlement
- Removed dns_sd.h dependency from bridging header (no longer needed)
- Documented Sweetpad extension usage as primary development workflow in Cursor
- Reasoning: DNS-SD C API incompatible with modern macOS App Sandbox; static list approach more reliable

### 2025-12-23

- Updated AGENTS.md for Bonjour Browser project specifics
- Added mission statement describing Bonjour/mDNS network service discovery app
- Updated technology stack: Swift, macOS 15.2+, AppKit, Network framework, Xcode 16.0+
- Replaced Swift Package Manager build commands with Xcode-specific commands
- Added comprehensive Xcode build, distribution, and code signing instructions
- Updated versioning protocol from Cargo.toml (Rust) to Xcode/Info.plist (macOS app)
- Added project-specific development guidelines for MVC architecture and Network framework
- Documented key components: BonjourBrowser, ServiceNode, ServiceTypeBrowser, delegates
- Updated testing approach for network service discovery scenarios
- Kept comprehensive Swift coding conventions (still applicable and excellent)
- Reasoning: Adapted generic template to match actual Bonjour Browser macOS app project

### 2025-10-05

- Initial AGENTS.md setup
- Established core coding standards and conventions
- Created agent-specific reference files
- Defined repository structure and governance principles
