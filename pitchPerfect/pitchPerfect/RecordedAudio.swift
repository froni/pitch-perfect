//
//  RecordedAudio.swift
//  pitchPerfect
//
//  Created by Nikos Fronimakis on 4/3/15.
//  Copyright (c) 2015 Nikos Fronimakis. All rights reserved.
//

import Foundation

class RecordedAudio : NSObject{
    var filePathURL: NSURL
    var title : String
    
    init(filePathUrl: NSURL, title: String){
        self.filePathURL = filePathUrl
        self.title = title
    }
}

