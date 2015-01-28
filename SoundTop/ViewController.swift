//
//  ViewController.swift
//  SoundTop
//
//  Created by Thomas McDonald on 27/01/2015.
//  Copyright (c) 2015 Thomas McDonald. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    @IBOutlet weak var albumView : STAlbumView!
    @IBOutlet weak var songVisualEffectView : NSVisualEffectView!

    override func viewDidLoad() {
        super.viewDidLoad()
        songVisualEffectView.alphaValue = 0
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    override func mouseEntered(e: NSEvent) {
        songVisualEffectView.alphaValue = 1
    }

    override func mouseExited(e: NSEvent) {
        delay(1.0) {
            // needs improving to add removal eg where user re-enters area
            NSAnimationContext.beginGrouping()
            NSAnimationContext.currentContext().duration = 0.5
            self.songVisualEffectView.animator().alphaValue = 0
            NSAnimationContext.endGrouping()
        }
    }

    // http://stackoverflow.com/questions/24034544/dispatch-after-gcd-in-swift/24318861#24318861
    private func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

}

