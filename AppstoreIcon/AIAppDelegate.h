//
//  AIAppDelegate.h
//  Appstore Icon
//
//  Created by Jeong YunWon on 13. 4. 23..
//  Copyright (c) 2013 Jeong YunWon. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AIAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

- (IBAction)showSource:(id)sender;
- (IBAction)reportBug:(id)sender;

@end
