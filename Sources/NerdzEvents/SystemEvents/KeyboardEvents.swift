//
//  Keyboard+Events.swift
//  NerdzEvents
//
//  Created by new user on 08.11.2020.
//

import UIKit

public final class KeyboardEvents {
    public struct Info {
        public let duration: Double
        public let curve: UInt
        public let beginFrame: CGRect
        public let endFrame: CGRect
        
        public let notification: Notification
        
        init(_ notification: Notification) {
            self.notification = notification
            
            duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
            curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt ?? 0
            beginFrame = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
            endFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
        }
    }
    
    public static let events = KeyboardEvents()
    
    public let keyboardWillShowEvent = Event<Info>()
    public let keyboardDidShowEvent = Event<Info>()
    public let keyboardWillHideEvent = Event<Info>()
    public let keyboardDidHideEvent = Event<Info>()
    
    private init() {
        subscribe()
    }
    
    fileprivate func subscribe() {
        
        let center = NotificationCenter.default
        
        center.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { [weak self] in
            guard let self = self else {
                return
            }
            
            self.keyboardWillShowEvent.trigger(with: self.info(from: $0))
        }
        
        center.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: .main) { [weak self] in
            guard let self = self else {
                return
            }
            
            self.keyboardDidShowEvent.trigger(with: self.info(from: $0))
        }
        
        center.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { [weak self] in
            guard let self = self else {
                return
            }
            
            self.keyboardWillHideEvent.trigger(with: self.info(from: $0))
        }
        
        center.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: .main) { [weak self] in
            guard let self = self else {
                return
            }
            
            self.keyboardDidHideEvent.trigger(with: self.info(from: $0))
        }
    }
    
    private func info(from notification: Notification) -> Info {
        return Info(notification)
    }
}
