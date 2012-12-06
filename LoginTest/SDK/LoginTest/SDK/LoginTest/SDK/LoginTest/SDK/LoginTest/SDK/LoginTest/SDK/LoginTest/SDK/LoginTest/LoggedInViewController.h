//
//  LoggedInViewController.h
//  LoginTest
//
//  Created by Ian Bettison on 29/11/2012.
//  Copyright (c) 2012 Ian Bettison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoggedInViewController : UITableViewController
@property (strong, nonatomic) NSString *loggedIn;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSArray *permissions;

@property (strong, nonatomic) NSDictionary *menuItems;
@property (strong, nonatomic) NSArray *menuList;
@end
