//
//  SearchViewModelTests.swift
//  GotchaTests
//
//  Created by Majka on 05/02/2023.
//

import XCTest
@testable import Gotcha

final class SearchViewModelTests: XCTestCase {
    var sut: SearchViewModel!
    var mockDelegate: MockSearchViewModelDelegate!
    var mockService: MockPokemonApiService!
    

    override func setUpWithError() throws {
        mockService = MockPokemonApiService()
        mockDelegate = MockSearchViewModelDelegate()
        sut = SearchViewModel(service: mockService)
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
        sut.getPokemonDetails(withUrlString: "")
        
        // then
        XCTAssertTrue(mockDelegate.onDetailsModelFetchSuccessCalled, "delegate should call onDetailsModelFetchSuccess")
        XCTAssertEqual(sut.detailsModel?.id, 132)
    }

    func testGetPokemonDetailsFailure() {
        // given
        mockService.mockPokemonDetailsResult = .failure(MockPokemonApiServiceError.genericFailure)
        
        // when
        sut.getPokemonDetails(withUrlString: "")
        
        // then
        XCTAssertTrue(mockDelegate.onDetailsModelFetchFailureCalled, "delegate should call onDetailsModelFetchFailure")
        XCTAssertEqual(mockDelegate.lastErrorString, "genericFailure")
    }
}
