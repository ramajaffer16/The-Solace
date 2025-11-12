//
//  MockNetworkManager.swift
//  DailyAyah
//
//  Created by Ramadhan on 03/11/2025.
//

class MockNetworkManager: NetworkManaging {
    var isFetching = false
    var resultToReturn: Result<[Verse],Error>?

    func fetchVerses(for moodData: MoodVerses, completion: @escaping (Result<[Verse],Error>) -> Void){
          isFetching = true
          if let result = resultToReturn {
              completion(result)
        }
    }
}

class MockLocalDataManager: localDataManaging {
    var verseReference = VerseReference(surah: 1, ayah: 1)
    lazy var verseReferences = [verseReference]
    lazy var moodVerses = MoodVerses(mood: "Fear", verses: verseReferences)
    var shouldReturnData = true

    func loadMoodVerses(from fileName: String) -> MoodVerses? {
        return shouldReturnData ? moodVerses : nil
    }
}

class MockCoordinator: AppCoordinatorDelegate {
    var didNavigateToVerses = false
    var receivedVerses: [Verse] = []

    func goToVersesList(verses: [Verse]) {
        didNavigateToVerses = true
        self.receivedVerses = verses
    }
    func goToHome() {}
    func goToLogin() {}
    func goToGetStarted() {}
    func goToStartScreen() {}
    func goToNextStartScreen() {}
}

// MARK: I cant access pageDidChange
//    func testPageDidChange_WhenUserSwipesToAnotherPolicy_ShouldUpdateSectionsWithNewPolicy() {
//        // Arrange
//        let firstPolicy = makePolicy(number: "P1")
//        let secondPolicy = makePolicy(number: "P2")
//
//        let viewModel = InsurePolicyDetailsViewModel(
//            selectedPolicy: firstPolicy,
//            policies: [firstPolicy, secondPolicy]
//        )
//
//        // Act — simulate page swipe
//        let collectionField = viewModel.sections.first?.cells.first as? CollectionField
//        collectionField?.currentPageDidChange?(1)  // triggers private pageDidChange(_:)
//
//        // Assert — verify visible behavior (updated UI content)
//        let detailsSection = viewModel.sections.last
//        XCTAssertNotNil(detailsSection, "Expected details section to exist after page change")
//
//        // Find any InfoField in the policy details section
//        let infoFields = detailsSection?.cells.compactMap { $0 as? InfoField } ?? []
//
//        // The "cover matures on" field uses the selected policy's end date, so it should match secondPolicy.endDate
//        let hasUpdatedDate = infoFields.contains {
//            $0.model.text.contains("02/02/2026")
//        }
//
//        XCTAssertTrue(
//            hasUpdatedDate,
//            "Expected details section to update and show the second policy's end date"
//        )
//    }

          //MARK: - I cant access the viewModel.selectedPolicy
//        func testInitialSelectedPolicyIsCorrect() {
//            let policy = makePolicy(number: "123")
//            let viewModel = InsurePolicyDetailsViewModel(selectedPolicy: policy, policies: [policy])
//            XCTAssertEqual(viewModel.selectedPolicy.number, policy.number, "Expected initial selected policy to match initializer input")
//        }


