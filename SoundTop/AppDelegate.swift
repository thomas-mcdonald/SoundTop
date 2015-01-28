//
//  AppDelegate.swift
//  SoundTop
//
//  Created by Thomas McDonald on 27/01/2015.
//  Copyright (c) 2015 Thomas McDonald. All rights reserved.
//

import AVFoundation
import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var player : AVPlayer?
    var currentTrack : STTrack?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        player = AVPlayer.init()
        STSoundCloudPlaylist().fetchPlaylist("https://soundcloud.com/tommcdonald/sets/c-o-s-v", success: { (tracks: [STTrack]) in
            if(tracks.count > 0) {
                self.player!.replaceCurrentItemWithPlayerItem(tracks[0].playerItem())
                //self.player!.play() disabled to not drive me crazy with bo saris
                self.currentTrack = tracks[0]
                //NSNotificationCenter.defaultCenter().postNotificationName("newTrack", object: nil)
            }
        })
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

