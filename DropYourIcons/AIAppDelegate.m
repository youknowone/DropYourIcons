//
//  AIAppDelegate.m
//  Drop The Icons
//
//  Created by Jeong YunWon on 13. 4. 23..
//  Copyright (c) 2013 Jeong YunWon. All rights reserved.
//

#import "AIAppDelegate.h"

@implementation AIAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)showManual:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:@"https://github.com/youknowone/DropYourIcons#drop-your-icons".URL];
}

- (void)showSource:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:@"https://github.com/youknowone/DropYourIcons".URL];
}

- (void)reportBug:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:@"https://github.com/youknowone/DropYourIcons/issues".URL];
}

- (void)donate:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:@"https://github.com/youknowone/DropYourIcons#do-you-like-this-project".URL];
}

@end
