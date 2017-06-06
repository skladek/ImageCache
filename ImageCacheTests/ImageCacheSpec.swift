//
//  ImageCacheTests.swift
//  ImageCacheTests
//
//  Created by Sean on 6/6/17.
//  Copyright © 2017 Sean Kladek. All rights reserved.
//

import Foundation
import Nimble
import Quick

@testable import ImageCache

class ImageCacheSpec: QuickSpec {
    override func spec() {
        describe("ImageCache") {
            context("none") {
                it("Should pass") {
                    expect(1).to(equal(1))
                }
            }
        }
    }
}
