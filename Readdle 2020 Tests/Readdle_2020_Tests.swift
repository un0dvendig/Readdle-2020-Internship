//
//  Readdle_2020_Tests.swift
//  Readdle 2020 Tests
//
//  Created by Eugene Ilyin on 31.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import XCTest
@testable import Readdle_2020

class Readdle_2020_Tests: XCTestCase {

    // MARK: - Tests
    
    func testPersonModel() {
        let person = Person(name: "Test Name", email: "Test Email", status: .online)
        
        XCTAssertNotNil(person)
        XCTAssertEqual(person.name, "Test Name")
        XCTAssertEqual(person.email, "Test Email")
        XCTAssertEqual(person.status, Status.online)
    }
    
    func testPersonsFactory() {
        let factory = PersonFactory.shared
        
        let person = Person(name: "Michael Corleone", email: "thegodfather@corleone.it", status: .offline)
        let personFromFactory = factory.createPersonUsing(name: "Michael Corleone", email: "thegodfather@corleone.it", status: .offline)
        XCTAssertNotNil(personFromFactory)
        XCTAssertEqual(person, personFromFactory)
        
        let randomPersonFromFactory = factory.createRandomPerson()
        XCTAssertNotNil(randomPersonFromFactory)
        XCTAssertNotEqual(person, randomPersonFromFactory) /// There is an extremely small chance that this assert will fail due to random.
        
        var personsArray: [Person] = []
        personsArray = factory.createRandomPersons(numberOfPersonsToCreate: 30)
        XCTAssertNotNil(personsArray)
        XCTAssertGreaterThan(personsArray.count, 1)
        XCTAssertEqual(personsArray.count, 30)
    }
    
    func testPersonsWarehouse() {
        let defaultCount: Int = 100
        
        let warehouse = PersonsWarehouse.shared
        XCTAssertNotNil(warehouse.totalNumberOfPersons)
        XCTAssertEqual(warehouse.totalNumberOfPersons, defaultCount) /// This assert should only work while default number of entities is hardcoded.
        
        warehouse.addRandomPerson()
        XCTAssertEqual(warehouse.totalNumberOfPersons, defaultCount + 1)
        
        warehouse.deleteRandomPerson()
        XCTAssertEqual(warehouse.totalNumberOfPersons, defaultCount)
        
        let someIndex: Int = 10
        if let personToCompareWith = warehouse.getPerson(at: someIndex) {
            warehouse.deletePerson(at: someIndex)
            XCTAssertEqual(warehouse.totalNumberOfPersons, defaultCount - 1)
            if let personToTest = warehouse.getPerson(at: someIndex) {
                XCTAssertNotEqual(personToTest, personToCompareWith)
            }
        }
        
        let anotherIndex: Int = 5
        if let personToCompareWith = warehouse.getPerson(at: anotherIndex) {
            if let personToTest = warehouse.getPerson(at: anotherIndex + 1) {
                XCTAssertNotEqual(personToTest, personToCompareWith)
                
                warehouse.changePersonInfo(atIndex: anotherIndex + 1, name: personToCompareWith.name, email: personToCompareWith.email, status: personToCompareWith.status)
                
                if let updatedPersonToCompareWith = warehouse.getPerson(at: anotherIndex) {
                    XCTAssertEqual(personToTest, updatedPersonToCompareWith)
                }
            }
        }
        
        warehouse.deleteAllPersons()
        XCTAssertEqual(warehouse.totalNumberOfPersons, 0)
        
        warehouse.addSeveralRandomPersons(numberOfPersons: defaultCount)
        XCTAssertEqual(warehouse.totalNumberOfPersons, defaultCount)
        
        let anotherTestIndex: Int = 20
        if let personToCompareWith = warehouse.getPerson(at: anotherTestIndex) {
            warehouse.shufflePersons()
            if let personToTest = warehouse.getPerson(at: anotherTestIndex) {
                XCTAssertNotEqual(personToTest, personToCompareWith) /// There is an extremely small chance that this assert will fail due to random.
            }
        }
        
        let yetAgainAnotherTestIndex: Int = 30
        if let personToCompareWith = warehouse.getPerson(at: yetAgainAnotherTestIndex) {
            let currentNumberOfPersons = warehouse.totalNumberOfPersons
            warehouse.simulateChanges()
            XCTAssertNotEqual(currentNumberOfPersons, warehouse.totalNumberOfPersons) /// There is a small chance that this assert will fail due to random.
            if let personToTest = warehouse.getPerson(at: yetAgainAnotherTestIndex) {
                XCTAssertNotEqual(personToTest, personToCompareWith) /// There is an extremely small chance that this assert will fail due to random.
            }
        }
    }
    
