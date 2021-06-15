//
//  Event.swift
//

import Foundation

/// Event representation class. 
/// You need to create an instance of event and then bind on it and trigger
/// `State` is a generic parameter that specify a type of information that current event might send to listeners
public class Event<State> {
    private struct Token: Hashable {
        private let string: String?
        private let objectId: UInt?
        
        static func string(_ value: String) -> Self {
            Self(string: value, objectId: nil)
        }
        
        static func object(_ object: AnyObject) -> Self {
            Self(string: nil, objectId: Self.udid(for: object))
        }
        
        static func ==(lhs: Token, rhs: Token) -> Bool {
            lhs.string == rhs.string && lhs.objectId == rhs.objectId
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(string)
            hasher.combine(objectId)
        }

        fileprivate static func udid(for object: AnyObject) -> UInt {
            return UInt(bitPattern: ObjectIdentifier(object))
        }
    }
    
    /// `true` if current event have at least one listener
    public var hasListeners: Bool {
        return !listeners.isEmpty
    }
    
    private var listeners: [Token: Listener<State>] = [:]
    
    /// Main initializer
    public init() { }
    
    /// Method that will trigger information notifying to all listeners
    /// - Parameter state: An information that needs to be send to listeners
    public func trigger(with state: State) {
        for listener in listeners.values {
            listener.trigger(with: state)
        }
    }
    
    /// Adding new listener to current event
    /// - Parameter object: Signing object. Might be only one subscription per one object. Useful if you want to be sure that you have not subscribed several times to similar event with one object
    /// - Returns: Listener that might be additionaly configured
    @discardableResult public func listen(signedBy object: AnyObject? = nil) -> Listener<State> {
        let token: Token

        if let object = object {
            token = .object(object)
        } else {
            token = .string(.random())
        }

        let disposer = Disposer { [weak self] in
            self?.removeListener(with: token)
        }

        let listener = Listener<State>(disposer: disposer)

        listeners[token] = listener

        return listener
    }
    
    /// Removing listener signed with object
    /// - Parameter signedBy: Signing object
    /// - Returns: `true` if listener was successfuly removed
    @discardableResult public func removeListener(signedBy: AnyObject) -> Bool {
        return removeListener(with: Token.object(signedBy))
    }

    @discardableResult
    private func removeListener(with token: Token) -> Bool {
        return listeners.removeValue(forKey: token) != nil
    }
}

fileprivate extension String {
    static func random() -> String {
        return UUID().uuidString
    }
}
