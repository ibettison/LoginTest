//
//  ScanViewController.h
//  LoginTest
//
//  Created by Ian Bettison on 03/12/2012.
//  Copyright (c) 2012 Ian Bettison. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "Scanner.h"

@interface ScanViewController : UIViewController {
    IBOutlet UIButton *ScanButton;
    IBOutlet UIButton *StopButton;
    IBOutlet UIButton *CloseButton;
    IBOutlet UILabel *Label;
    IBOutlet UILabel *LabelDecode;
    IBOutlet UITextField *textContainer;
    IBOutlet UILabel *LabelNoti;
    IBOutlet UILabel *LabelType;
    IBOutlet UIButton *UpdateButton;
    IBOutlet UIButton *TorchButton;
    void* m_pScanner;
    int m_bTorch;
    
}

-(void) initLocal;
-(void) onError: (const char*) str;
-(void) onNotify: (const char*) str;
-(void) onDecode: (const unsigned short*) str:(const char*) strType:(const char*) strMode;
-(void) OnCameraStopOrStart:(int) on;
- (IBAction)UdateLicPressed;
- (IBAction)StopPressed;
- (IBAction)ClosePressed;
- (IBAction)TorchPressed;
- (void) OnForground;
- (void) OnBackground;
@end
