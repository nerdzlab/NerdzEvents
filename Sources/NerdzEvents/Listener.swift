//
//  Listener.swift
//

import Foundation

/// Represent a single listener settings
public class Listener<State> {
    private var notifyClosures: [(State) -> Void] = []

    private(set) var filteringClosures: [(State) -> Bool] = []
    private(set) var dispatchQueue: DispatchQueue = .main
    private(set) var dispatchOnce: Bool = false
    
    /// Listener disposer. Follow `Disposer` documentation for more info
    public let disposer: Disposer
    
    init(disposer: Disposer) {
        self.disposer = disposer
    }

    // MARK: - Methods(Public)
    
    /// Notifying listener with new information
    /// - Parameter state: New information send from `Event`
    public func trigger(with state: State) {
        guard filteringClosures.first(where: { $0(state) == false }) == nil else {
            return
        }
        
        dispatchQueue.async {
            self.notifyClosures.forEach { $0(state) }
        }

        if dispatchOnce {
            disposer.dispose()
        }
    }

    // MARK: - Methods(Confuguration)
    
    /// Specifying queue on what event needs to be triggered
    /// - Parameter queue: Execution queue. By default is `.main`
    /// - Returns: Same listener for next setup
    @discardableResult public func onQueue(_ queue: DispatchQueue) -> Listener<State> {
        dispatchQueue = queue
        return self
    }
    
    /// SPecifying if event need to be triggered only once
    /// - Returns: Same listener for next setup
    @discardableResult public func once() -> Listener<State> {
        dispatchOnce = true
        return self
    }
    
    /// Filtering out triggers based on new information
    /// - Parameter closure: Filtering closure. Should return true if event needs to be triggered
    /// - Returns: Same listener for next setup
    @discardableResult public func filter(by closure: @escaping (State) -> Bool) -> Listener<State> {
        filteringClosures.append(closure)
        return self
    }
    
    /// Providing a closure that needs to be triggered
    /// - Parameter closure: Triggering closure
    /// - Returns: Same listener for next setup
    @discardableResult public func perform(_ closure: @escaping (State) -> Void) -> Listener<State> {
        self.notifyClosures.append(closure)
        return self
    }
    
    /// Binding listener to event that have same `State`
    /// - Parameter event: Binding event
    /// - Returns: Same listener for next setup
    @discardableResult public func bind(to event: Event<State>) -> Listener<State> {
        return perform({ event.trigger(with: $0) })
    }
    
    /// Providing dispose bag for automatic disposing
    /// - Parameter disposeBag: Dispose bag
    /// - Returns: Same listener for next setup
    @discardableResult public func dispose(by disposeBag: DisposeBag) -> Listener<State> {
        disposeBag.addDisposer(disposer)
        return self
    }
}

extension Listener where State: Equatable {
    /// Filtering triggers based on list of values if `State` conform to `Equatable`
    /// - Parameter values: Values that will allow triggering
    public func filter(by values: State...) {
        filter(by: { values.contains($0) })
    }
}
