//
//  MediaListResponseModel.swift
//  iOS_MediaPlayer_App
//
//  Created by Ankit Sharma on 20/10/23.
//

import Foundation

class MediaListResponseModel: Decodable {
    let array: [MediaResponseModel]
}

class MediaResponseModel: Decodable {
    let title, album, artist: String
    let url: URL
}
