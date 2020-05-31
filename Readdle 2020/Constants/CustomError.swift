//
//  CustomError.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 30.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

import Foundation

public enum CustomError: Error {
    case cannotBuildURL
    case cannotCreateUIImage
    case cannotCreateImageURL
    case errorWithText(String)
    case unknown
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .cannotBuildURL:
            return ErrorText.cannotBuildURL.rawValue
        case .cannotCreateUIImage:
            return ErrorText.cannotCreateUIImage.rawValue
        case .cannotCreateImageURL:
            return ErrorText.cannotCreateImageURL.rawValue
        case .unknown:
            return ErrorText.unknown.rawValue
        case .errorWithText(let text):
            return text
        }
    }
}

public enum ErrorText: String {
    case cannotBuildURL = "Cannot build an URL"
    case cannotCreateUIImage = "Cannot create an UIImage"
    case cannotCreateImageURL = "Cannot create an URL for the image"
    case unknown = "Unknown error"
}
