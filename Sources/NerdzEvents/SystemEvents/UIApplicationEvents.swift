//
//  UIApplication+Events.swift
//  NerdzEvents
//
//  Created by new user on 30.10.2020.
//

#if canImport(UIKit)

import UIKit

extension UIApplication {
    var events: UIApplicationEvents {
        .events
    }
}

/// Class that represents standard events triggered by `UIApplication`
public final class UIApplicationEvents {
    
    /// Singleton instance
    public static let events = UIApplicationEvents()
    
    /// `UIApplication.didBecomeActiveNotification` event
    public let didBecomeActiveEvent = Event<Void>()
    
    /// `UIApplication.didEnterBackgroundNotification` event
    public let didEnterBackgroundEvent = Event<Void>()
    
    /// `UIApplication.didFinishLaunchingNotification` event
    public let didFinishLaunchingEvent = Event<Void>()
    
    /// `UIApplication.willEnterForegroundNotification` event
    public let willEnterForegroundEvent = Event<Void>()
    
    /// `UIApplication.willResignActiveNotification` event
    public let willResignActiveEvent = Event<Void>()
    
    /// `UIApplication.didReceiveMemoryWarningNotification` event
    public let didReceiveMemoryWarningEvent = Event<Void>()
    
    /// `UIApplication.willTerminateNotification` event
    public let willTerminateEvent = Event<Void>()
    
    /// `UIApplication.significantTimeChangeNotification` event
    public let significantTimeChangeEvent = Event<Void>()
    
    /// `UIApplication.backgroundRefreshStatusDidChangeNotification` event
    public let backgroundRefreshStatusDidChangeEvent = Event<Void>()
    
    /// `UIApplication.protectedDataWillBecomeUnavailableNotification` event
    public let protectedDataWillBecomeUnavailableEvent = Event<Void>()
    
    /// `UIApplication.protectedDataDidBecomeAvailableNotification` event
    public let protectedDataDidBecomeAvailableEvent = Event<Void>()
    
    private init() {
        subscribe()
    }
    
    fileprivate func subscribe() {
        let center = NotificationCenter.default
        
        center.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: .main) { [weak self] _ in
            self?.didBecomeActiveEvent.trigger(with: ())
        }
        
        center.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: .main) { [weak self] _ in
            self?.didEnterBackgroundEvent.trigger(with: ())
        }
        
        center.addObserver(forName: UIApplication.didFinishLaunchingNotification, object: nil, queue: .main) { [weak self] _ in
            self?.didFinishLaunchingEvent.trigger(with: ())
        }
        
        center.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [weak self] _ in
            self?.willEnterForegroundEvent.trigger(with: ())
        }
        
        center.addObserver(forName: UIApplication.willResignActiveNotification, object: nil, queue: .main) { [weak self] _ in
            self?.willResignActiveEvent.trigger(with: ())
        }
        
        center.addObserver(forName: UIApplication.didReceiveMemoryWarningNotification, object: nil, queue: .main) { [weak self] _ in
            self?.didReceiveMemoryWarningEvent.trigger(with: ())
        }
        
        center.addObserver(forName: UIApplication.willTerminateNotification, object: nil, queue: .main) { [weak self] _ in
            self?.willTerminateEvent.trigger(with: ())
        }
        
        center.addObserver(forName: UIApplication.significantTimeChangeNotification, object: nil, queue: .main) { [weak self] _ in
            self?.significantTimeChangeEvent.trigger(with: ())
        }
        
        center.addObserver(forName: UIApplication.backgroundRefreshStatusDidChangeNotification, object: nil, queue: .main) { [weak self] _ in
            self?.backgroundRefreshStatusDidChangeEvent.trigger(with: ())
        }
        
        center.addObserver(forName: UIApplication.protectedDataWillBecomeUnavailableNotification, object: nil, queue: .main) { [weak self] _ in
            self?.protectedDataWillBecomeUnavailableEvent.trigger(with: ())
        }
        
        center.addObserver(forName: UIApplication.protectedDataDidBecomeAvailableNotification, object: nil, queue: .main) { [weak self] _ in
            self?.protectedDataDidBecomeAvailableEvent.trigger(with: ())
        }
    }
}

#endif
