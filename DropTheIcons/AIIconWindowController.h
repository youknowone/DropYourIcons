//
//  AIIconWindowController.h
//  AppstoreIcon
//
//  Created by Jeong YunWon on 13. 4. 23..
//  Copyright (c) 2013 Jeong YunWon. All rights reserved.
//

@interface AIIconWindowController : NSWindowController<NSOpenSavePanelDelegate, NSAImageWellDelegate, NSWindowDelegate>

@property IBOutlet NSView *hintView;
@property IBOutlet NSAImageWell *inputImageWell;
@property IBOutlet NSSegmentedControl *sizeSegmentControl;
@property IBOutlet NSButton *generateToDownloads, *generateToSelected;

- (IBAction)selectInput:(id)sender;
- (IBAction)generateToDownloadsFolder:(id)sender;
- (IBAction)generateToSelectedFolder:(id)sender;

@end
