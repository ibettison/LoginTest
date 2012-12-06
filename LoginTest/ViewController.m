//
//  ViewController.m
//  LoginTest
//
//  Created by Ian Bettison on 29/11/2012.
//  Copyright (c) 2012 Ian Bettison. All rights reserved.
//

#import "ViewController.h"
#import "LoggedInViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // Focus the text field and show the keyboard
    [self.userEmailAddress becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginButtonPressed:(id)sender {
    NSLog(@"Button Pressed");
    self.emailAddress = self.userEmailAddress.text;
    self.password = self.userPassword.text;
    [self checkloginDetails:self.emailAddress withPassword:self.password];
    //this is where we check for the email and password has been entered and call the method to send to the segue
    
}
- (BOOL)checkloginDetails:(NSString *)email withPassword:(NSString *)password{
    //this method checks the values from the database and determines if the login details 
    NSLog(@"emailAdd =%@ and password = %@", email, password);
    // Prepare the URL for fetching
    NSString *encodedPass = [self.password stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *encodedEmail = [self.emailAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *searchLocation = [NSString stringWithFormat:@"http://localhost:8888/STS/json.php?func=searchjson&pass=%@&email=%@", encodedPass, encodedEmail];
    NSLog(@"searchLoc = %@", searchLocation);
    NSURL *searchURL = [NSURL URLWithString:searchLocation];
    NSLog(@"searchURL = %@", searchURL);
    // Download and parse the JSON
    // need to do this on another thread
    [self.progressIndicator startAnimating];
    NSData *JSONData = [[NSData alloc] initWithContentsOfURL:searchURL];//executes on 1st thread
    if ([JSONData length] > 0) {
        // If data was returned, parse it as JSON
        NSError *error = nil;
        NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:JSONData options:0 error:&error];
        
        NSLog(@"dictionary = %@", JSONDictionary);
        if (!JSONDictionary) {
            NSLog(@"JSON parsing failed: %@", error);
        }
        NSLog(@"JSON = %@", JSONDictionary);
        self.loginConfirmed = [NSString stringWithFormat:@"%@",[JSONDictionary valueForKey:@"login"]];
        self.userName = [NSString stringWithFormat:@"%@",[JSONDictionary valueForKey:@"user"]];
        self.permissions = [NSString stringWithFormat:@"%@",[JSONDictionary valueForKey:@"permissions"]];
        NSLog(@"%@", self.loginConfirmed);
        if([[JSONDictionary objectForKey:@"login"] isEqualToString:@"confirmed"]) {
            [[[UIAlertView alloc] initWithTitle:@"Login" message:@"You have logged in to the Biobank Sample Tracking system." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil] show];
        }else{
            [[[UIAlertView alloc] initWithTitle:@"Error" message:@"You have not been able to login to the Biobank Sample Tracking system." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil] show];
        }
        [JSONData release];
    } else {
        // Otherwise show an error message
        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"You have not been able to login to the Biobank Sample Tracking system." delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil] show];
    }
     sleep(1);
    [self.progressIndicator stopAnimating];
   
    return YES;
}

#pragma mark Segues

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if([identifier isEqualToString:@"confirmed"]) {
        
        if([self.loginConfirmed isEqualToString:@"confirmed"]){
            return YES;
        }
    }
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([segue.identifier isEqualToString:self.loginConfirmed]) {
        // Pass the search term to the results view controller so it can be queried
        LoggedInViewController *controller = segue.destinationViewController;
        controller.loggedIn = self.loginConfirmed;
        controller.userName = self.userName;
        controller.permissions = self.permissions;
        
    }
}
@end
