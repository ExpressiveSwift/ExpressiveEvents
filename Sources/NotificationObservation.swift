//
//  ExpressiveEvents, part of ExpressiveSwift project
//
//  Copyright (c) 2014-2016 Andrey Tarantsov <andrey@tarantsov.com>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation


// MARK: - Wildcard observation

public extension Observation {
    public mutating func on(name: String, _ block: (NSNotification) -> Void) {
        add(NotificationObserver(name: name, object: nil, block: block))
    }

    public mutating func on <T: AnyObject> (name: String, _ observer: T, _ block: (T) -> (NSNotification) -> Void) {
        weak var weakObserver: T? = observer
        on(name) { notification in
            if let observer = weakObserver {
                block(observer)(notification)
            }
        }
    }

    public mutating func on <T: AnyObject> (name: String, _ observer: T, _ block: (T) -> () -> Void) {
        weak var weakObserver: T? = observer
        on(name) { notification in
            if let observer = weakObserver {
                block(observer)()
            }
        }
    }
}


// MARK: - Instance observation

public extension Observation {
    public mutating func on(name: String, from object: AnyObject, _ block: (NSNotification) -> Void) {
        add(NotificationObserver(name: name, object: object, block: block))
    }

    public mutating func on <T: AnyObject> (name: String, from object: AnyObject, _ observer: T, _ block: (T) -> (NSNotification) -> Void) {
        weak var weakObserver: T? = observer
        on(name, from: object) { notification in
            if let observer = weakObserver {
                block(observer)(notification)
            }
        }
    }

    public mutating func on <T: AnyObject> (name: String, from object: AnyObject, _ observer: T, _ block: (T) -> () -> Void) {
        weak var weakObserver: T? = observer
        on(name, from: object) { notification in
            if let observer = weakObserver {
                block(observer)()
            }
        }
    }
}


// MARK: -

private class NotificationObserver: NSObject, ListenerType {
    let name: String  // for debugging purposes
    let block: (NSNotification) -> Void

    init(name: String, object: AnyObject? = nil, block: (NSNotification) -> Void) {
        self.name = name
        self.block = block
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(NotificationObserver.trigger(_:)), name: name, object: object)
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    @objc func trigger(notification: NSNotification) {
        block(notification)
    }
}


public extension NSObject {

    public func postNotification(name: String) {
        NSNotificationCenter.defaultCenter().postNotificationName(name, object: self)
    }
    
}
