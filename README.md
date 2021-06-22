# NerdzEvents

NerdzEvents library provides an easy way to creating, subscribing, and triggering events. The approach is similar to `RxSwift` `Observables`.

## [Documentation](https://nerdzevents.web.app)

## Example

### Creating an event

In example we will create an event that will be triggering with `Int` value as a state

```swift
let likesCountChangedEvent = Event<Int>()
```

### Creating `Void` event

In case you do not need any state, and just need to inform about some situation - you need to use `()` as a parameter

```swift
let userLoggedOutEvent = Event<()>()
```

### Subscribing to event

To start listening to the event, you should use `listen` method 

If you will pass `signedBy` object - listener will be unique per object(this might help to avoid multiple subscriptions to single event, that might lead into incorrect behaviour)

As the result of method, you will receive `Listener` class responsible for setup of subscription, and has a list of useful settings. Follow doc for more information

```swift
let listener = likesCountChangedEvent
    .listen(signedBy: self) // Should always be as a first call to receive listener for future setup
    .onQueue(.main) // Specifying a queue on witch action will be performed
    .once() // Will be triggered only once
    .filter { $0 > 100 } // Filtering out all triggers that have state <= 100
    .perform { print("Receiving all events when count become higher than 100") } // Specifying performing closure
```

### Unsubscribing from event manually

To unsubscribe from event you can use `DisposeBag` or manually by method `removeListener`

```swift
likesCountChangedEvent.removeListener(signedBy: self)
```

### Unsubscribing from event by `DisposeBag`

`DisposeBag` allow you to automatically unsubscribe from event when object will be deleted. use this approach when you need subscription during all life on an object

```swift
let disposeBag = DisposeBag()

likesCountChangedEvent
    .listen(signedBy: self)
    .dispose(by: disposeBag)
    .perform { // }
```

## Installation Swift Package Manager

To add NerdzEvents to a [Swift Package Manager](https://swift.org/package-manager/) based project, add:

```swift
.package(url: "https://github.com/nerdzlab/NerdzEvents")
```

## License

This code is distributed under the MIT license. See the `LICENSE` file for more info.
