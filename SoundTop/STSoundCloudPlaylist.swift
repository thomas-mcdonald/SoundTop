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

    func fetchPlaylist(playlistURL: NSString, success: ([Dictionary<String, AnyObject>]) -> ()) {
        let url = NSURL(string: resolverURL(playlistURL))
        let request = NSURLRequest(URL: url!)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response: NSURLResponse!, data: NSData!, error: NSError!) in
            var jsonError : NSError?
            var jsonOption: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &jsonError)

            if let json = jsonOption as? Dictionary<String, AnyObject> {
                if let tracks = json["tracks"] as? [Dictionary<String, AnyObject>] {
                    success(tracks)
                }
            }
        })
    }

    private func resolverURL(playlistURL: NSString) -> NSString {
        return "https://api.soundcloud.com/resolve.json?url=\(playlistURL)&client_id=\(clientId)"
    }
}
