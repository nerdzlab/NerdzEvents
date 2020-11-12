//
//  UIApplication+Events.swift
//  NerdzEvents
//
//  Created by new user on 30.10.2020.
//

import UIKit

extension UIApplication {
    var events: UIApplicationEvents {
        .events
    }
}


public final class UIApplicationEvents {
    public static let events = UIApplicationEvents()
    
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
