//
//  URLProtocol.swift
//  MarketplaceTests
//
//  Created by Jonathan Scaramal on 23/08/2020.
//  Copyright © 2020 jkdev. All rights reserved.
//

import Foundation

enum CustomMockError : Error {
    case customError(String)
}

class URLProtocolMock: URLProtocol {
    // this dictionary maps URLs to test data filenames
    static var testURLs = [URL?: String]()

    // say we want to handle all types of request
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    // ignore this method; just send back what we were given
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        // if we have a valid URL…
        if let url = request.url {
            // …and if we have test data for that URL…
            if let fileName = URLProtocolMock.testURLs[url] {
                let data = loadData("\(fileName).json")
                // …load it immediately.
                self.client?.urlProtocol(self, didLoad: data)
            } else {
                // if filename is nil, fail
                self.client?.urlProtocol(self, didFailWithError: CustomMockError.customError("No data"))
            }
        }

        // mark that we've finished
        self.client?.urlProtocolDidFinishLoading(self)
    }

    // this method is required but doesn't need to do anything
    override func stopLoading() { }
}

func loadData(_ filename: String) -> Data {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    return data
}
