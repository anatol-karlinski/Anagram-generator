//
//  ViewController.h
//  anagramGenerator
//
//  Created by osx on 14/11/15.
//  Copyright © 2015 osx. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController
@property (weak) IBOutlet NSTextField *textInput;

@property (weak) IBOutlet NSTextField *textOutput;

- (IBAction)generateButton:(NSButton *)sender;
- (IBAction)zapiszButton:(id)sender;
- (IBAction)find:(NSButton *)sender;
@property (weak) IBOutlet NSTextField *lenght;



@end

