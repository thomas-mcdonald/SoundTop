//
//  AppDelegate.swift
//  SoundTop
//
//  Created by Thomas McDonald on 27/01/2015.
//  Copyright (c) 2015 Thomas McDonald. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var currentAlbumArt : String?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        STSoundCloudPlaylist().fetchPlaylist("https://soundcloud.com/tommcdonald/sets/c-o-s-v", success: { (tracks: [Dictionary<String, AnyObject>]) in
            if let artwork = tracks[0]["artwork_url"] as? String {
                self.currentAlbumArt = artwork.stringByReplacingOccurrencesOfString("large", withString: "t500x500")
                NSNotificationCenter.defaultCenter().postNotificationName("newAlbumArt", object: nil)
            }
        })
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

