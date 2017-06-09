//
//  MockNSCache.swift
//  ImageCache
//
//  Created by Sean on 6/6/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import Foundation
import UIKit

open class MockNSCache: NSCache<AnyObject, UIImage> {
    var objectForKeyCalled = false
    var removeAllObjectsCalled = false
    var removeObjectCalled = false
    var setObjectCalled = false
    var shouldReturnImage = false

    open override func object(forKey key: AnyObject) -> UIImage? {
        objectForKeyCalled = true

        let bundle = Bundle(for: type(of: self))
        let image = UIImage(named: "testimage", in: bundle, compatibleWith: nil)

        return shouldReturnImage ? image : nil
    }

    open override func removeAllObjects() {
        removeAllObjectsCalled = true
    }

    open override func removeObject(forKey key: AnyObject) {
        removeObjectCalled = true
    }

    open override func setObject(_ obj: UIImage, forKey key: AnyObject) {
        setObjectCalled = true
    }
}
