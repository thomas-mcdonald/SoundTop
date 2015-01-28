//
//  Track.swift
//  SoundTop
//
//  Created by Thomas McDonald on 28/01/2015.
//  Copyright (c) 2015 Thomas McDonald. All rights reserved.
//

import Cocoa

class STTrack: NSObject {
    var artworkURL : NSString?
    var title : NSString?
    var artist : NSString?

    init(title : NSString?, artist : NSString?, artworkURL: NSString?) {
        self.artworkURL = artworkURL
        self.title = title
        self.artist = artist
    }
}
