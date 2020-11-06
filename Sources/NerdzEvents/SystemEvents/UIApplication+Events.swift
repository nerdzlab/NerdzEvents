//
//  UIApplication+Events.swift
//  NerdzEvents
//
//  Created by new user on 30.10.2020.
//

import UIKit

extension UIApplication {
    var events: UIApplicationEvents {
        let events = UIApplicationEvents.events
        events.subscribeIfNeeded()
        return events
    }
}


public final class UIApplicationEvents {
    fileprivate static let events = UIApplicationEvents()
    
    public let didBecomeActiveEvent = Event<Void>()
    public let didEnterBackgroundEvent = Event<Void>()
    public let didFinishLaunchingEvent = Event<Void>()
    public let willEnterForegroundEvent = Event<Void>()
    public let willResignActiveEvent = Event<Void>()
    public let didReceiveMemoryWarningEvent = Event<Void>()
    public let willTerminateEvent = Event<Void>()
    public let significantTimeChangeEvent = Event<Void>()
    public let backgroundRefreshStatusDidChangeEvent = Event<Void>()
    public let protectedDataWillBecomeUnavailableEvent = Event<Void>()
    public let protectedDataDidBecomeAvailableEvent = Event<Void>()
    
    private var isSubscribed: Bool = false
    
    private init() {}
    
    fileprivate func subscribeIfNeeded() {
        guard !isSubscribed else {
            return
        }
        
        let center = NotificationCenter.default
        
        center.addObserver(forName: UIApplication.didBecomeActiveNotification, object: self, queue: .main) { [weak self] _ in
            self?.didBecomeActiveEvent.trigger(with: ())
        }
        
        center.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: self, queue: .main) { [weak self] _ in
            self?.didEnterBackgroundEvent.trigger(with: ())
        }
        
        center.addObserver(forName: UIApplication.didFinishLaunchingNotification, object: self, queue: .main) { [weak self] _ in
            self?.didFinishLaunchingEvent.trigger(with: ())
        }
        
        center.addObserver(forName: UIApplication.willEnterForegroundNotification, object: self, queue: .main) { [weak self] _ in
            self?.willEnterForegroundEvent.trigger(with: ())
        }
        
        center.addObserver(forName: UIApplication.willResignActiveNotification, object: self, queue: .main) { [weak self] _ in
            self?.willResignActiveEvent.trigger(with: ())
        }
        
        center.addObserver(forName: UIApplication.didReceiveMemoryWarningNotification, object: self, queue: .main) { [weak self] _ in
            self?.didReceiveMemoryWarningEvent.trigger(with: ())
        }
        
        center.addObserver(forName: UIApplication.willTerminateNotification, object: self, queue: .main) { [weak self] _ in
            self?.willTerminateEvent.trigger(with: ())
        }
        
        center.addObserver(forName: UIApplication.significantTimeChangeNotification, object: self, queue: .main) { [weak self] _ in
            self?.significantTimeChangeEvent.trigger(with: ())
        }
        
        center.addObserver(forName: UIApplication.backgroundRefreshStatusDidChangeNotification, object: self, queue: .main) { [weak self] _ in
            self?.backgroundRefreshStatusDidChangeEvent.trigger(with: ())
        }
        
        center.addObserver(forName: UIApplication.protectedDataWillBecomeUnavailableNotification, object: self, queue: .main) { [weak self] _ in
            self?.protectedDataWillBecomeUnavailableEvent.trigger(with: ())
        }
        
        center.addObserver(forName: UIApplication.protectedDataDidBecomeAvailableNotification, object: self, queue: .main) { [weak self] _ in
            self?.protectedDataDidBecomeAvailableEvent.trigger(with: ())
        }
        
        isSubscribed = true
    }
}
