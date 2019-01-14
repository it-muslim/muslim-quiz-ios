//
//  DataSnapshot.swift
//  Muslim Quiz
//
//  Created by Amin Benarieb on 13/01/2019.
//  Copyright © 2019 Amin Benarieb. All rights reserved.
//

import Firebase

extension DataSnapshot {
    typealias JSON = [String: Any]
    
    var JSONItem : JSON? {
        guard var item = self.value as? JSON else {
            return nil
        }
        
        item["identifier"] = self.key
        return item
    }
    
}
