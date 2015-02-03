//
//  STSoundCloudPlaylist.swift
//  SoundTop
//
//  Created by Thomas McDonald on 28/01/2015.
//  Copyright (c) 2015 Thomas McDonald. All rights reserved.
//

import Cocoa

class STSoundCloudPlaylist: NSObject {
    private let clientId = "027aa73b22641da241a74cfdd3c5210b"

    func fetchPlaylist(playlistURL: NSString, success: (STPlaylist) -> ()) {
        let url = NSURL(string: resolverURL(playlistURL))
        let request = NSURLRequest(URL: url!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) in

            // hit callback
            let playlist: STPlaylist? = STPlaylist(playlistData: data)
            if(playlist == nil) {
                // failure callback
            } else {
                success(playlist!)
            }
        })
    }

    private func resolverURL(playlistURL: NSString) -> NSString {
        return "https://api.soundcloud.com/resolve.json?url=\(playlistURL)&client_id=\(clientId)"
    }
}
