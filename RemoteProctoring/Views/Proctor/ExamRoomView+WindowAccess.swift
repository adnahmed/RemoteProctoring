//
//  ExamRoomView+WindowAccess.swift
//  RemoteProctoring
//
//  Created by Adnan Ahmed Khan on 14/09/2022.
//

import Foundation
#if os(macOS)
import AppKit
// keeps weak reference to NSWindow
class WindowAccess: ObservableObject {

    private weak var window: NSWindow?

    deinit {
        // reset changed properties
        DispatchQueue.main.async { [weak window] in
            window?.level = .normal
        }
    }

    @Published public var pinned: Bool = false {
        didSet {
            guard oldValue != pinned else { return }
            self.level = pinned ? .floating : .normal
        }
    }

    private var level: NSWindow.Level {
        get { window?.level ?? .normal }
        set {
            DispatchQueue.main.async {
                self.window?.level = newValue
                self.objectWillChange.send()
            }
        }
    }

    public func set(window: NSWindow?) {
        self.window = window
        DispatchQueue.main.async { self.objectWillChange.send() }
    }
}
#endif

