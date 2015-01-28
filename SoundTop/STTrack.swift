//
//  Track.swift
//  SoundTop
//
//  Created by Thomas McDonald on 28/01/2015.
//  Copyright (c) 2015 Thomas McDonald. All rights reserved.
//

import AVFoundation
import Cocoa

class STTrack: NSObject {
    var artworkURL : NSString?
    var title : NSString?
    var artist : NSString?
    var streamURL : NSString?

    private var clientStreamURL : NSString {
        get {
            return self.streamURL! + "?client_id=027aa73b22641da241a74cfdd3c5210b"
        }
    }

    init(title : NSString?, artist : NSString?, artworkURL: NSString?, streamURL: NSString?) {
        self.artworkURL = artworkURL
        self.title = title
        self.artist = artist
        self.streamURL = streamURL
    }

    func playerItem() -> AVPlayerItem {
        let url = NSURL(string: clientStreamURL)!
        let asset = AVAsset.assetWithURL(url) as AVAsset
        return AVPlayerItem.init(asset: asset)
    }
}
