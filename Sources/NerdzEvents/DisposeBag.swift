//
//  DisposeBag.swift
//

import Foundation

/// Bag for automatic disposal
/// Dispose bag is disposing all registered disposers when is deinited
/// So if you need an event only in some object - jsut create a dispose bag as an instance of that object and listener will be automaticaly when your object will be deinited
public class DisposeBag {
    private var disposers: [Disposer] = []
    
    /// Registering disposer for automatic dispose
    /// - Parameter disposer: Registration disposer
    public func addDisposer(_ disposer: Disposer) {
        disposers.append(disposer)
    }
    
    /// Forcing disposing of all registered disposers
    public func disposeAll() {
        for disposer in disposers {
            disposer.dispose()
        }
    }
    
    public init() { }

    deinit {
        disposeAll()
    }
}
