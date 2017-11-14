//
//  WebViewController.m
//  uReply
//
//  Created by deepansh on 24/9/2017.
//  Copyright © 2017 CUHK. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

@synthesize websiteURL, data;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"URL: %@", websiteURL);
    NSURL *url = [NSURL URLWithString:websiteURL];
    NSURLRequest *requestURL =[NSURLRequest requestWithURL:url];
    _webview.frame=self.view.frame;
    _webview.autoresizesSubviews = YES;
    [_webview loadRequest:requestURL];
    
    // Right Guest Button
    UIButton *quitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [quitButton addTarget:self
               action:@selector(aMethod:)
     forControlEvents:UIControlEventTouchUpInside];
    [quitButton setTitle:@"Quit Session" forState:UIControlStateNormal];
    quitButton.frame = CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height - 55, self.view.frame.size.width/2, 55.0);
    [quitButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [quitButton setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:quitButton];
    
    // Left Student ID Button:
    UIButton *IDbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [IDbutton addTarget:self
               action:@selector(aMethod:)
     forControlEvents:UIControlEventTouchUpInside];
    [IDbutton setTitle:@"Student ID:" forState:UIControlStateNormal];
    IDbutton.frame = CGRectMake(0, self.view.frame.size.height - 55, self.view.frame.size.width/2, 55.0);
    [IDbutton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [IDbutton setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:IDbutton];
}

-(void)aMethod: (UIButton*)sender{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Alert"
                                 message:@"Are you sure you want to quit?"
                                 preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* NoButton = [UIAlertAction
                               actionWithTitle:@"NO"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   //Handle "No" button action
                               }];
    UIAlertAction* YesButton = [UIAlertAction
                                actionWithTitle:@"YES"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    [self.navigationController popToRootViewControllerAnimated:YES];
                                }];
    
    [alert addAction:NoButton];
    [alert addAction:YesButton];
    [self presentViewController:alert animated:YES completion:nil];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
