//
//  EventTracker.swift
//  Muslim Quiz
//
//  Created by mOBSCENE on 05/10/2019.
//  Copyright © 2019 Amin Benarieb. All rights reserved.
//

import Foundation

protocol EventTrackerProtocol {
    func track(eventName: String, properties: [String :Any])
    func track(event: Event)
}

final class EventTracker: EventTrackerProtocol {
    
    func track(eventName: String, properties: [String : Any]) {
        print("!! eventName = \(eventName) properties = \(properties)")
    }
    
    func track(event: Event) {
        print("!! tracked = ", event)
    }
    
}
