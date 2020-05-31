//
//  CustomError.swift
//  Readdle 2020
//
//  Created by Eugene Ilyin on 30.05.2020.
//  Copyright © 2020 Eugene Ilyin. All rights reserved.
//

public enum CustomError: Error {
    case cannotBuildURL
    case cannotCreateUIImage
    case errorWithText(String)
    case unknown
}
