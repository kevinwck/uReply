//
//  CWEMChecking.h
//  uReply
//
//  Created by deepansh on 31/10/2017.
//  Copyright © 2017 CUHK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CWEMChecking : UIViewController

@property (nonatomic, strong) NSString *websiteURL;
@property (nonatomic, strong) NSString *sessionNumber;
@property (nonatomic, strong) NSString *data;
@property (weak, nonatomic) IBOutlet UITextField *sessionNumberField;
@property (weak, nonatomic) IBOutlet UITextField *computingID;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end
