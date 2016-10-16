// STTrack.swift
//
// Copyright (c) 2015 Thomas McDonald
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
// Redistributions of source code must retain the above copyright notice, this
// list of conditions and the following disclaimer. Redistributions in binary
// form must reproduce the above copyright notice, this list of conditions and
// the following disclaimer in the documentation and/or other materials
// provided with the distribution. Neither the name of the nor the names of
// its contributors may be used to endorse or promote products derived from
// this software without specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
// AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
// IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
// ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
// LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
// CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
// SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
// INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
// CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.

import AVFoundation
import Cocoa

class STTrack: NSObject, NSCopying {
    var artworkURL : NSString?
    var title : NSString?
    var artist : NSString?
    var streamURL : NSString?

    private var clientStreamURL : NSString {
        get {
            return (self.streamURL! as String) + "?client_id=027aa73b22641da241a74cfdd3c5210b"
        }
    }

    var largeAlbumArt : NSString? {
        get {
            return self.artworkURL?.stringByReplacingOccurrencesOfString("large", withString: "t500x500")
        }
    }

    var badgeAlbumArt: NSString? {
        get {
            return self.artworkURL?.stringByReplacingOccurrencesOfString("large", withString: "t300x300")
        }
    }

    init(title : NSString?, artist : NSString?, artworkURL: NSString?, streamURL: NSString?) {
        self.artworkURL = artworkURL
        self.title = title
        self.artist = artist
        self.streamURL = streamURL
    }

    func playerItem() -> AVPlayerItem {
        let url = NSURL(string: clientStreamURL as String)!
        let asset = AVAsset.init(URL: url)
        return AVPlayerItem.init(asset: asset)
    }

    func copyWithZone(zone: NSZone) -> AnyObject {
        return STTrack(title: title, artist: artist, artworkURL: artworkURL, streamURL: streamURL)
    }
}
