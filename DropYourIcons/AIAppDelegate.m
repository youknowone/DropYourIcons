//
//  AIAppDelegate.m
//  Drop The Icons
//
//  Created by Jeong YunWon on 13. 4. 23..
//  Copyright (c) 2013 Jeong YunWon. All rights reserved.
//

#import "AIAppDelegate.h"

@implementation AIAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}


- (void)showSource:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:@"https://github.com/youknowone/AppstoreIcon".URL];
}

- (void)reportBug:(id)sender {
    [[NSWorkspace sharedWorkspace] openURL:@"https://github.com/youknowone/AppstoreIcon/issues".URL];
}


@end
