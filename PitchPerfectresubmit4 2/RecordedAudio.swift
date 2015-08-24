//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by RAP on 8/8/15.
//  Copyright (c) 2015 RAP. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init (filePathUrl: NSURL, title: String){
        self.filePathUrl = filePathUrl
        self.title = title
    }
}
