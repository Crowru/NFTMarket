//
//  Request.swift
//  FakeNFT
//
//  Created by Руслан  on 06.11.2023.
//

import Foundation

struct GetCollectionsRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/collections")
    }
    var httpMethod: HttpMethod = .get
    var dto: Encodable?
}

struct GetProfileRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/profile/1")
    }
    var httpMethod: HttpMethod = .get
    var dto: Encodable?
}

struct GetAuthorRequest: NetworkRequest {
    var id: String
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/users/\(id)")
    }
    var httpMethod: HttpMethod = .get
    var dto: Encodable?
}

struct GetNftsRequest: NetworkRequest {
    var nftsId: String
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/nft/\(nftsId)")
    }
    var httpMethod: HttpMethod = .get
    var dto: Encodable?
}

struct GetOrderRequest: NetworkRequest {
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/orders/1")
    }
    var httpMethod: HttpMethod = .get
    var dto: Encodable?
}