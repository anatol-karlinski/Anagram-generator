//
//  ViewController.m
//  anagramGenerator
//
//  Created by osx on 14/11/15.
//  Copyright © 2015 osx. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize textInput;
@synthesize textOutput;
@synthesize lenght;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)setRepresentedObject:(id)representedObject
{
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}


- (IBAction)generateButton:(NSButton *)sender
{
    [self generujAnagramy];
}

- (IBAction)zapiszButton:(id)sender
{
    NSString *rawString = [textOutput stringValue];
    NSArray *entries = [rawString componentsSeparatedByString:@"\n"];
    entries = [entries sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"length" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    entries = [entries sortedArrayUsingDescriptors:sortDescriptors];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths objectAtIndex:0];
    NSString *plistPath = [documentPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", [textInput stringValue]]];
    NSMutableDictionary *dict = [[NSMutableDictionary dictionary]init];
    
    [dict setValue:entries forKey:@"odpowiedzi"];
    
    NSMutableString *litery = [NSMutableString stringWithFormat:@""];
    for(int i = 0; i < [[textInput stringValue]length]; i++)
    {
        [litery appendString:[NSString stringWithFormat:@"%C", [[textInput stringValue] characterAtIndex:i]]];
        if (i != [[textInput stringValue]length] - 1)
            [litery appendString:@";"];
    }
    [dict setValue:litery forKey:@"litery"];
    [dict writeToFile:plistPath atomically:YES];
}

- (IBAction)find:(NSButton *)sender
{
    NSString* sciezkaDB = [[NSBundle mainBundle] pathForResource:@"polish"
                                                          ofType:@"txt"];
    
    NSMutableString* content = [NSMutableString stringWithContentsOfFile:sciezkaDB
                                                                encoding:NSUTF8StringEncoding
                                                                   error:NULL];
    
    NSMutableArray *stringArray = (NSMutableArray *)[content componentsSeparatedByString: @"\n"];
    NSMutableString *output = [NSMutableString stringWithFormat:@""];
    
    for(int i = 0; i<[stringArray count]; i++)
    {
        BOOL flag = true;
        
        if ([[stringArray objectAtIndex:i] length] == [lenght integerValue])
        {
            for (int j = 0; j<[[stringArray objectAtIndex:i] length];j++)
            {
                NSString *temp = [NSString stringWithFormat:@"%C",[[stringArray objectAtIndex:i] characterAtIndex:j]];
                
                NSInteger strCount = [[stringArray objectAtIndex:i] length] - [[[stringArray objectAtIndex:i] stringByReplacingOccurrencesOfString:temp withString:@""] length];
                
                if(strCount > 1) flag = false;
            }
            
            if(flag && [[stringArray objectAtIndex:i] length] > 1)
            {
                [output appendString:[NSString stringWithFormat:@"%@\n", [stringArray objectAtIndex:i]]];
            }
        }
    }
    [textOutput setStringValue:[output substringToIndex:[output length]-1]];
}

-(void)generujAnagramy
{
    NSString* sciezkaDB = [[NSBundle mainBundle] pathForResource:@"polish"
                                                          ofType:@"txt"];
    
    NSMutableString* content = [NSMutableString stringWithContentsOfFile:sciezkaDB
                                                                encoding:NSUTF8StringEncoding
                                                                   error:NULL];
    
    NSMutableArray *stringArray = (NSMutableArray *)[content componentsSeparatedByString: @"\n"];
    NSMutableString *output = [NSMutableString stringWithFormat:@""];
    
    for(int i = 0; i<[stringArray count]; i++)
    {
        BOOL flag = true;

        if ([[stringArray objectAtIndex:i] length] <= [[textInput stringValue] length])
        {
            for (int j = 0; j<[[stringArray objectAtIndex:i] length];j++)
            {
                NSString *temp = [NSString stringWithFormat:@"%C",[[stringArray objectAtIndex:i] characterAtIndex:j]];
                
                NSInteger strCount = [[stringArray objectAtIndex:i] length] - [[[stringArray objectAtIndex:i] stringByReplacingOccurrencesOfString:temp withString:@""] length];
                
                if(![[textInput stringValue] containsString:temp] || strCount > 1) flag = false;
            }
            
            if(flag && [[stringArray objectAtIndex:i] length] > 1)
            {
                [output appendString:[NSString stringWithFormat:@"%@\n", [stringArray objectAtIndex:i]]];
            }
        }
    }
    [textOutput setStringValue:[output substringToIndex:[output length]-1]];
}

- (NSString *)sortedString: (NSMutableString *)string
{
    NSString* temp, *temp2;
    NSMutableString *output = [NSMutableString stringWithFormat:@""];
    NSMutableArray *slowo = [[NSMutableArray alloc] initWithCapacity:[string length]];
    
    for (int i=0; i < [string length]; i++)
    {
        NSString *ichar  = [NSString stringWithFormat:@"%c", [string characterAtIndex:i]];
        [slowo addObject:ichar];
    }

    for(int i = 0; i<[slowo count]; i++)
    {
        for(int j = 0; j<[slowo count]-i-1; j++)
        {
            if ([slowo objectAtIndex:j]>[slowo objectAtIndex:j+1])
            {
                temp = (NSString *)[slowo objectAtIndex:j+1];
                temp2 = (NSString *)[slowo objectAtIndex:j];
                [slowo replaceObjectAtIndex:j withObject:temp];
                [slowo replaceObjectAtIndex:j+1 withObject:temp2];
            }
        }
    }
    for (NSString *str in slowo){
        [output appendString:str];
    }
    return (NSString *)output;
}

@end
