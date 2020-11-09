//
//  DisposeBag.swift
//

import Foundation

public class DisposeBag {
    private var disposers: [Disposer] = []

    public func addDisposer(_ disposer: Disposer) {
        disposers.append(disposer)
    }

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
