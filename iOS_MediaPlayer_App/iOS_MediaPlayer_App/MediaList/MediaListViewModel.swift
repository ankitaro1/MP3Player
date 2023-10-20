//
//  MediaListViewModel.swift
//  iOS_MediaPlayer_App
//
//  Created by Ankit Sharma on 20/10/23.
//

import Foundation

protocol MediaListDiplayLogic: AnyObject {
    func refreshUI()
    func showError(error: ErrorModel)
}

class MediaListViewModel: MediaListBusinessLogic {
    var baseUrl: URL
    var mediaList: [MediaUIModel] = []
    var serviceProvider: ServiceProvider?
    weak var view: MediaListDiplayLogic?
    
    init(baseUrl: URL, serviceProvider: ServiceProvider? = nil) {
        self.baseUrl = baseUrl
        self.serviceProvider = serviceProvider
    }
    
    func fetchMediaList() {
        serviceProvider?.handleGetNetworkCall(responseModel: MediaListResponseModel.self,
                                              requestURL: URLRequest(url: baseUrl),
                                              successCallBack: { response in
            for item in response.array {
                let media = MediaUIModel(title: item.title,
                                         artistName: item.artist,
                                         url: item.url)
                self.mediaList.append(media)
            }
            self.view?.refreshUI()
        },
                                              errorCallBack: { error in
            self.view?.showError(error: ErrorModel(errorMessage: error.localizedDescription))
        })
    }
}



struct MediaUIModel {
    let title, artistName: String
    let url: URL
}

struct ErrorModel {
    let errorMessage: String
}
