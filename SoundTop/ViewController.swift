// ViewController.swift
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

class ViewController: NSViewController {
    @IBOutlet weak var albumView : STAlbumView!

    @IBOutlet weak var songInfoView : STSongInfoView!
    @IBOutlet weak var songVisualEffectView : NSVisualEffectView!

    @IBOutlet weak var playerVisualEffectView : NSVisualEffectView!
    @IBOutlet weak var playerView : STPlayerView!

    var mouseInsideView : Bool = false

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateTrack", name: "newTrack", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "playing", name: "playing", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "paused", name: "paused", object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        songVisualEffectView.alphaValue = 0
        playerVisualEffectView.alphaValue = 0
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    override func mouseEntered(e: NSEvent) {
        mouseInsideView = true
        songVisualEffectView.alphaValue = 1
        playerVisualEffectView.alphaValue = 1
    }

    override func mouseExited(e: NSEvent) {
        mouseInsideView = false
        delay(1.0) {
            if(!self.mouseInsideView) {
                NSAnimationContext.beginGrouping()
                NSAnimationContext.currentContext().duration = 0.5
                self.songVisualEffectView.animator().alphaValue = 0
                self.playerVisualEffectView.animator().alphaValue = 0
                NSAnimationContext.endGrouping()
            }
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

    func updateTrack() {
        let delegate = NSApplication.sharedApplication().delegate as AppDelegate
        let track = delegate.currentTrack
        let url = NSURL(string: track!.largeAlbumArt!)
        albumView.fetchImage(url!)
        songInfoView.updateTrack(track!)
    }

    func playing() {
        playerView.playing()
    }

    func paused() {
        playerView.paused()
    }
}

