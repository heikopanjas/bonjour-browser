import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var serviceTypeField: NSTextField!
    @IBOutlet weak var outlineView: NSOutlineView!

    @IBAction func clearButtonClicked(_ sender: Any) {
        serviceTypeField.stringValue = ""
        updateFilteredServices()
    }

    private let browser = BonjourBrowser()
    private var filteredServiceTypes: [ServiceNode] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setupOutlineView()
        setupFilter()

        // Initialize filtered services with all services
        filteredServiceTypes = Array(browser.serviceTypes.values)

        browser.onServicesUpdated = { [weak self] in
            self?.updateFilteredServices()
        }

        browser.startDiscovery()
    }

    private func setupFilter() {
        // Make the text field respond to changes
        serviceTypeField.delegate = self

        // Optional: add search icon or clear button
        if let searchCell = serviceTypeField.cell as? NSSearchFieldCell {
            searchCell.placeholderString = "Filter service types..."
        }
    }

    private func updateFilteredServices() {
        let searchText = serviceTypeField.stringValue.lowercased()

        if searchText.isEmpty {
            // Show all services
            filteredServiceTypes = Array(browser.serviceTypes.values).sorted { $0.name.lowercased() < $1.name.lowercased() }
        } else {
            // Filter services based on search text
            filteredServiceTypes = Array(browser.serviceTypes.values).filter { serviceNode in
                serviceNode.name.lowercased().contains(searchText)
            }.sorted { $0.name.lowercased() < $1.name.lowercased() }
        }

        outlineView.reloadData()

        // Optionally expand all items after filtering
//        filteredServiceTypes.forEach { serviceNode in
//            outlineView.expandItem(serviceNode)
//        }
    }

    private func setupOutlineView() {
        outlineView.delegate = self
        outlineView.dataSource = self

        // Configure the existing first column from storyboard
        if let nameColumn = outlineView.tableColumns.first {
            nameColumn.width = 200
            outlineView.outlineTableColumn = nameColumn
        }

        // Remove any additional columns that might exist in storyboard
        while outlineView.tableColumns.count > 1 {
            if let column = outlineView.tableColumns.last {
                outlineView.removeTableColumn(column)
            }
        }

        // Add the details column
        let detailsColumn = NSTableColumn(identifier: .init("Details"))
        detailsColumn.title = "Details"
        detailsColumn.width = 300
        outlineView.addTableColumn(detailsColumn)
    }

    private func makeTableCellView(withIdentifier identifier: NSUserInterfaceItemIdentifier) -> NSTableCellView {
        let cellView = NSTableCellView()
        let textField = NSTextField()

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.drawsBackground = false
        textField.isBordered = false
        textField.isEditable = false
        textField.isSelectable = true
        textField.cell?.wraps = true
        textField.cell?.isScrollable = false
        textField.cell?.usesSingleLineMode = false
//        textField.maximumNumberOfLines = 0  // Allow unlimited lines
//        textField.preferredMaxLayoutWidth = identifier.rawValue == "Details" ? 280 : 180 // Account for column width

        // Set smaller font
        textField.font = .systemFont(ofSize: 11)  // Default system font is 13


        cellView.addSubview(textField)
        cellView.textField = textField

        // Add constraints
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 4),
            textField.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -4),
            textField.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 2),  // Reduced padding for smaller text
            textField.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -2)  // Reduced padding for smaller text
        ])

        return cellView
    }
}

extension ViewController: NSOutlineViewDataSource {
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        if item == nil {
            return filteredServiceTypes.count
        } else if let node = item as? ServiceNode {
            return node.children.count
        }
        return 0
    }

    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        if item == nil {
            return filteredServiceTypes[index]
        } else if let node = item as? ServiceNode {
            return node.children.sorted { $0.name.lowercased() < $1.name.lowercased() }[index]
        }
        fatalError("Invalid outline view state")
    }

    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        if let node = item as? ServiceNode {
            return !node.children.isEmpty
        }
        return false
    }
}

extension ViewController: NSOutlineViewDelegate {
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        guard let node = item as? ServiceNode,
              let tableColumn = tableColumn else { return nil }

        let view = makeTableCellView(withIdentifier: tableColumn.identifier)

        switch tableColumn.identifier.rawValue {
            case "Name":
                view.textField?.stringValue = node.name

            case "Details":
                if node.children.isEmpty {
                    // This is a service node, show details
                    var details = [String]()

                    if let type = node.type {
                        details.append("Type: \(type)")
                    }
                    if !node.addresses.isEmpty {
                        details.append("Addresses: " + node.addresses.joined(separator: ", "))
                    }
                    if let port = node.port {
                        details.append("Port: \(port)")
                    }
                    if !node.txt.isEmpty {
                        let txtRecords = node.txt.map { "\($0.key)=\($0.value)" }.joined(separator: ", ")
                        details.append("TXT: \(txtRecords)")
                    }

                    // Join with newline and remove any extra newlines that might be present
                    let detailString = details.joined(separator: "\n").trimmingCharacters(in: .whitespacesAndNewlines)
                    view.textField?.stringValue = detailString

                    // Configure text field for multiline
                    view.textField?.cell?.wraps = true
                    view.textField?.cell?.isScrollable = false
                    view.textField?.cell?.usesSingleLineMode = false
                } else {
                    view.textField?.stringValue = "\(node.children.count) services"
                }

            default:
                view.textField?.stringValue = ""
        }

        return view
    }

    func outlineView(_ outlineView: NSOutlineView, heightOfRowByItem item: Any) -> CGFloat {
        guard let node = item as? ServiceNode else { return 24 }

        if node.children.isEmpty {
            var lines = 1
            if node.type != nil { lines += 1 }
            if !node.addresses.isEmpty { lines += 1 }
            if node.port != nil { lines += 1 }
            if !node.txt.isEmpty { lines += 2 }

            return CGFloat(lines) * 20
        } else {
            return 20  // Default height for service type rows
        }
    }
}

extension ViewController: NSTextFieldDelegate {
    func controlTextDidChange(_ obj: Notification) {
        updateFilteredServices()
    }
}

