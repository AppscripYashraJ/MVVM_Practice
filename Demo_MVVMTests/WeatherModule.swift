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

    func test_validCountryName(){
        let validCountryName = "China"
        sut.initFetchData(validCountryName)
        XCTAssertEqual(validCountryName, sut.countryName)
        XCTAssertNotNil(sut.countryName)
        XCTAssertNotNil(sut.weatherDescription)
        XCTAssertNotNil(sut.temperature)
    }
    
    func test_ValidVMData(){
        let validCountryNAme = "China"
        let validWeatherDescription = "Scattered Clouds"
        let validTemp = "26.38º Celcius"
        sut.initFetchData(validCountryNAme)
        
        XCTAssertEqual(validCountryNAme, sut.countryName)
        XCTAssertEqual(validWeatherDescription, sut.weatherDescription)
        XCTAssertEqual(validTemp, sut.temperature)
    }
}

