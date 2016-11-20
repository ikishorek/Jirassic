//
//  IconView.swift
//  SwiftStatusBarApplication
//
//  Created by Tommy Leung on 6/7/14.
//  Copyright (c) 2014 Tommy Leung. All rights reserved.
//

import Cocoa

class MenuBarIconView : NSView {
	
    fileprivate(set) var image: NSImage
    fileprivate let item: NSStatusItem
    
    var onMouseDown: (() -> ())?
    
    var isSelected: Bool {
		
        didSet {
            self.image = NSImage(named: isSelected ? "MenuBarIcon-Selected" : "MenuBarIcon-Normal")!
            if (isSelected != oldValue) {
                self.needsDisplay = true
            }
        }
    }
    
    init (item: NSStatusItem) {
		
        self.image = NSImage(named: "MenuBarIcon-Normal")!
        self.item = item
        self.isSelected = false
        
        let thickness = NSStatusBar.system().thickness
        let rect = CGRect(x: 0, y: 0, width: thickness, height: thickness)
        
        super.init(frame: rect)
    }

    required init? (coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw (_ dirtyRect: NSRect) {
		
        self.item.drawStatusBarBackground(in: dirtyRect, withHighlight: self.isSelected)
        
        let size = self.image.size
        let rect = CGRect(x: 2, y: 2, width: size.width, height: size.height)
        
        image.draw(in: rect)
    }
    
    override func mouseDown (with theEvent: NSEvent) {
        isSelected = !self.isSelected
        onMouseDown?()
    }
    
    override func mouseUp (with theEvent: NSEvent) {
		
    }
}