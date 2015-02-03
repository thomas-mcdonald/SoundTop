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
    var player: AVPlayer?
    var currentTrack: STTrack?
    var playlist: STPlaylist?

    func applicationDidFinishLaunching(aNotification: NSNotification) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "play", name: "playing", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "pause", name: "paused", object: nil)

        player = AVPlayer.init()
        STSoundCloudPlaylist().fetchPlaylist("https://soundcloud.com/tommcdonald/sets/c-o-s-v", success: { (playlist: STPlaylist) in
            self.playlist = playlist
            NSNotificationCenter.defaultCenter().postNotificationName("newTracks", object: nil)
            if(playlist.tracks.count > 0) {
                self.player!.replaceCurrentItemWithPlayerItem(playlist.tracks[0].playerItem())
                self.currentTrack = playlist.tracks[0]
                NSNotificationCenter.defaultCenter().postNotificationName("newTrack", object: nil)
            }
        })
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    func play() {
        self.player!.play()
    }

    func pause() {
        self.player!.pause()
    }
}

