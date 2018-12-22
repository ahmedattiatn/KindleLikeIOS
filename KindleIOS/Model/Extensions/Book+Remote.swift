//
//  Books+Remote.swift
//  KindleIOS
//
//  Created by Ahmed ATIA on 19/12/2018.
//  Copyright © 2018 Ahmed ATIA. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

extension Book {
    static  func fetchBooks(completion: @escaping (SaveCompletion) -> Void) {
        // Check for connectivity
        if !Connectivity.isConnectedToInternet(){
            completion(SaveCompletion(false, ErrorStatus.network))        }
        //Prepare Link
        let link : String = DataLinks.JSON_BOOKS
        // request for data using Get Method
        Alamofire.request(
            URL(string: link)!,
            method: .get,
            parameters: nil)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    // in case of failure
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    
                    if let statusCode = response.response?.statusCode {
                        if statusCode == 404 {
                            /* 404 Not Found -- The server can not find requested resource (country) */
                            completion(SaveCompletion(false, ErrorStatus.notFound))
                        }
                    }
                    return
                }
                // get responseData
                guard let responseData = response.result.value else {
                    print("Invalid tag information received from the service")
                    completion(SaveCompletion(false, ErrorStatus.none))
                    return
                }
                let responseJSON = JSON(responseData)
                Book.updateBooksFrom(responseJSON, completion: { (saveCompletion) in
                    completion(saveCompletion)
                })
        }
    }
    
    static  func fetchOffers(completion: @escaping (SaveCompletion) -> Void) {
        // Check for connectivity
        if !Connectivity.isConnectedToInternet(){
            completion(SaveCompletion(false, ErrorStatus.network))        }
        //Prepare Link
        var link : String = DataLinks.JSON_BOOKS
        // request for data using Get Method
        var parameters = [String]()
        let selectedBooks = Book.loadSelectedBooks()
        for selectedBook in selectedBooks {
            parameters.append(selectedBook.id)
        }
        let getParamsString = (parameters.compactMap({ (value) -> String in
            return "\(value)"
        }) as Array).joined(separator: ",")
        link = link + getParamsString + "/commercialOffers"
        Alamofire.request(
            URL(string: link)!,
            method: .get,
            parameters: nil)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    // in case of failure
                    print("Error while fetching remote rooms: \(String(describing: response.result.error))")
                    
                    if let statusCode = response.response?.statusCode {
                        if statusCode == 404 {
                            /* 404 Not Found -- The server can not find requested resource (country) */
                            completion(SaveCompletion(false, ErrorStatus.notFound))
                        }
                    }
                    return
                }
                // get responseData
                guard let responseData = response.result.value else {
                    print("Invalid tag information received from the service")
                    completion(SaveCompletion(false, ErrorStatus.none))
                    return
                }
                let responseJSON = JSON(responseData)
                Book.updateOffersFrom(responseJSON, completion: { (saveCompletion) in
                    completion(saveCompletion)
                })
        }
    }
}
