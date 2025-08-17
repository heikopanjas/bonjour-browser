# Bonjour Browser

A native macOS application for discovering and browsing network services using the Bonjour/mDNS protocol. Built with Swift and Apple's modern Network framework.

![macOS](https://img.shields.io/badge/macOS-15.2+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.0+-orange.svg)
![License](https://img.shields.io/badge/License-MIT-green.svg)

## Features

- 🔍 **Automatic Service Discovery** - Automatically discovers all available Bonjour service types on your network
- 🌐 **Comprehensive Protocol Support** - Supports both TCP and UDP service discovery
- 🔗 **Peer-to-Peer Discovery** - Includes peer-to-peer service discovery capabilities
- 📊 **Hierarchical View** - Organizes discovered services in an intuitive tree structure
- 🔎 **Real-time Filtering** - Live search and filter functionality for easy service location
- 📋 **Detailed Service Information** - Shows service addresses, ports, and TXT record metadata
- ⚡ **Live Updates** - Real-time service list updates as services appear and disappear

## Screenshots

*[Screenshots would go here showing the main interface]*

## Requirements

- macOS 15.2 or later
- Xcode 16.0 or later (for building from source)

## Installation

### Option 1: Download Release

1. Download the latest release from the [Releases](https://github.com/ultralove/bonjour-browser/releases) page
2. Drag `BonjourBrowser.app` to your Applications folder
3. Launch the application

### Option 2: Build from Source

1. Clone the repository:

   ```bash
   git clone https://github.com/ultralove/bonjour-browser.git
   cd bonjour-browser
   ```

2. Open the project in Xcode:

   ```bash
   open BonjourBrowser.xcodeproj
   ```

3. Build and run the project (⌘+R)

## Usage

1. **Launch the Application** - Open BonjourBrowser from your Applications folder
2. **Automatic Discovery** - The app immediately starts discovering services on your network
3. **Browse Services** - Use the outline view to explore discovered service types and individual services
4. **Filter Results** - Use the search field at the top to filter services by name
5. **View Details** - Select a service to see detailed information including addresses, ports, and TXT records

### Service Information

For each discovered service, you can view:

- **Service Name** - The advertised name of the service
- **Service Type** - The protocol and transport (e.g., `_http._tcp`, `_ssh._tcp`)
- **Domain** - The domain where the service is advertised
- **IP Addresses** - All resolved IP addresses for the service
- **Port** - The port number the service is running on
- **TXT Records** - Key-value metadata published by the service

## Architecture

The application is built using a clean MVC architecture with the following key components:

### Core Classes

- **`BonjourBrowser`** - Main service discovery engine using Apple's Network framework
- **`ViewController`** - Primary UI controller managing the outline view and search functionality
- **`ServiceNode`** - Data model representing services in a hierarchical tree structure
- **`ServiceTypeBrowser`** - Discovers available service types on the network
- **`ServiceResolutionDelegate`** - Handles detailed service resolution (addresses, ports, etc.)
- **`TXTRecordDelegate`** - Parses and manages TXT record metadata

### Key Features

- **Modern Network Framework** - Uses `NWBrowser` instead of legacy NSNetService APIs
- **Memory Safe** - Implements proper memory management with weak references
- **Delegation Pattern** - Clean separation of concerns using Swift delegation
- **Real-time Updates** - Efficient UI updates using closures and callbacks

## Technical Details

### Supported Service Types

The browser automatically discovers all service types advertised on your network, including but not limited to:

- HTTP services (`_http._tcp`)
- SSH services (`_ssh._tcp`)
- FTP services (`_ftp._tcp`)
- AirPlay services (`_airplay._tcp`)
- Printer services (`_ipp._tcp`)
- And many more...

### Network Protocols

- **Bonjour/mDNS** - Multicast DNS for service discovery
- **DNS-SD** - DNS Service Discovery
- **TCP/UDP** - Both transport protocols supported

## Development

### Project Structure

```text
BonjourBrowser/
├── BonjourBrowser.swift          # Main browser class
├── ViewController.swift           # Primary UI controller
├── ServiceNode.swift             # Service data model
├── ServiceTypeBrowser.swift      # Service type discovery
├── ServiceResolutionDelegate.swift # Service resolution
├── TXTRecordDelegate.swift       # TXT record handling
├── AppDelegate.swift             # Application delegate
├── Info.plist                    # App configuration
├── BonjourBrowser.entitlements   # App entitlements
└── Assets.xcassets/              # App icons and assets
```

### Building

This project uses Xcode's modern build system and requires:

- Xcode 16.0+
- macOS 15.2+ SDK
- Swift 5.0+

### Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Code Style

This project follows standard Swift conventions:

- Use meaningful variable and function names
- Include documentation for public APIs
- Follow the existing architecture patterns
- Ensure proper memory management

## Troubleshooting

### Common Issues

**Services not appearing:**

- Ensure your Mac and target devices are on the same network
- Check that services are properly advertising via Bonjour
- Verify firewall settings aren't blocking mDNS traffic

**Application crashes:**

- Check Console.app for crash logs
- Ensure you're running on a supported macOS version
- Try rebuilding the application from source

**Performance issues:**

- The app is designed to handle hundreds of services efficiently
- If experiencing slowdowns, try using the filter to narrow results

## Privacy & Security

BonjourBrowser only discovers services that are intentionally advertised on your local network. It does not:

- Send any data over the internet
- Store personal information
- Access services without permission
- Modify network settings

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- Built using Apple's Network framework
- Inspired by classic Bonjour browser utilities
- Thanks to the Swift and macOS development community

## Support

- 🐛 **Bug Reports**: [GitHub Issues](https://github.com/ultralove/bonjour-browser/issues)
- 💡 **Feature Requests**: [GitHub Discussions](https://github.com/ultralove/bonjour-browser/discussions)
- 📧 **Contact**: [Create an issue](https://github.com/ultralove/bonjour-browser/issues/new)

---

Made with ❤️ for the macOS community
