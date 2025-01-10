import Foundation

class ServiceResolutionDelegate: NSObject, NetServiceDelegate {
    private let completion: ([String], Int?, [String: String]) -> Void

    init(completion: @escaping ([String], Int?, [String: String]) -> Void) {
        self.completion = completion
        super.init()
    }

    func netServiceDidResolveAddress(_ sender: NetService) {
        var addresses: [String] = []

        if let hostName = sender.hostName {
            addresses.append(hostName)
        }

        // Convert TXT record data to dictionary
        var txtDict: [String: String] = [:]
        if let txtData = sender.txtRecordData() {
            let dict = NetService.dictionary(fromTXTRecord: txtData)
            for (key, valueData) in dict {
                if let value = String(data: valueData, encoding: .utf8) {
                    txtDict[key] = value
                }
            }
        }

        completion(addresses, sender.port, txtDict)
    }

    func netService(_ sender: NetService, didNotResolve errorDict: [String : NSNumber]) {
        print("Failed to resolve service: \(errorDict)")
        completion([], nil, [:])
    }
}

