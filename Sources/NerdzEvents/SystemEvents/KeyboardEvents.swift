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
    }
    
    public static let events = KeyboardEvents()
    
    public let keyboardWillShowEVent = Event<Info>()
    public let keyboardDidShowEvent = Event<Info>()
    public let keyboardWillHideEvent = Event<Info>()
    public let keyboardDidHideEvent = Event<Info>()
    
    private init() {
        subscribe()
    }
    
    fileprivate func subscribe() {
        
        let center = NotificationCenter.default
        
        center.addObserver(forName: UIResponder.keyboardWillShowNotification, object: self, queue: .main) { [weak self] in
            guard let self = self else {
                return
            }
            
            self.keyboardWillShowEVent.trigger(with: self.info(from: $0))
        }
        
        center.addObserver(forName: UIResponder.keyboardDidShowNotification, object: self, queue: .main) { [weak self] in
            guard let self = self else {
                return
            }
            
            self.keyboardDidShowEvent.trigger(with: self.info(from: $0))
        }
        
        center.addObserver(forName: UIResponder.keyboardWillHideNotification, object: self, queue: .main) { [weak self] in
            guard let self = self else {
                return
            }
            
            self.keyboardWillHideEvent.trigger(with: self.info(from: $0))
        }
        
        center.addObserver(forName: UIResponder.keyboardDidHideNotification, object: self, queue: .main) { [weak self] in
            guard let self = self else {
                return
            }
            
            self.keyboardDidHideEvent.trigger(with: self.info(from: $0))
        }
    }
    
    private func info(from notification: Notification) -> Info {
        let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt ?? 0
        let startFrame = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
        let endFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? .zero
        
        return Info(duration: duration, curve: curve, beginFrame: startFrame, endFrame: endFrame, notification: notification)
    }
}
