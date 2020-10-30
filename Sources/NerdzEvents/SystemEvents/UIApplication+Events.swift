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
    
    public let didBecomeActiveEvent = Event(())
    public let didEnterBackgroundEvent = Event(())
    public let didFinishLaunchingEvent = Event(())
    public let willEnterForegroundEvent = Event(())
    public let willResignActiveEvent = Event(())
    public let didReceiveMemoryWarningEvent = Event(())
    public let willTerminateEvent = Event(())
    public let significantTimeChangeEvent = Event(())
    public let backgroundRefreshStatusDidChangeEvent = Event(())
    public let protectedDataWillBecomeUnavailableEvent = Event(())
    public let protectedDataDidBecomeAvailableEvent = Event(())
    
    private var isSubscribed: Bool = false
    
    private init() {}
    
    fileprivate func subscribeIfNeeded() {
        guard !isSubscribed else {
            return
        }
        
        let center = NotificationCenter.default
        
        center.addObserver(forName: UIApplication.didBecomeActiveNotification, object: self, queue: .main) { [weak self] _ in
            self?.didBecomeActiveEvent.trigger()
        }
        
        center.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: self, queue: .main) { [weak self] _ in
            self?.didEnterBackgroundEvent.trigger()
        }
        
        center.addObserver(forName: UIApplication.didFinishLaunchingNotification, object: self, queue: .main) { [weak self] _ in
            self?.didFinishLaunchingEvent.trigger()
        }
        
        center.addObserver(forName: UIApplication.willEnterForegroundNotification, object: self, queue: .main) { [weak self] _ in
            self?.willEnterForegroundEvent.trigger()
        }
        
        center.addObserver(forName: UIApplication.willResignActiveNotification, object: self, queue: .main) { [weak self] _ in
            self?.willResignActiveEvent.trigger()
        }
        
        center.addObserver(forName: UIApplication.didReceiveMemoryWarningNotification, object: self, queue: .main) { [weak self] _ in
            self?.didReceiveMemoryWarningEvent.trigger()
        }
        
        center.addObserver(forName: UIApplication.willTerminateNotification, object: self, queue: .main) { [weak self] _ in
            self?.willTerminateEvent.trigger()
        }
        
        center.addObserver(forName: UIApplication.significantTimeChangeNotification, object: self, queue: .main) { [weak self] _ in
            self?.significantTimeChangeEvent.trigger()
        }
        
        center.addObserver(forName: UIApplication.backgroundRefreshStatusDidChangeNotification, object: self, queue: .main) { [weak self] _ in
            self?.backgroundRefreshStatusDidChangeEvent.trigger()
        }
        
        center.addObserver(forName: UIApplication.protectedDataWillBecomeUnavailableNotification, object: self, queue: .main) { [weak self] _ in
            self?.protectedDataWillBecomeUnavailableEvent.trigger()
        }
        
        center.addObserver(forName: UIApplication.protectedDataDidBecomeAvailableNotification, object: self, queue: .main) { [weak self] _ in
            self?.protectedDataDidBecomeAvailableEvent.trigger()
        }
        
        isSubscribed = true
    }
}
