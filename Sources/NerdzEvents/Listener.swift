//
//  Listener.swift
//

import Foundation

public class Listener<State> {
    private var notifyClosures: [(State) -> Void] = []

    private(set) var filteringClosures: [(State) -> Bool] = []
    private(set) var dispatchQueue: DispatchQueue = .main
    private(set) var dispatchOnce: Bool = false

    public let disposer: Disposer

    public init(disposer: Disposer) {
        self.disposer = disposer
    }

    // MARK: - Methods(Public)

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

    @discardableResult
    public func onQueue(_ queue: DispatchQueue) -> Listener<State> {
        dispatchQueue = queue
        return self
    }

    @discardableResult
    public func once() -> Listener<State> {
        dispatchOnce = true
        return self
    }
    
    @discardableResult
    public func filter(by closure: @escaping (State) -> Bool) -> Listener<State> {
        filteringClosures.append(closure)
        return self
    }

    @discardableResult
    public func call(_ closure: @escaping (State) -> Void) -> Listener<State> {
        self.notifyClosures.append(closure)
        return self
    }

    @discardableResult
    public func bind(to event: Event<State>) -> Listener<State> {
        return call({ event.trigger(with: $0) })
    }

    @discardableResult
    public func dispose(by disposeBag: DisposeBag) -> Listener<State> {
        disposeBag.addDisposer(disposer)
        return self
    }
}

extension Listener where State: Equatable {
    public func filter(by values: State...) {
        filter(by: { values.contains($0) })
    }
}
