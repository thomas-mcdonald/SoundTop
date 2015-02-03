//
//  STPlaylist.swift
//  SoundTop
//
//  Created by Thomas McDonald on 03/02/2015.
//  Copyright (c) 2015 Thomas McDonald. All rights reserved.
//

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
