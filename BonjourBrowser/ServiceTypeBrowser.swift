import Foundation

class ServiceTypeBrowser: NSObject {
    var onServiceTypesUpdated: (([String]) -> Void)?
    private var serviceRef: DNSServiceRef?
    private var source: DispatchSourceRead?
    private var discoveredTypes = Set<String>()

    func start() {
        print("Starting DNS-SD service type browser")

        let context = Unmanaged.passUnretained(self).toOpaque()
        var sdRef: DNSServiceRef?

        // Browse for service types using DNS-SD
        let err = DNSServiceBrowse(
            &sdRef,
            0,  // flags
            0,  // interface (0 = all interfaces)
            "_services._dns-sd._udp",  // Service type for discovering service types
            "local.",  // domain
            { (sdRef, flags, interfaceIndex, errorCode, serviceName, regtype, replyDomain, context) in
                guard errorCode == kDNSServiceErr_NoError,
                      let context = context,
                      let serviceName = serviceName else {
                    return
                }

                let browser = Unmanaged<ServiceTypeBrowser>.fromOpaque(context).takeUnretainedValue()
                let typeString = String(cString: serviceName)

                DispatchQueue.main.async {
                    browser.handleDiscoveredType(typeString)
                }
            },
            context
        )

        guard err == kDNSServiceErr_NoError, let serviceRef = sdRef else {
            print("Error starting service type browse: \(err)")
            return
        }

        self.serviceRef = serviceRef

        // Set up dispatch source to process results
        let sock = DNSServiceRefSockFD(serviceRef)
        let queue = DispatchQueue.main
        let source = DispatchSource.makeReadSource(fileDescriptor: sock, queue: queue)

        source.setEventHandler { [weak self] in
            guard let serviceRef = self?.serviceRef else { return }
            DNSServiceProcessResult(serviceRef)
        }

        source.setCancelHandler { [weak self] in
            self?.cleanup()
        }

        self.source = source
        source.resume()

        print("Service type browser started successfully")
    }

    private func handleDiscoveredType(_ typeString: String) {
        // Service types come back like "_http._tcp" or "_ssh._tcp"
        if !discoveredTypes.contains(typeString) {
            discoveredTypes.insert(typeString)
            print("Discovered service type: \(typeString)")

            // Extract base type (remove transport suffix for callback)
            let baseType = typeString.replacingOccurrences(of: "._tcp", with: "")
                                    .replacingOccurrences(of: "._udp", with: "")

            if !baseType.isEmpty && baseType.hasPrefix("_") {
                onServiceTypesUpdated?([baseType])
            }
        }
    }

    func stop() {
        source?.cancel()
    }

    private func cleanup() {
        if let serviceRef = serviceRef {
            DNSServiceRefDeallocate(serviceRef)
            self.serviceRef = nil
        }
    }

    deinit {
        stop()
    }
}
