//
//  PokemonDetailsViewModelTests.swift
//  GotchaTests
//
//  Created by Majka on 05/02/2023.
//

import XCTest
@testable import Gotcha

final class PokemonDetailsViewModelTests: XCTestCase {
    
    var sut: PokemonDetailsViewModel!
    var mockDelegate: MockPokemonDetailsViewModelDelegate!
    var mockService: MockPokemonApiService!

    override func setUpWithError() throws {
        mockService = MockPokemonApiService()
        mockDelegate = MockPokemonDetailsViewModelDelegate()
        sut = PokemonDetailsViewModel(urlString: "", service: mockService)
        sut.delegate = mockDelegate
    }

    override func tearDownWithError() throws {
        sut = nil
        mockService = nil
        mockDelegate = nil
    }

    func testGetPokemonDetailsSuccess() {
        // given
        let jsonData = StaticJSONReader().readJSON(forName: "PokemonExample")!
        let model = try! JSONDecoder().decode(PokemonModel.self, from: jsonData)
        mockService.mockPokemonDetailsResult = .success(model)
        
        // when
        sut.getPokemonDetails()
        
        // then
        XCTAssertTrue(mockDelegate.onDetailsModelFetchSuccessCalled, "delegate should call onDetailsModelFetchSuccess")
        XCTAssertEqual(sut.detailsModel?.id, 132)
    }
    
    func testGetPokemonDetailsFailure() {
        // given
        mockService.mockPokemonDetailsResult = .failure(MockPokemonApiServiceError.genericFailure)
        
        // when
        sut.getPokemonDetails()
        
        // then
        XCTAssertTrue(mockDelegate.onDetailsModelFetchFailureCalled)
        XCTAssertEqual(mockDelegate.lastErrorString, "genericFailure")
    }
    
}
