//
//  PokemonListViewModelTests.swift
//  GotchaTests
//
//  Created by Majka on 12/01/2023.
//

import XCTest
@testable import Gotcha

final class PokemonListViewModelTests: XCTestCase {

    var sut: PokemonListViewModel!
    var mockService: MockPokemonApiService!
    var mockDelegate: MockPokemonListViewModelDelegate!
    
    override func setUpWithError() throws {
        mockService = MockPokemonApiService()
        mockDelegate = MockPokemonListViewModelDelegate()
        sut = PokemonListViewModel(service: mockService)
        sut.delegate = mockDelegate
    }

    override func tearDownWithError() throws {
        sut = nil
        mockService = nil
        mockDelegate = nil
    }

    func testGetNextPageFailure() {
        // given
        mockService.mockPokemonListResult = .failure(MockPokemonApiServiceError.genericFailure)
        
        // when
        sut.getNextPage()
        
        // then
        XCTAssertTrue(mockDelegate.getPageFailureCalled)
        XCTAssertEqual(mockDelegate.lastErrorString, "genericFailure")
    }
    
    func testGetNextPageSuccess() {
        // given
        mockService.mockPokemonListResult = .success(SinglePageModel(next: "nextPage",
                                                                     results: [Results(name: "lex",
                                                                                       url: "luthor")]))
        
        // when
        sut.getNextPage()
        
        // then
        XCTAssertEqual(sut.urlString, "nextPage")
        XCTAssertEqual(sut.dataSource.count, 1)
        XCTAssertEqual(sut.dataSource.first?.name, "lex")
        XCTAssertEqual(sut.dataSource.first?.url, "luthor")
        XCTAssertTrue(mockDelegate.getPageSuccessCalled)
        
    }
    
    func testGetPokemonImageFirstBatch() {
        // given
        
        // when
        let imageUrl = sut.getPokemonImageUrl(forRow: 904, openedFrom: .type)
        
        // then
        XCTAssertEqual(imageUrl, "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/905.png")
    }
    
    func testGetPokemonImageSecondBatch() {
        // given
        
        // when
        let imageUrl = sut.getPokemonImageUrl(forRow: 905, openedFrom: .type)
        
        // then
        XCTAssertEqual(imageUrl, "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/10001.png")
    }
}
