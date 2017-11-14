//
//  ViewController.m
//  uReply
//
//  Created by deepansh on 24/9/2017.
//  Copyright © 2017 CUHK. All rights reserved.
//

#import "ViewController.h"
#import "WebViewController.h"
#import "CWEMChecking.h"

@interface ViewController () <BEMCheckBoxDelegate>

@end

@implementation ViewController
@synthesize url, sessionNumberPass, reachability;
    

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkChange:) name:kReachabilityChangedNotification object:nil];
    reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == NotReachable){
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Warning!"
                                     message:@"You are not connected to the Internet"
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* OKButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle your yes please button action here
                                   }];
        [alert addAction:OKButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (status == ReachableViaWiFi){
        NSLog(@"Wifi");
    }
    else if (status == ReachableViaWWAN){
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Warning!"
                                     message:@"You are using LTE and might incur data charges from your carrier!"
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* OKButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle your yes please button action here
                                   }];
        [alert addAction:OKButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    // Hide Navigation Bar
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    // Dismiss Keyboard (Tap Gesture)
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    NSString *studentidUserDefault = _studentID.text;
    NSString *studentnameUserDefault = _studentName.text;
    url = [NSString stringWithFormat:@"www.test.url"];
    
    _checkBox.onAnimationType = BEMAnimationTypeBounce;
    _checkBox.offAnimationType = BEMAnimationTypeBounce;
    _checkBox.delegate = self;
    
    // NSUserDefaults
    NSArray *defaultCellArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"studentid"];
    if (defaultCellArray) {
        studentidUserDefault = [NSString stringWithFormat: @"%@", @[[[NSUserDefaults standardUserDefaults] stringForKey:@"studentid"]]];
        studentnameUserDefault = [NSString stringWithFormat: @"%@", @[[[NSUserDefaults standardUserDefaults] objectForKey:@"studentname"]]];
    }
    
    if(([studentidUserDefault length] != 0) && ([studentnameUserDefault length] != 0)){
        NSLog(@"NSUserDefaultValues Exists");
        _studentName.text = studentidUserDefault;
        _studentID.text = studentidUserDefault;
        self.checkBox.on = YES;
    }else{
        
    }
    NSLog(@"NSUserDefault: %@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
}
    
- (void) handleNetworkChange:(NSNotification *)notice
{
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if(status == NotReachable){
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Warning!"
                                     message:@"You are not connected to the Internet"
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* OKButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle "OK" button action here
                                   }];
        [alert addAction:OKButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
    else if (status == ReachableViaWiFi){
        NSLog(@"Wifi");
    }
    else if (status == ReachableViaWWAN){
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Warning!"
                                     message:@"You just changed to LTE and might incur data charges from your carrier!"
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* OKButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle "OK" button action here
                                   }];
        [alert addAction:OKButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
}
-(void)dismissKeyboard
{
    [_sessionNumber resignFirstResponder];
    [_studentID resignFirstResponder];
    [_studentName resignFirstResponder];
}

-(void) animationDidStopForCheckBox:(BEMCheckBox*) checkBox{
    if(self.checkBox.on == true){
        NSLog(@"On");
        NSString *studentid = _studentID.text;
        NSString *studentname = _studentName.text;
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if(userDefaults){
            [userDefaults setValue:studentid forKey:@"studentid"];
            [userDefaults setValue:studentname forKey:@"studentname"];
            [userDefaults synchronize];
        }
    }else{
        NSLog(@"Off");
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        if(userDefaults){
            [userDefaults setValue:@"" forKey:@"studentid"];
            [userDefaults setValue:@"" forKey:@"studentname"];
            [userDefaults synchronize];
        }
    }
}

