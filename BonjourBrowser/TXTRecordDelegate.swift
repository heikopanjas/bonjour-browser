import Foundation

class TXTRecordDelegate: NSObject, NetServiceDelegate {
    private let completion: ([String: String]) -> Void

    init(completion: @escaping ([String: String]) -> Void) {
        self.completion = completion
        super.init()
    }

    func netService(_ sender: NetService, didUpdateTXTRecord data: Data) {
        var dict = [String: String]()

        // Get TXT record dictionary
        let txtRecord = NetService.dictionary(fromTXTRecord: data)

        // Convert each value from Data to String
        for (key, valueData) in txtRecord {
            if let valueString = String(data: valueData, encoding: .utf8) {
                dict[key] = valueString
            }
        }

        completion(dict)
    }
}

