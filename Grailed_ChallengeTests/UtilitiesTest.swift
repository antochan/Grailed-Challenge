//
//  UtilitiesTest.swift
//  Grailed_ChallengeTests
//
//  Created by Antonio Chan on 2018/11/10.
//  Copyright © 2018 Antonio Chan. All rights reserved.
//

import XCTest
@testable import Grailed_Challenge

class UtilitiesTest: XCTestCase {
    
    //test our newImageUrl function
    func testNewImageUrl() {
        let heroCaseOne = "www.google.com"
        let widthCaseOne = 100
        let answerOne = "https://cdn.fs.grailed.com/AJdAgnqCST4iPtnUxiGtTz/rotate=deg:exif/rotate=deg:0/resize=width:100,fit:crop/output=format:jpg,compress:true,quality:95/www.google.com"
        
        let heroCaseTwo = "www.yahoo.com"
        let widthCaseTwo = 200
        let answerTwo = "https://cdn.fs.grailed.com/AJdAgnqCST4iPtnUxiGtTz/rotate=deg:exif/rotate=deg:0/resize=width:200,fit:crop/output=format:jpg,compress:true,quality:95/www.yahoo.com"
        
        XCTAssertEqual(newImageUrl(heroCaseOne, widthCaseOne), answerOne)
        XCTAssertEqual(newImageUrl(heroCaseTwo, widthCaseTwo), answerTwo)
    }
    
    func testDateTransformer() {
        let dateOne = "2017-08-29T04:00:00.000Z"
        let dateTwo = "2018-01-30T05:00:00.000Z"
        
        XCTAssertEqual(dateTransformer(dateOne), "Aug 29,2017")
        XCTAssertEqual(dateTransformer(dateTwo), "Jan 30,2018")
    }
    
}