    func testStringExtension() {
        var stringToCompareWith = "Hello"
        var stringToTest = "hello"
        stringToTest.capitalizedFirstLetter()
        XCTAssertEqual(stringToTest, stringToCompareWith)
        
        stringToCompareWith = "1hello"
        stringToTest = "1hello"
        stringToTest.capitalizedFirstLetter()
        XCTAssertEqual(stringToTest, stringToCompareWith)
        
        stringToCompareWith = " hello"
        stringToTest = " hello"
        stringToTest.capitalizedFirstLetter()
        XCTAssertEqual(stringToTest, stringToCompareWith)
        
        stringToCompareWith = "H"
        stringToTest = "h"
        stringToTest.capitalizedFirstLetter()
        XCTAssertEqual(stringToTest, stringToCompareWith)
        
        stringToCompareWith = ""
        stringToTest = ""
        stringToTest.capitalizedFirstLetter()
        XCTAssertEqual(stringToTest, stringToCompareWith)
    }
    
    func testCryptoHandler() {
        let testString = "test"
        /// The hash is created by: https://www.md5hashgenerator.com/.
        let testHash = "098f6bcd4621d373cade4e832627b4f6" /// MD5 hash value of `testString`
        
        let cryptoHandler = CryptoHandler()
        let hashToTest = cryptoHandler.createMD5Hash(from: testString)
        XCTAssertEqual(hashToTest, testHash)
    }
    
    func testDataWorker() {
        /// Example from: http://en.gravatar.com/site/implement/hash/.
        let testEmail = "MyEmailAddress@example.com "
        let wrongHashToCompareWith = "f9879d71855b5ff21e4963273a886bfc"
        let properHashToCompareWith = "0bc83cb571cd1c50ba6f3e8a78ef1346"
        
        let dataWorker = DataWorker.shared
        let hashToTest = dataWorker.createMD5HashForGravatarImageRequestUsing(email: testEmail)
        XCTAssertNotEqual(hashToTest, wrongHashToCompareWith)
        XCTAssertEqual(hashToTest, properHashToCompareWith)
    }
    
    func testURLBuilder() {
        guard let properURLToCompareWith = URL(string: "https://www.readdle.com") else {
            XCTFail()
            return
        }
        guard let urlToTest = URLBuilder()
            .set(scheme: "https")
            .set(host: "www.readdle.com")
            .build() else {
                XCTFail()
                return
        }
        XCTAssertEqual(urlToTest, properURLToCompareWith)
        
        guard let anotherProperURLToCompareWith = URL(string: "https://jsonplaceholder.typicode.com/posts?userId=1") else {
            XCTFail()
            return
        }
        guard let anotherUrlToTest = URLBuilder()
            .set(scheme: "https")
            .set(host: "jsonplaceholder.typicode.com")
            .set(path: "posts")
            .addQueryItem(name: "userId", value: "1")
            .build() else {
                XCTFail()
                return
        }
        XCTAssertEqual(anotherUrlToTest, anotherProperURLToCompareWith)
        
    }
    
    func testDetailedInfoViewModel() {
        let person = Person(name: "Jabba", email: "jabba.the.hutt66@tatooine.net", status: .online)
        /// Hash calculated with: https://www.md5hashgenerator.com/.
        let properHash = "84f5dfe7b576a1585d35cec25c84424c"
        /// URL created by the example from: http://en.gravatar.com/site/implement/images/.
        /// By default `largeURL` means image with size of `400pt`
        /// and `smallURL` - `50pt`.
        /// These values are hardocded in corresponding view models.
        guard let properLargeURLToCompareWith = URL(string: "https://www.gravatar.com/avatar/\(properHash)?size=400") else {
            XCTFail()
            return
        }
        
        let viewModel = DetailedInfoViewModel(person: person)
        guard let largeURLToTest = viewModel.largeImageURL else {
            XCTFail()
            return
        }
        XCTAssertEqual(person.name, viewModel.name)
        XCTAssertEqual(person.status.rawValue, viewModel.status)
        XCTAssertEqual(largeURLToTest, properLargeURLToCompareWith)
    }
    