- (IBAction)loginButton:(UIButton *)sender {
    NSString *sessionNumber = _sessionNumber.text;
    NSString *studentID = _studentID.text;
    NSString *studentName = _studentName.text;
    sessionNumberPass = [NSString stringWithFormat:@"%@", sessionNumber];

    if (([studentID length] == 0 && ([_studentIDLabel.text isEqualToString:@"Student ID (Required)"])) || (([studentName length] == 0) && ([_studentNameLabel.text isEqualToString:@"Student Name (Required)"]))){
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Error"
                                     message:@"Please fill in the Required fields!"
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* OKButton = [UIAlertAction
                                   actionWithTitle:@"OK"
                                   style:UIAlertActionStyleDefault
                                   handler:^(UIAlertAction * action) {
                                       //Handle your yes please button action here
                                   }];
        [alert addAction:OKButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    if ([sessionNumber length] == 0){
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:@"Error"
                                     message:@"Please fill in the Session Number!"
                                     preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* OKButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        //Handle your yes please button action here
                                    }];
        [alert addAction:OKButton];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        // If SessionNumber is not empty:
        sessionNumber = [sessionNumber uppercaseString];
        
        // Get sessionCheck.php from server and parse the JSON
        NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ureplydev5.ureply.mobi/sessionCheck.php"]];
        NSError *error=nil;
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:data options:
                     NSJSONReadingMutableContainers error:&error];
        NSArray *valuesCount = [result allValues];
        
//        if ([valuesCount count] != 0){
//            for (int i=0; i<[valuesCount count]; i++) {
//                NSDictionary *val = [valuesCount objectAtIndex:i];
//                NSString *temperature =[val objectForKey:@"url"];
//                NSLog(@"Your JSON Object: %@ Or Error is: %@\n", temperature, error);
//            }
//        }
//
        
        if ([valuesCount count] != 0){
            NSString *s = [NSString stringWithFormat:@"%c", [sessionNumber characterAtIndex:0]];
            NSDictionary *val = [result objectForKey:s];
            if(val != nil){
                NSString *urlString = [val objectForKey:@"url"];
                NSLog(@"Your JSON Object: %@ Or Error is: %@\n", urlString, error);
                url = [NSString stringWithFormat:@"%@", urlString];
                
                if([s isEqualToString:@"L"]){
                    CWEMChecking *view;
                    view.websiteURL = [NSString stringWithFormat:@"%@", url];
                    view.sessionNumber = [NSString stringWithFormat:@"%@", sessionNumberPass];
                    [self performSegueWithIdentifier:@"check" sender:self];
                }else{
                    WebViewController *view;
                    view.websiteURL = [NSString stringWithFormat:@"%@", url];
                    [self performSegueWithIdentifier:@"webview" sender:self];
                }
            }else{
                NSLog(@"Value doesn't exist");
                NSDictionary *val = [result objectForKey:@"else"];
                if(val != nil){
                    NSString *urlString = [val objectForKey:@"url"];
                    NSLog(@"Your JSON Object: %@ Or Error is: %@\n", urlString, error);
                    url = [NSString stringWithFormat:@"%@", url];
                    WebViewController *view;
                    view.websiteURL = [NSString stringWithFormat:@"%@", urlString];
                    [self performSegueWithIdentifier:@"webview" sender:self];
                }
                
            }
        }
        
        NSLog(@"Your JSON Object: %@ Or Error is: %@\n", result, error);
        
        if([sessionNumber characterAtIndex:0] == 'L' || [sessionNumber characterAtIndex:0] == 'l'){
            
            //Pass The String to server
            NSString *userUpdate =[NSString stringWithFormat:@"in_computingid=%@&in_pass=%@", studentID, studentName, nil];
            NSLog(@"the data Details is = %@", userUpdate);
            NSData *data1 = [userUpdate dataUsingEncoding:NSUTF8StringEncoding];
            NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[userUpdate length]];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString:@"http://ureplydev5.ureply.mobi/new.php"] ];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:data1];

//            NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
            
            NSURLSession *session = [NSURLSession sharedSession];
            [[session dataTaskWithRequest:request completionHandler:^(NSData *data,NSURLResponse *response, NSError *err) {
                        NSString *resSrt = [[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding];
        
                        NSLog(@"got response == %@", resSrt);
                        
                        if(resSrt){
                            NSLog(@"Yes");
                        }
                        else{
                            NSLog(@"Failed to connect");
                        }
                    }] resume];
            
        }
        
