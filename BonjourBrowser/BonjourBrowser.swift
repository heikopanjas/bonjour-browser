import Foundation
import Network

class BonjourBrowser: NSObject {
    var serviceTypes: [String: ServiceNode] = [:]
    var onServicesUpdated: (() -> Void)?
    private var browsers: [String: NWBrowser] = [:]
    private var txtDelegates: [String: TXTRecordDelegate] = [:] // Store delegates
    private var resolutionDelegates: [String: ServiceResolutionDelegate] = [:]  // Keep delegates alive
    private var resolvers: [String: NetService] = [:]  // Keep resolvers alive
    private let serviceTypeBrowser = ServiceTypeBrowser()

    override init() {
        super.init()
        setupServiceTypeBrowser()
    }

    private func setupServiceTypeBrowser() {
        serviceTypeBrowser.onServiceTypesUpdated = { [weak self] types in
            for baseType in types {
                guard baseType.hasPrefix("_") else { continue }

                let tcpType = "\(baseType)._tcp"
                let udpType = "\(baseType)._udp"

                print("Trying TCP service type: \(tcpType)")
                self?.startBrowsing(for: tcpType)

                print("Trying UDP service type: \(udpType)")
                self?.startBrowsing(for: udpType)
            }
        }
    }

    func startDiscovery() {
        serviceTypeBrowser.start()
    }

    func stopDiscovery() {
        serviceTypeBrowser.stop()
        stopAllBrowsing()
    }

    func startBrowsing(for serviceType: String) {
        stopBrowsing(for: serviceType)

        let parameters = NWParameters()
        parameters.includePeerToPeer = true

        print("Creating browser for service type: \(serviceType)")
        let browserDescriptor = NWBrowser.Descriptor.bonjour(type: serviceType, domain: "local")
        let browser = NWBrowser(for: browserDescriptor, using: parameters)

        browser.stateUpdateHandler = { state in
            switch state {
                case .ready:
                    print("Browser ready for \(serviceType)")
                case .failed(let error):
                    print("Browser failed for \(serviceType) with error: \(error)")
                    print("Detailed error: \(error)") 
                case .cancelled:
                    print("Browser cancelled for \(serviceType)")
                case .waiting(let error):
                    print("Browser waiting with error: \(error)")
                default:
                    print("Browser state: \(state)")
            }
        }

        browser.browseResultsChangedHandler = { [weak self] results, changes in
            DispatchQueue.main.async {
                self?.handleBrowseResults(results, for: serviceType)
            }
        }

        browsers[serviceType] = browser
        browser.start(queue: .main)
    }

    private func handleBrowseResults(_ results: Set<NWBrowser.Result>, for serviceType: String) {
        let serviceTypeNode = serviceTypes[serviceType] ?? ServiceNode(name: serviceType)
        serviceTypes[serviceType] = serviceTypeNode

        // Clear existing services for this type
        serviceTypeNode.children.removeAll()

        // Add discovered services
        for result in results {
            if case .service(let name, let type, let domain, _) = result.endpoint {
                let serviceNode = ServiceNode(name: name)
                serviceNode.type = type
                serviceNode.domain = domain
                serviceTypeNode.addChild(serviceNode)
                resolveService(name: name, type: type, domain: domain, node: serviceNode)
            }
        }

        onServicesUpdated?()
    }

    private func resolveService(name: String, type: String, domain: String, node: ServiceNode) {
        let service = NetService(domain: domain, type: type, name: name)
        let key = "\(domain)\(type)\(name)"

        // Create and store the delegate
        let delegate = ServiceResolutionDelegate { [weak self] addresses, port, txtDict in
            DispatchQueue.main.async {
                // Update node with resolved information
                node.addresses = addresses
                node.port = port
                node.txt = txtDict
                self?.onServicesUpdated?()

                // Cleanup after successful resolution
                self?.resolutionDelegates.removeValue(forKey: key)
                self?.resolvers.removeValue(forKey: key)
            }
        }

        // Store strong references
        resolutionDelegates[key] = delegate
        resolvers[key] = service

        // Set delegate and start resolution
        service.delegate = delegate
        service.resolve(withTimeout: 5.0)
    }
    
    func stopBrowsing(for serviceType: String) {
        browsers[serviceType]?.cancel()
        browsers.removeValue(forKey: serviceType)

        // Clean up any TXT delegates for this service type
        txtDelegates = txtDelegates.filter { !$0.key.contains(serviceType) }
    }

    func stopAllBrowsing() {
        browsers.values.forEach { $0.cancel() }
        browsers.removeAll()
        txtDelegates.removeAll()
    }
}

