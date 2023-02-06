//
//  AboutViewModelTests.swift
//  GotchaTests
//
//  Created by Majka on 05/02/2023.
//

import XCTest
@testable import Gotcha

final class AboutViewModelTests: XCTestCase {
    
    var sut: AboutViewModel!
    var mockDelegate: MockAboutViewModelDelegate!
    var mockService: MockPokemonApiService!

    override func setUpWithError() throws {
        mockDelegate = MockAboutViewModelDelegate()
        mockService = MockPokemonApiService()
        sut = AboutViewModel(service: mockService)
        sut.delegate = mockDelegate
    }

    override func tearDownWithError() throws {
        sut = nil
        mockService = nil
        mockDelegate = nil
    }

    func testOnDetailsModelSet() {
        // given
        let jsonData = StaticJSONReader().readJSON(forName: "PokemonExample")!
        let model = try! JSONDecoder().decode(PokemonModel.self, from: jsonData)
        
        // when
        sut.set(model: model)
        
        // then
        XCTAssertTrue(mockDelegate.onDetailsModelSetCalled, "delegate should call onDetailsModelSet")
        XCTAssertEqual(model.id, 132)
    }
    
    func testOnAbilityDetailsSuccess() {
        // given
        let jsonData = StaticJSONReader().readJSON(forName: "AbilityExample")!
        let model = try! JSONDecoder().decode(AbilityModel.self, from: jsonData)
        mockService.mockAbilityDetailsResult = .success(model)
        
        // when
        sut.getAbilityDetails(for: "")
        
        // then
        XCTAssertTrue(mockDelegate.onAbilityDetailsSuccessCalled, "delegate should call onAbilityDetailsSuccess")
        XCTAssertEqual(model.name, "limber")
    }

    func testOnAbilityDetailsFailure() {
        // given
        mockService.mockAbilityDetailsResult = .failure(MockPokemonApiServiceError.genericFailure)
        
        // when
        sut.getAbilityDetails(for: "")
        
        // then
        XCTAssertTrue(mockDelegate.onAbilityDetailsFailureCalled, "delegate should call onAbilityDetailFailure")
        XCTAssertEqual(mockDelegate.lastErrorString, "genericFailure")
    }
}
