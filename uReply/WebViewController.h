//
//  WebViewController.h
//  uReply
//
//  Created by deepansh on 24/9/2017.
//  Copyright © 2017 CUHK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@property (nonatomic, strong) NSString *websiteURL;
@property (nonatomic, strong) NSString *data;

@end
