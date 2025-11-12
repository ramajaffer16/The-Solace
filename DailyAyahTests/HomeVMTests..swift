//
//  HomeVMTests..swift
//  DailyAyahTests
//
//  Created by Ramadhan on 03/11/2025.
//

import XCTest
@testable import DailyAyah

final class HomeVMTests_: XCTestCase {
    func test_loadVerses_whenCalled_shouldFetchVerses() {
        // Arrange
        let networkManager = MockNetworkManager()
        let localManager = MockLocalDataManager()
        let coordinator = MockCoordinator()
        let sut = HomeScreenViewModel(coordinator: coordinator, networkManager: networkManager, localManager: localManager)

        let expectation = XCTestExpectation(description: "Load Verses completes")
        networkManager.resultToReturn = .success([Verse(surahNumber: 1, ayahNumber: 1, arabicText: "dfghj", translationText: "sdfgh", reference: "76")])

        //Act
        sut.loadVerses(for: "Joy", completion: {expectation.fulfill()})

        wait(for: [expectation], timeout: 4)

        //Assert
        XCTAssertTrue(networkManager.isFetching)
   }

    func test_afterNetworkCall_shouldUpdateTheViewModel() {
        //Arrange
        let networkManager = MockNetworkManager()
        let localManager = MockLocalDataManager()
        let coordinator = MockCoordinator()
        let sut = HomeScreenViewModel(coordinator: coordinator, networkManager: networkManager, localManager: localManager)
        
        let expectation = XCTestExpectation(description: "Load Verses completes")
        networkManager.resultToReturn = .success([Verse(surahNumber: 1, ayahNumber: 1, arabicText: "dfghj", translationText: "sdfgh", reference: "76")])

        //Act
        sut.loadVerses(for: "Joy", completion: {expectation.fulfill()})

        wait(for: [expectation], timeout: 4)

        //Assert
        XCTAssertEqual(sut.verses.count, 1)
   }

    func test_whenNetworkReturnsFailure(){
//   Arrange
        let networkManager = MockNetworkManager()
        let localManager = MockLocalDataManager()
        let coordinator = MockCoordinator()
        let sut = HomeScreenViewModel(coordinator: coordinator, networkManager: networkManager, localManager: localManager)
        let expectation = XCTestExpectation(description: "Load Verses completes")
        networkManager.resultToReturn = .failure(NSError(domain: "", code: 0, userInfo: nil))

        //Act
        sut.loadVerses(for: "Joy", completion: {expectation.fulfill()})
        wait(for: [expectation], timeout: 4)

        //Assert
        XCTAssertTrue(sut.verses.isEmpty)
    }

    func test_WhenCallingGoVerseList_shouldNavigateToVerseList() {
        let coordinator = MockCoordinator()
        let networkManager = MockNetworkManager()
        let localManager = MockLocalDataManager()
        let sut = HomeScreenViewModel(coordinator: coordinator, networkManager: networkManager, localManager: localManager)

        let expectation = XCTestExpectation(description: "Load Verses completes")
        networkManager.resultToReturn = .success([Verse(surahNumber: 1, ayahNumber: 1, arabicText: "dfghj", translationText: "sdfgh", reference: "76")])

        //Act
        sut.loadVerses(for: "Joy", completion: {expectation.fulfill()})

        wait(for: [expectation], timeout: 4)

       XCTAssert(coordinator.didNavigateToVerses)
    }

    func test_completionIsCalledOnMainThread() {
        // Arrange
        let coordinator = MockCoordinator()
        let networkManager = MockNetworkManager()
        let localManager = MockLocalDataManager()
        let sut = HomeScreenViewModel(coordinator: coordinator, networkManager: networkManager, localManager: localManager)
        let expectation = XCTestExpectation(description: "Load Verses completes")
        networkManager.resultToReturn = .success([Verse(surahNumber: 1, ayahNumber: 1, arabicText: "dfghj", translationText: "sdfgh", reference: "76")])

        //Act
        sut.loadVerses(for: "Joy", completion: {XCTAssertTrue(Thread.isMainThread)
                                                expectation.fulfill()
        })

        //Assert
        let result = XCTWaiter.wait(for: [expectation], timeout: 4)
        XCTAssertEqual(result, .completed)
    }

    func test_whenCallingGoVerseList_shouldPassVersesToVerseList(){
        let coordinator = MockCoordinator()
        let networkManager = MockNetworkManager()
        let localManager = MockLocalDataManager()
        let sut = HomeScreenViewModel(coordinator: coordinator, networkManager: networkManager, localManager: localManager)
        
        let expectation = XCTestExpectation(description: "Load Verses completes")
        networkManager.resultToReturn = .success([Verse(surahNumber: 1, ayahNumber: 1, arabicText: "dfghj", translationText: "sdfgh", reference: "76")])

        //Act
        sut.loadVerses(for: "Joy", completion: {expectation.fulfill()})

        wait(for: [expectation], timeout: 4)
        
        XCTAssertTrue(coordinator.receivedVerses == [Verse(surahNumber: 1, ayahNumber: 1, arabicText: "dfghj", translationText: "sdfgh", reference: "76")])
    }
}