//        double delayInSeconds = 2.0;
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            NSLog(@"Do some work");
//
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
//        [request setURL:[NSURL URLWithString:@"http://ureplydev5.ureply.mobi/test.php"]];
//        [request setHTTPMethod:@"GET"];
//
//        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
//        [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//            NSString *requestReply = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
//            NSLog(@"Request reply: %@\n", requestReply);
//        }] resume];
//            });
        /*
        if([sessionNumber characterAtIndex:0] == 'M' || [sessionNumber characterAtIndex:0] == 'H'){
            url = @"./multi/joinsession_multi.php";
            WebViewController *view;
            view.websiteURL = [NSString stringWithFormat:@"%@", url];
            [self performSegueWithIdentifier:@"webview" sender:self];
        }
        else if([sessionNumber characterAtIndex:0] == 'A'){
            //alert("test");
            url = @"http://server4.ureply.mobi/activity/student/chksession.php";
            WebViewController *view;
            view.websiteURL = [NSString stringWithFormat:@"%@", url];
            [self performSegueWithIdentifier:@"webview" sender:self];
        }
        else if([sessionNumber characterAtIndex:0] == 'S'){
            url = @"http://server4.ureply.mobi/evalcheck.php";
            WebViewController *view;
            view.websiteURL = [NSString stringWithFormat:@"%@", url];
            [self performSegueWithIdentifier:@"webview" sender:self];
        }
        else if([sessionNumber characterAtIndex:0] == 'L'){
            url = @"https://server3ssl.ureply.mobi/mobile_login_join.php";
            WebViewController *view;
            view.websiteURL = [NSString stringWithFormat:@"%@", url];
            [self performSegueWithIdentifier:@"webview" sender:self];
        }
        else if([sessionNumber characterAtIndex:0] == 'C'){
            url = @"https://med.ureply.mobi/mobile_login_join.php";
            WebViewController *view;
            view.websiteURL = [NSString stringWithFormat:@"%@", url];
            [self performSegueWithIdentifier:@"webview" sender:self];
        }
        else if([sessionNumber characterAtIndex:0] == 'G'){
            url = @"https://go.ureply.mobi/student/chksession.php";
            WebViewController *view;
            view.websiteURL = [NSString stringWithFormat:@"%@", url];
            [self performSegueWithIdentifier:@"webview" sender:self];
        }
        else{
            url = @"https://server3.ureply.mobi/joinsession.php";
            WebViewController *view;
            view.websiteURL = [NSString stringWithFormat:@"%@", url];
            [self performSegueWithIdentifier:@"webview" sender:self];
        }*/
    }

}
    
- (IBAction)editChanged:(UITextField *)sender {
    NSString *sessionNumber = _sessionNumber.text;
    NSString *studentID = _studentID.text;
    NSString *studentName = _studentName.text;
    
    if([sessionNumber length] == 0){
        _studentIDLabel.text = @"Student ID (Optional)";
        _studentNameLabel.text = @"Student Name (Optional)";
    }else{
        if([sessionNumber characterAtIndex:0] == 'L' || [sessionNumber characterAtIndex:0] == 'l'){
        }else{
            
        }
    
        if([sessionNumber characterAtIndex:0] == 'G' || [sessionNumber characterAtIndex:0] == 'g'){
        _studentIDLabel.text = @"Student ID (Required)";
        _studentNameLabel.text = @"Student Name (Required)";
            /* For making text BOLD
             NSString *text = @"Student ID (Required)";
             NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text];
             [attributedText addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13.0] range:NSMakeRange(0, text.length-1)];
             [_studentIDLabel setAttributedText: attributedText];
             */
        }else{
            _studentIDLabel.text = @"Student ID (Optional)";
            _studentNameLabel.text = @"Student Name (Optional)";
        }
    }
}
    

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"webview"]){
        WebViewController *vc = (WebViewController *)segue.destinationViewController;
        vc.websiteURL = url;
    }else if([[segue identifier] isEqualToString:@"check"]){
        CWEMChecking *vc = (CWEMChecking *)segue.destinationViewController;
        vc.websiteURL = url;
        vc.sessionNumber = sessionNumberPass;
    }

}
    
@end
