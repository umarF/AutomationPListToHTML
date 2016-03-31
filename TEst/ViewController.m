//
//  ViewController.m
//  TEst
//
//  Created by Umar Farooque on 07/01/16.
//  Copyright © 2016 Umar Farooque. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableData *data;
    NSMutableData *data2;

    #pragma mark REPLACE WITH NAME OF YOUR .PLIST LOG FILE
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Automation Results" ofType:@"plist"]];
    NSString *htmlStr=@"";
    NSString *htmlStr2=@"";
    NSArray *array = [dictionary objectForKey:@"All Samples"];
    htmlStr = @"<?xml version='1.0' encoding='UTF-8'?>";
    htmlStr = [NSString stringWithFormat:@"%@\n<report>",htmlStr];
    int passCount =0 ,failCount = 0,totalCount = 0;
    
    for (int i =0 ; i< array.count; i++) {
        
        htmlStr = [NSString stringWithFormat:@"%@\n<item>",htmlStr];
        htmlStr = [NSString stringWithFormat:@"%@\n<Index>%d</Index>",htmlStr,i];
        htmlStr = [NSString stringWithFormat:@"%@\n<LogType>%@</LogType>",htmlStr,[array[i] valueForKey:@"LogType"]];
        htmlStr = [NSString stringWithFormat:@"%@\n<Message>%@</Message>",htmlStr,[array[i] valueForKey:@"Message"]];
        htmlStr = [NSString stringWithFormat:@"%@\n<Timestamp>%@</Timestamp>",htmlStr,[array[i] valueForKey:@"Timestamp"]];
        htmlStr = [NSString stringWithFormat:@"%@\n</item>",htmlStr];
        
    }
    
    htmlStr = [NSString stringWithFormat:@"%@\n</report>",htmlStr];
    data = [NSMutableData dataWithBytes:htmlStr.UTF8String length:htmlStr.length];
    NSError *error = nil;
    
    #pragma mark REPLACE WITH YOUR DESTINATION FILE PATH
    if ([data writeToFile:@"/Users/umar/Desktop/htmlLog.html" options:NSDataWritingAtomic error:&error]){
        
        NSLog(@"Successfully parsed file.");
        
    }else{
        
        NSLog(@"Write returned error: %@", [error localizedDescription]);
        
    }
    htmlStr2 = [NSString stringWithFormat:@"<?xml version='1.0' encoding='UTF-8'?>\n<html xmlns:bar='http://www.bar.org' xmlns:foo='http://www.foo.org/'>\n<body>\n<h2>Shine iOS UIAutomation Testing report - %@</h2><table border='1'><tr bgcolor='#9acd32'><th>Index</th><th>LogType</th><th>Message</th><th>Timestamp</th></tr>",[NSDate date]];

    
    for (int i =0 ; i< array.count; i++) {
        
        if ([[array[i] valueForKey:@"LogType"] isEqualToString:@"Pass"]) {
            passCount = passCount + 1;
            htmlStr2 = [NSString stringWithFormat:@"%@\n<tr bgcolor='#9acd32'>",htmlStr2];

        }else if ([[array[i] valueForKey:@"LogType"] isEqualToString:@"Fail"]) {
            failCount = failCount + 1;
            htmlStr2 = [NSString stringWithFormat:@"%@\n<tr bgcolor='#FF0000'>",htmlStr2];

            
        } else if ([[array[i] valueForKey:@"LogType"] isEqualToString:@"Default"]) {
         
            htmlStr2 = [NSString stringWithFormat:@"%@\n<tr bgcolor='#A8A8A8'>",htmlStr2];

            
        }else{
            
            htmlStr2 = [NSString stringWithFormat:@"%@\n<tr>",htmlStr2];

        }
        htmlStr2 = [NSString stringWithFormat:@"%@\n<td>%d</td>",htmlStr2,i];
        htmlStr2 = [NSString stringWithFormat:@"%@\n<td>%@</td>",htmlStr2,[array[i] valueForKey:@"LogType"]];
        htmlStr2 = [NSString stringWithFormat:@"%@\n<td>%@</td>",htmlStr2,[array[i] valueForKey:@"Message"]];
        htmlStr2 = [NSString stringWithFormat:@"%@\n<td>%@</td>",htmlStr2,[array[i] valueForKey:@"Timestamp"]];
        htmlStr2 = [NSString stringWithFormat:@"%@\n</tr>",htmlStr2];
        
    }
    
    totalCount = passCount + failCount;
    htmlStr2 = [NSString stringWithFormat:@"%@\n</table></body><br><h3>Total test: %d<br>Pass: %d<br>Fail: %d<br></h3></html>",htmlStr2,totalCount,passCount,failCount];
    
    data2 = [NSMutableData dataWithBytes:htmlStr2.UTF8String length:htmlStr2.length];
    NSError *error2 = nil;
    #pragma mark REPLACE WITH YOUR DESTINATION FILE PATH
    if ([data2 writeToFile:@"/Users/umar/Desktop/htmlLog.html" options:NSDataWritingAtomic error:&error2]){
        
        NSLog(@"Successfully parsed file.");
        
    }else{
        
        NSLog(@"Write returned error: %@", [error2 localizedDescription]);
        
    }

    
   
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
