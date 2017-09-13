//
//  ShopsTests.swift
//  MadridShopsTests
//
//  Created by MIGUEL JARDÓN PEINADO on 9/9/17.
//  Copyright © 2017 Ammyt. All rights reserved.
//

import XCTest
import MadridShops
// Si ponemos @testable antes del import, los símbolos que no sean public, los hace
// visibles para el test

class ShopsTests: XCTestCase {

    func testGivenEmptyShopsNumberShopsIsZero() {
        // sut = system under test
        let sut = Shops()
        XCTAssertEqual(0, sut.count())
    }
    
    func testGivenShopsWithOneElementNumberShopsIsOne() {
        let sut = Shops()
        sut.add(shop: Shop(name: "TestShop"))
        XCTAssertEqual(1, sut.count())
    }
}
