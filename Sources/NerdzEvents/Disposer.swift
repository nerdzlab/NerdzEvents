//
//  Disposer.swift
//

import Foundation

public class Disposer {
    private let disposeAction: () -> Void

    public init(_ disposeAction: @escaping () -> Void) {
        self.disposeAction = disposeAction
    }

    public func add(to bag: DisposeBag) {
        bag.addDisposer(self)
    }

    public func dispose() {
        disposeAction()
    }
}
