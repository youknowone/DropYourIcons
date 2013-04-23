//
//  AIIconWindowController.m
//  AppstoreIcon
//
//  Created by Jeong YunWon on 13. 4. 23..
//  Copyright (c) 2013 Jeong YunWon. All rights reserved.
//

#import "AIIconWindowController.h"

@interface AIIconWindowController ()

@end

@implementation AIIconWindowController

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

#pragma mark NSAImageWell delegate

- (BOOL)imageWellShouldAcceptURLString:(NSAImageWell *)imageWell {
    return YES;
}

- (void)imageWell:(NSAImageWell *)imageWell didDraggingEntered:(id<NSDraggingInfo>)sender {
    self.hintView.alphaValue = 0.5;
}

- (void)imageWell:(NSAImageWell *)imageWell didDraggingExited:(id<NSDraggingInfo>)sender {
    self.hintView.alphaValue = 1;
}

@end
