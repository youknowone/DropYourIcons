//
//  AIIconWindowController.m
//  AppstoreIcon
//
//  Created by Jeong YunWon on 13. 4. 23..
//  Copyright (c) 2013 Jeong YunWon. All rights reserved.
//

#import <cdebug/debug.h>

#import "AIIconWindowController.h"

NSString *AILastSegmentIndex = @"AILastSegmentIndex";

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

- (void)awakeFromNib {
    [super awakeFromNib];
    NSInteger selectedSegment = [[[NSUserDefaults standardUserDefaults] objectForKey:AILastSegmentIndex] integerValue];
    self.sizeSegmentControl.selectedSegment = selectedSegment;
}

- (void)enableButtons {
    [self.generateToDownloads setEnabled:YES];
    [self.generateToSelected setEnabled:YES];
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

- (void)generateIconToURL:(NSURL *)dirURL {
    static NSArray *sizes = nil;
    if (sizes == nil) {
        sizes = @[
            @[@512, @256, @128, @32, @16],
            @[@72, @57],
        ];
    }

    NSError *error = nil;
    BOOL result = [[NSFileManager defaultManager] createDirectoryAtURL:dirURL withIntermediateDirectories:YES attributes:@{} error:&error];
    if (error != nil) {
        NSLog(@"error! %@", error);
    }
    if (!result) {

    }

    NSInteger selectedSegment = self.sizeSegmentControl.selectedSegment;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:selectedSegment] forKey:AILastSegmentIndex];
    [[NSUserDefaults standardUserDefaults] synchronize];

    for (NSNumber *sizeNumber in [sizes objectAtIndex:selectedSegment]) {
        NSUInteger size = sizeNumber.integerValue;
        NSString *suffix = @"";
        {
            NSURL *outURL = [@"%@/icon_%@x%@%@.png" format:dirURL.path, sizeNumber, sizeNumber, suffix].fileURL;
            NSData *outData = self.inputImageWell.image.PNGRepresentation;
            BOOL result = [outData writeToURL:outURL atomically:YES];
            dlog(YES, @"filewriting? %d", result);
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

- (void)generateToDownloadsFolder:(id)sender {
    NSString *filename = [[[self.inputImageWell.imageURL path] lastPathComponent] stringByDeletingPathExtension];
    NSString *iconname = (filename.length > 0) ? filename : @"icon";
    NSURL *dirURL = NSPathForUserFileInDirectory(NSDownloadsDirectory, [iconname stringByAppendingString:@".iconset"]).fileURL;
    [self generateIconToURL:dirURL];
}

- (void)generateToSelectedFolder:(id)sender {
    NSSavePanel *savePanel = [NSSavePanel savePanel];
    savePanel.directoryURL = [self.inputImageWell.imageURL URLByDeletingLastPathComponent];
    savePanel.allowedFileTypes = @[@"iconset"];

    NSInteger status = [savePanel runModal];
    if (status == NSFileHandlingPanelCancelButton) {
        return;
    }

    [self generateIconToURL:savePanel.URL];
}

#pragma mark NSOpenSavePanel delegate

- (BOOL)panel:(id)sender shouldEnableURL:(NSURL *)url {
    if ([sender isKindOfClass:[NSSavePanel class]]) {
        return [url.path.pathExtension isEqualToString:@"iconset"] && url.hasDirectoryPath;
    } else {
        return [[NSImage imageFileTypes] containsObject:[url pathExtension]];
    }
}

- (BOOL)panel:(id)sender validateURL:(NSURL *)url error:(NSError *__autoreleasing *)outError {
    if ([sender isKindOfClass:[NSSavePanel class]]) {
        return YES;
    } else {
        NSImage *image = [NSImage imageByReferencingURL:url];
        return !NSSizeEqualToSize(image.size, NSSizeZero);
    }
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
