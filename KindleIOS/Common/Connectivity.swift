//
//  Connectivity.swift
//  KindleIOS
//
//  Created by Ahmed ATIA on 19/12/2018.
//  Copyright © 2018 Ahmed ATIA. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - Types
public typealias SaveCompletion = (success : Bool, error: Error?)

// MARK: - Enum
enum ErrorStatus : Error {
    case notFound
    case network
    case none
}

// MARK: - DataLinks
struct DataLinks {
    static let JSON_BOOKS : String =  "http://henri-potier.xebia.fr/books/"
}

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
