//
//  CWEMChecking.m
//  uReply
//
//  Created by deepansh on 31/10/2017.
//  Copyright © 2017 CUHK. All rights reserved.
//

#import "CWEMChecking.h"

@interface CWEMChecking ()

@end

@implementation CWEMChecking

@synthesize websiteURL, data, sessionNumber;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sessionNumberField.text = [NSString stringWithFormat:@"%@", sessionNumber];
    NSLog(@"URL: %@", sessionNumber);
    NSURL *url = [NSURL URLWithString:websiteURL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