    func testPersonCollectionViewCellViewModels() {
        let person = Person(name: "Jabba", email: "jabba.the.hutt66@tatooine.net", status: .online)
        /// Hash calculated with: https://www.md5hashgenerator.com/.
        let properHash = "84f5dfe7b576a1585d35cec25c84424c"
        /// URL created by the example from: http://en.gravatar.com/site/implement/images/.
        /// By default `largeURL` means image with size of `400pt`
        /// and `smallURL` - `50pt`.
        /// These values are hardocded in corresponding view models.
        guard let properSmallURLToCompareWith = URL(string: "https://www.gravatar.com/avatar/\(properHash)?size=50") else {
            XCTFail()
            return
        }
        
        let listViewModel = PersonListCollectionViewCellViewModel(person: person)
        guard let listSmallURLToTest = listViewModel.smallImageURL else {
            XCTFail()
            return
        }
        XCTAssertEqual(person.name, listViewModel.name)
        XCTAssertEqual(getColor(for: person.status), listViewModel.statusColor)
        XCTAssertEqual(listSmallURLToTest, properSmallURLToCompareWith)
        
        let gridViewModel = PersonGridCollectionViewCellViewModel(person: person)
        guard let gridSmallURLToTest = listViewModel.smallImageURL else {
            XCTFail()
            return
        }
        XCTAssertEqual(getColor(for: person.status), gridViewModel.statusColor)
        XCTAssertEqual(gridSmallURLToTest, properSmallURLToCompareWith)
    }
    
