import Foundation

class ServiceNode: NSObject {
    var name: String
    var children: [ServiceNode]
    var parent: ServiceNode?
    var type: String?
    var domain: String?
    var addresses: [String] = []
    var port: Int?
    var txt: [String: String] = [:]

    init(name: String, children: [ServiceNode] = []) {
        self.name = name
        self.children = children
        super.init()
        children.forEach { $0.parent = self }
    }

    func addChild(_ child: ServiceNode) {
        children.append(child)
        child.parent = self
    }

    func removeChild(_ child: ServiceNode) {
        if let index = children.firstIndex(of: child) {
            children.remove(at: index)
            child.parent = nil
        }
    }
}


