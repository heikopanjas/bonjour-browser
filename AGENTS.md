# AI Agent Instructions for bonjour-browser

**Last updated:** October 3, 2025

## Commit Workflow

When asked to "commit the latest changes":

1. Stage all changes with `git add .`
2. Write a detailed but concise commit message using conventional commits format
3. Commit the changes with the generated message
4. **NEVER commit automatically** - only commit when explicitly asked

## Project Overview

This is a macOS application written in Swift that provides a Bonjour service browser. The application allows users to discover and browse network services using the Bonjour/mDNS protocol.

## Key Components

1. **BonjourBrowser.swift** - The main browser class that handles service discovery using Apple's Network framework
2. **ViewController.swift** - The main UI controller with an outline view for displaying discovered services and a search/filter field
3. **ServiceNode.swift** - Data model representing discovered services in a hierarchical structure
4. **ServiceTypeBrowser.swift** - Handles discovery of available service types
5. **ServiceResolutionDelegate.swift** - Manages service resolution to get detailed information
6. **TXTRecordDelegate.swift** - Handles TXT record parsing for service metadata

## Architecture

- Uses Apple's modern Network framework (NWBrowser) for service discovery
- Implements a hierarchical view of services organized by service type
- Supports both TCP and UDP service discovery
- Includes peer-to-peer service discovery
- Features real-time filtering of discovered services

## Development Guidelines

- This is a macOS-only application (Cocoa framework)
- Uses modern Swift networking APIs
- Follows MVC pattern with clear separation of concerns
- Implements proper memory management with weak references to avoid retain cycles
- Uses delegation pattern for handling network events

## Key Features

- Automatic discovery of all Bonjour service types on the network
- Real-time service browsing with live updates
- Filterable service list
- Detailed service information display
- Support for both standard and peer-to-peer services

---

## Recent Updates & Decisions

### 2025-10-03 - Initial AGENTS.md Creation

- Created master instructions file to centralize all AI agent guidance
- Moved all instructions from `.github/copilot-instructions.md` to this file
- Clarified commit workflow: NEVER commit automatically, only when explicitly asked
- Established structure with timestamp and decision log
- **Reasoning:** Centralize all coding standards and project conventions in one authoritative source that can evolve with the project

