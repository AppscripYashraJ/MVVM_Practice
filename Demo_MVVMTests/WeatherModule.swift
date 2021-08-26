//
//  WeatherModule.swift
//  Demo_MVVMTests
//
//  Created by Rahul Sharma on 25/08/21.
//  Copyright © 2021 Rahul Sharma. All rights reserved.
//

import XCTest
@testable import Demo_MVVM

class WeatherModule: XCTestCase {
    
    var sut: APIService?
    override func setUp() {
        super.setUp()
        sut = APIService()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_API_Service_fetchWeatherData_success() {
        let expect = XCTestExpectation(description: "callback")
        sut?.loadWeatherData(countryName: "China", completion: { (data) in
            expect.fulfill()
            XCTAssertNotNil(data)
            if let data = data {
                XCTAssertEqual(data.name, "China")
            }
        })
        wait(for: [expect], timeout: 5.0)
    }
}

class WeatherViewModelTest: XCTestCase {
    var sut: WeatherViewModel!
    var mockServiceAPI : MockAPIService!
    override func setUp() {
        super.setUp()
        mockServiceAPI = MockAPIService()
        sut = WeatherViewModel(apiService: mockServiceAPI)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func adb(){
        sut.initFetchData("India")
    }
}


class MockAPIService:WeatherLoaderProtocol {
    
    var completionClosure: ((Weather) -> ())?
    func loadWeatherData(countryName: String, completion: @escaping (Weather?) -> Void) {
        completionClosure = completion
    }
}
