// STPlaylist.swift
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

import Cocoa

class STPlaylist: NSObject {
    var tracks: [STTrack]

    // create from a playlist
    convenience init?(playlistData: NSData) {
        self.init()
        var jsonError : NSError?
        var jsonOption: AnyObject! = NSJSONSerialization.JSONObjectWithData(playlistData, options: NSJSONReadingOptions(0), error: &jsonError)

        if(jsonError != nil) {
            return nil
        }

        // array for storing the track information for the playlists
        var ts : [STTrack] = []
        if let json = jsonOption as? Dictionary<String, AnyObject> {
            if let jtracks = json["tracks"] as? [Dictionary<String, AnyObject>] {
                for track in jtracks {
                    var artworkURL: NSString?
                    var artist: NSString?
                    var title: NSString?
                    var streamURL: NSString?

                    if let jsonurl = track["artwork_url"] as? String {
                        artworkURL = jsonurl
                    }
                    if let user = track["user"] as? Dictionary<String, AnyObject> {
                        if let username = user["username"] as? String {
                            artist = username
                        }
                    }
                    if let name = track["title"] as? String {
                        title = name
                    }
                    if let stream = track["stream_url"] as? String {
                        streamURL = stream
                    }
                    tracks.append(STTrack(title: title, artist: artist, artworkURL: artworkURL, streamURL: streamURL))
                }
            }
        }
    }

    // create from a users likes. differs from playlist in that there's no tracks wrapper and can contain playlists
    convenience init?(likesData: NSData) {
        self.init()
        var jsonError : NSError?
        var jsonOption: AnyObject! = NSJSONSerialization.JSONObjectWithData(likesData, options: NSJSONReadingOptions(0), error: &jsonError)
        // TODO: implement support for user likes
        return nil
    }

    override init() {
        tracks = []
        super.init()
    }
}