    func testDownloadManager() {
        var realDataToTest: Data? // Real avatar image data that should be downloaded
        let realDataExpectation = expectation(description: "Checking that image data is downloaded")
        /// Hash example from: http://en.gravatar.com/site/implement/images/
        let realAvatarHash = "205e460b479e2e5b48aec07710c08d50"
        guard let realAvatarURL = URL(string: "https://www.gravatar.com/avatar/\(realAvatarHash)") else {
            XCTFail()
            return
        }
        
        var fakeDataToTest: Data? // Default avatar image data that should be downloaded
        let fakeDataExpectation = expectation(description: "Checking that image data is downloaded")
        let fakeAvatarHash = "0aa000a0a0a0a0a000a000a000000000"
        guard let fakeAvatarURL = URL(string: "https://www.gravatar.com/avatar/\(fakeAvatarHash)") else {
            XCTFail()
            return
        }
        
        var noDataToTest: Data? // Data that should not be downloaded
        let noDataExpectation = expectation(description: "Checking that data is not downloaded")
        guard let wrongAvatarURL = URL(string: "https://www.graaaatar.com/avatarImage/1?yes=no") else {
            XCTFail()
            return
        }
        
        let downloadManager = DownloadManager.shared
        downloadManager.downloadData(from: realAvatarURL) { (result) in
            switch result {
            case .success(let data):
                realDataToTest = data
                realDataExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        downloadManager.downloadData(from: fakeAvatarURL) { (result) in
            switch result {
            case .success(let data):
                fakeDataToTest = data
                fakeDataExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        downloadManager.downloadData(from: wrongAvatarURL) { (result) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(_):
                noDataToTest = nil
                noDataExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 2) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
            XCTAssertNotNil(realDataToTest)
            XCTAssertNotNil(fakeDataToTest)
            XCTAssertNil(noDataToTest)
            XCTAssertNotEqual(realDataToTest, fakeDataToTest)
        }
    }
    
    func testDataWorkerImageConvertion() {
        var avatarImage: UIImage?
        let avatarExpectation = expectation(description: "Checking that downloaded data is properly converted to UIImage")
        /// Hash example from: http://en.gravatar.com/site/implement/images/
        let avatarHash = "205e460b479e2e5b48aec07710c08d50"
        guard let avatarURL = URL(string: "https://www.gravatar.com/avatar/\(avatarHash)") else {
            XCTFail()
            return
        }
        
        DownloadManager.shared.downloadData(from: avatarURL) { (result) in
            switch result {
            case .success(let data):
                if let image = DataWorker.shared.convertDataToUIImage(data) {
                    avatarImage = image
                    avatarExpectation.fulfill()
                } else {
                    let error = CustomError.cannotCreateUIImage
                    XCTFail(error.localizedDescription)
                }
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 2) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
            XCTAssertNotNil(avatarImage)
        }
    }
    
    func testAsyncImageView() {
        let asyncImageView = AsyncImageView()
        XCTAssertNil(asyncImageView.image)
        
        let imageDownloadExpectation = expectation(description: "Checking that image is downloaded")
        /// Hash example from: http://en.gravatar.com/site/implement/images/
        let avatarHash = "205e460b479e2e5b48aec07710c08d50"
        guard let avatarURL = URL(string: "https://www.gravatar.com/avatar/\(avatarHash)") else {
            XCTFail()
            return
        }
        
        asyncImageView.loadImageFrom(url: avatarURL) { (result) in
            switch result {
            case .success():
                imageDownloadExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 2) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
            XCTAssertNotNil(asyncImageView.image)
        }
    }
    
    func testDetailedInfoView() {
        let person = Person(name: "Jack Sparrow", email: "the.captain.jack.sparrow@caribbean.bb", status: .online)
        
        let detailedInfoView = DetailedInfoView()
        XCTAssertTrue(detailedInfoView.detailAvatarImageLoadingActivityIndicator.isAnimating)
        XCTAssertNil(detailedInfoView.detailNameLabel.text)
        XCTAssertNil(detailedInfoView.detailStatusLabel.text)
        XCTAssertEqual(detailedInfoView.detailEmailTextView.text, "")
        XCTAssertNil(detailedInfoView.detailAvatarImageView.image)
        
        let viewModel = DetailedInfoViewModel(person: person)
        detailedInfoView.configure(with: viewModel)
        
        let dummyExpectation = expectation(description: "Dummy expectation")
        dummyExpectation.isInverted = true
        
        waitForExpectations(timeout: 1) { (_) in
            /// Assuming that 1 sec is enough to download image.
            XCTAssertFalse(detailedInfoView.detailAvatarImageLoadingActivityIndicator.isAnimating)
            XCTAssertEqual(detailedInfoView.detailNameLabel.text, person.name)
            XCTAssertEqual(detailedInfoView.detailStatusLabel.text, person.status.rawValue)
            XCTAssertEqual(detailedInfoView.detailEmailTextView.text, person.email)
            XCTAssertNotNil(detailedInfoView.detailAvatarImageView.image)
        }
    }
    
    func testPersonListCollectionViewCell() {
        let person = Person(name: "Yoda The Wise", email: "yodathisis.themaster@jedi.org", status: .online)
        
        let listCell = PersonListCollectionViewCell()
        XCTAssertTrue(listCell.personAvatarLoadingActivityIndicatorView.isAnimating)
        XCTAssertNil(listCell.personNameLabel.text)
        XCTAssertEqual(listCell.personStatusView.backgroundColor, nil)
        XCTAssertNil(listCell.personAvatarImageView.image)
        
        let listCellViewModel = PersonListCollectionViewCellViewModel(person: person)
        listCell.configure(with: listCellViewModel)
        let dummyExpectation = expectation(description: "Dummy expectation")
        dummyExpectation.isInverted = true
        
        waitForExpectations(timeout: 1) { (_) in
            /// Assuming that 1 sec is enough to download image.
            XCTAssertFalse(listCell.personAvatarLoadingActivityIndicatorView.isAnimating)
            XCTAssertEqual(listCell.personNameLabel.text, person.name)
            XCTAssertEqual(listCell.personStatusView.backgroundColor, self.getColor(for: person.status))
            XCTAssertNotNil(listCell.personAvatarImageView.image)
        }
    }
    
    func testPersonGridCollectionViewCell() {
        let person = Person(name: "Obi-Wan Kenobi", email: "hellothere@jedi.org", status: .offline)
        
        let gridCell = PersonGridCollectionViewCell()
        XCTAssertTrue(gridCell.personAvatarLoadingActivityIndicatorView.isAnimating)
        XCTAssertEqual(gridCell.personStatusView.backgroundColor, nil)
        XCTAssertNil(gridCell.personAvatarImageView.image)
        
        let gridCellViewModel = PersonGridCollectionViewCellViewModel(person: person)
        gridCell.configure(with: gridCellViewModel)
        let dummyExpectation = expectation(description: "Dummy expectation")
        dummyExpectation.isInverted = true
        
        waitForExpectations(timeout: 1) { (_) in
            /// Assuming that 1 sec is enough to download image.
            XCTAssertFalse(gridCell.personAvatarLoadingActivityIndicatorView.isAnimating)
            XCTAssertEqual(gridCell.personStatusView.backgroundColor, self.getColor(for: person.status))
            XCTAssertNotNil(gridCell.personAvatarImageView.image)
        }
    }
    
    // MARK: - Private methods
    
    private func getColor(for status: Status) -> UIColor {
        switch status {
        case .online:
            return .green
        case .offline:
            return .red
        case .unknown:
            return .gray
        }
    }

}
