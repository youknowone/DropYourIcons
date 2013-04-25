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

- (void)enableButtons {
    [self.generateToDownloads setEnabled:YES];
    [self.generateToSelected setEnabled:YES];
    NSLog(@"%d %d", [self.generateToDownloads isEnabled], [self.generateToSelected isEnabled]);
}

- (void)selectInput:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    panel.delegate = self;
    NSInteger status = [panel runModal];
    if (status == NSFileHandlingPanelCancelButton) {
        return;
    }
    self.inputImageWell.imageURL = panel.URL;
    [self enableButtons];
}

- (void)generateToDownloadsFolder:(id)sender {
    NSURL *dirURL = NSPathForUserFileInDirectory(NSDownloadsDirectory, @"icon.iconset").fileURL;
    BOOL result = [[NSFileManager defaultManager] createDirectoryAtURL:dirURL withIntermediateDirectories:YES attributes:@{} error:NULL];
    if (!result) {

    }

    for (NSNumber *sizeNumber in @[@512, @256, @128, @32, @16]) {
        NSUInteger size = sizeNumber.integerValue;
        NSString *suffix = @"";
        {
            NSURL *outURL = [@"%@/icon_%@x%@%@.png" format:dirURL.path, sizeNumber, sizeNumber, suffix].fileURL;
            NSData *outData = self.inputImageWell.image.PNGRepresentation;
            [outData writeToURL:outURL atomically:YES];
            system([@"sips -z %lu %lu -s format png '%@'" format0:0, size, size, outURL.path].UTF8String);
        }
        size *= 2;
        suffix = @"@2x";
        {
            NSURL *outURL = [@"%@/icon_%@x%@%@.png" format:dirURL.path, sizeNumber, sizeNumber, suffix].fileURL;
            NSData *outData = self.inputImageWell.image.PNGRepresentation;
            [outData writeToURL:outURL atomically:YES];
            system([@"sips -z %lu %lu -s format png '%@'" format0:0, size, size, outURL.path].UTF8String);
        }
    }
}

- (void)generateToSelectedFolder:(id)sender {
    NSSavePanel *savePanel = [NSSavePanel savePanel];
}

#pragma mark NSOpenSavePanel delegate

- (BOOL)panel:(id)sender shouldEnableURL:(NSURL *)url {
    return [[NSImage imageFileTypes] containsObject:[url pathExtension]];
}

- (BOOL)panel:(id)sender validateURL:(NSURL *)url error:(NSError *__autoreleasing *)outError {
    NSImage *image = [NSImage imageByReferencingURL:url];
    return !NSSizeEqualToSize(image.size, NSSizeZero);
}

#pragma mark NSAImageWell delegate

- (BOOL)imageWellShouldAcceptURLString:(NSAImageWell *)imageWell {
    return YES;
}

- (void)imageWell:(NSAImageWell *)imageWell didDraggingEntered:(id<NSDraggingInfo>)sender {
    NSAnimation *animation = [[NSAnimation alloc] initWithDuration:1.0 animationCurve:NSAnimationEaseIn];
    [animation setAnimationBlockingMode:NSAnimationNonblocking];
    [animation startAnimation];
    self.hintView.alphaValue = 0.5;
}

- (void)imageWell:(NSAImageWell *)imageWell didDraggingExited:(id<NSDraggingInfo>)sender {
    self.hintView.alphaValue = 1;
}

- (void)imageWell:(NSAImageWell *)imageWell didReceiveDragging:(id<NSDraggingInfo>)sender {
    self.hintView.alphaValue = 1;
    [self enableButtons];
}

@end
