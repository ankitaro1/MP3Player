//
//  MovieListViewModelTests.swift
//  iOS_MediaPlayer_AppTests
//
//  Created by Ankit Sharma on 20/10/23.
//

import XCTest
@testable import iOS_MediaPlayer_App

final class MovieListViewModelTests: XCTestCase, MediaListDiplayLogic {
    
    var refresUICalled = false
    var errorReceived = false
    
    override func setUpWithError() throws {
        refresUICalled = false
        errorReceived = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchMediaListSuccessCallBack() {
        let serviceProvider = ServiceDataSourceMock()
        serviceProvider.isSuccess = true
        let viewModel = MediaListViewModel(baseUrl: URL(string: "https:abc.com")!,
                                           serviceProvider: serviceProvider)
        viewModel.view = self
        viewModel.fetchMediaList()
        XCTAssertTrue(refresUICalled)
    }
    
    func testFetchMediaListErrorCallBack() {
        let serviceProvider = ServiceDataSourceMock()
        serviceProvider.isSuccess = false
        let viewModel = MediaListViewModel(baseUrl: URL(string: "https:abc.com")!,
                                           serviceProvider: serviceProvider)
        viewModel.view = self
        viewModel.fetchMediaList()
        XCTAssertTrue(errorReceived)
    }


    func refreshUI() {
        refresUICalled = true
    }
    
    func showError(error: iOS_MediaPlayer_App.ErrorModel) {
        errorReceived = true
    }
}

class ServiceDataSourceMock: ServiceProvider {
    
    var isSuccess: Bool = false
    func handleGetNetworkCall<T>(responseModel: T.Type, requestURL: URLRequest, successCallBack: @escaping (T) -> Void, errorCallBack: @escaping (Error) -> Void) where T : Decodable {
        if isSuccess {
            guard let filePath = Bundle(for: MovieListViewModelTests.self).path(forResource: "MediaListTestResponse", ofType: "json") else { return }
            let data = try? Data(contentsOf: URL(filePath: filePath))
            let decoder = JSONDecoder()
            let response = try? decoder.decode(responseModel, from: data!)
            successCallBack(response!)
        } else {
            errorCallBack(ErrorModelMock())
        }
    }
    
    
}

class ErrorModelMock: Error {
    let error: String = ""
}
