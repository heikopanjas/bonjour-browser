import Foundation
import dnssd

class ServiceTypeBrowser: NSObject {
    var onServiceTypesUpdated: (([String]) -> Void)?
    private var serviceRef: DNSServiceRef?
    private var source: DispatchSourceProtocol?

    func start() {
        let flags = DNSServiceFlags(kDNSServiceFlagsRegistrationDomains)
        var errorCode = DNSServiceErrorType(kDNSServiceErr_NoError)

        // Browse for service types
        errorCode = DNSServiceBrowse(
            &serviceRef,
            flags,
            0,          // interface index (0 = all interfaces)
            "_services._dns-sd._udp",
            "local",    // domain
            { (sdRef, flags, interfaceIndex, errorCode, serviceName, regtype, replyDomain, context) in
                // This is the callback for each discovered service type
                guard errorCode == DNSServiceErrorType(kDNSServiceErr_NoError),
                      let serviceName = serviceName.map({ String(cString: $0) }),
                      let context = context else {
                    return
                }

                let browser = Unmanaged<ServiceTypeBrowser>.fromOpaque(context).takeUnretainedValue()

                // The serviceName here is actually a service type
                if !serviceName.isEmpty {
                    DispatchQueue.main.async {
                        browser.serviceDiscovered(serviceName)
                    }
                }
            },
            Unmanaged.passUnretained(self).toOpaque()
        )

        guard errorCode == kDNSServiceErr_NoError else {
            print("Error starting service type browse: \(errorCode)")
            return
        }

        // Create a dispatch source for the service ref
        let queue = DispatchQueue(label: "com.example.dnssd")
        let descriptor = DNSServiceRefSockFD(serviceRef!)
        let source = DispatchSource.makeReadSource(fileDescriptor: descriptor, queue: queue)

        source.setEventHandler { [weak self] in
            guard let self = self,
                  let serviceRef = self.serviceRef else { return }
            DNSServiceProcessResult(serviceRef)
        }

        source.setCancelHandler { [weak self] in
            self?.cleanup()
        }

        self.source = source
        source.resume()
    }

    private func serviceDiscovered(_ serviceType: String) {
        // The service types come back in the format: _servicetype._tcp or _servicetype._udp
        print("Discovered service type: \(serviceType)")
        onServiceTypesUpdated?([serviceType])
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

