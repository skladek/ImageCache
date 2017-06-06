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
            var mockNSCache: MockNSCache!
            var unitUnderTest: ImageCache!
            var url: URL!

            beforeEach {
                mockNSCache = MockNSCache()
                url = URL(string: "http://example.url/image1.png")!
                unitUnderTest = ImageCache(cache: mockNSCache)
            }

            context("init()") {
                it("Should set a cache") {
                    unitUnderTest = ImageCache()
                    expect(unitUnderTest.cache).toNot(beNil())
                }
            }

            context("cacheImage(_:forURL:)") {
                it("Should not call set object on the cache if the image is nil") {
                    unitUnderTest.cacheImage(nil, forURL: url)
                    expect(mockNSCache.setObjectCalled).to(beFalse())
                }

                it("Should call set object on the cache if an image is provided") {
                    let bundle = Bundle(for: type(of: self))
                    let image = UIImage(named: "testimage", in: bundle, compatibleWith: nil)
                    unitUnderTest.cacheImage(image, forURL: url)
                    expect(mockNSCache.setObjectCalled).to(beTrue())
                }
            }

            context("emptyCache()") {
                it("Should remove all items from the cache") {
                    unitUnderTest.emptyCache()
                    expect(mockNSCache.removeAllObjectsCalled).to(beTrue())
                }
            }

            context("getImage(url:skipCache:completion:)") {
                it("Should check the cache for an image") {
                    mockNSCache.shouldReturnImage = true
                    let _ = unitUnderTest.getImage(url: url, completion: { (_, _, _) in })
                    expect(mockNSCache.objectForKeyCalled).to(beTrue())
                }

                it("Should return a cached image through the closure if one exists") {
                    mockNSCache.shouldReturnImage = true
                    let _ = unitUnderTest.getImage(url: url, completion: { (image, _, _) in
                        expect(image).toNot(beNil())
                    })
                }

                it("Should return true for the from cache value if an image is returned from the cache") {
                    mockNSCache.shouldReturnImage = true
                    let _ = unitUnderTest.getImage(url: url, completion: { (_, fromCache, _) in
                        expect(fromCache).to(beTrue())
                    })
                }
            }
        }
    }
}
