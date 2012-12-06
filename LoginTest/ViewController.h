//
//  ViewController.h
//  LoginTest
//
//  Created by Ian Bettison on 29/11/2012.
//  Copyright (c) 2012 Ian Bettison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *userEmailAddress;
@property (strong, nonatomic) IBOutlet UITextField *userPassword;
@property (strong, nonatomic) NSString *emailAddress;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *loginConfirmed;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSArray *permissions;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *progressIndicator;
- (BOOL)checkloginDetails:(NSString *)email withPassword:(NSString *)password;

@end
