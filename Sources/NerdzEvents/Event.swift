//
//  Event.swift
//

import Foundation

public class Event<State> {
    private enum Token: Hashable {
        case string(String)
        case object(AnyObject)

        static func ==(lhs: Token, rhs: Token) -> Bool {
            switch (lhs, rhs) {
            case (.string(let lhs), .string(let rhs)): return lhs == rhs
            case (.object(let lhs), .object(let rhs)): return udid(for: lhs) == udid(for: rhs)
            default: return false
            }
        }

        func hash(into hasher: inout Hasher) {
            switch self {
            case .string(let string): hasher.combine(string)
            case .object(let object): hasher.combine(Token.udid(for: object))
            }
        }

        fileprivate static func udid(for object: AnyObject) -> UInt {
            return UInt(bitPattern: ObjectIdentifier(object))
        }
    }

    public var hasListeners: Bool {
        return !listeners.isEmpty
    }
    
    private var listeners: [Token: Listener<State>] = [:]
    
    public init() { }

    public func trigger(with state: State) {
        for listener in listeners.values {
            listener.trigger(with: state)
        }
    }

    @discardableResult
    public func listen(signedBy object: AnyObject? = nil) -> Listener<State> {
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

    @discardableResult
    public func removeListener(signedBy: AnyObject) -> Bool {
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
