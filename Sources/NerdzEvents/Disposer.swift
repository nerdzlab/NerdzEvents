//
//  Disposer.swift
//

import Foundation

/// Class responsible for disposing listeners
/// Incapsulate a single action of disposing
public class Disposer {
    private let disposeAction: () -> Void
    
    init(_ disposeAction: @escaping () -> Void) {
        self.disposeAction = disposeAction
    }
    
    /// Adding disposed to the bag for automatic disposal
    /// - Parameter bag: Dispose bag
    public func add(to bag: DisposeBag) {
        bag.addDisposer(self)
    }
    
    /// Dispose
    public func dispose() {
        disposeAction()
    }
}
