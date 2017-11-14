//
//  ViewController.h
//  uReply
//
//  Created by deepansh on 24/9/2017.
//  Copyright © 2017 CUHK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"
#import "BEMCheckBox.h"
#import "Reachability.h"

@interface ViewController : UIViewController<UITextFieldDelegate>
@property (nonatomic, strong) WebViewController *WebviewController;

- (IBAction)loginButton:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *sessionNumber;
@property (weak, nonatomic) IBOutlet UITextField *studentID;
@property (weak, nonatomic) IBOutlet UITextField *studentName;
@property (weak, nonatomic) IBOutlet UILabel *studentIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *studentNameLabel;
@property (weak, nonatomic) IBOutlet BEMCheckBox *checkBox;
@property Reachability* reachability;

@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSString* sessionNumberPass;

@end

