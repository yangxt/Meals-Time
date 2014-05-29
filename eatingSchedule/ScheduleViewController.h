//
//  ScheduleViewController.h
//  eatingSchedule
//
//  Created by nonehill on 17.04.14.
//  Copyright (c) 2014 serg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>

@interface ScheduleViewController : UIViewController <UIAlertViewDelegate, UIActionSheetDelegate, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate>
{    
        int currentProgramNumber;
        float weightValue;
        float carbsValue;
        float fatValue;
        float proteinValue;
}

@property (weak, nonatomic) IBOutlet UILabel *breakfast;
@property (weak, nonatomic) IBOutlet UILabel *morningSnack;
@property (weak, nonatomic) IBOutlet UILabel *lunch;
@property (weak, nonatomic) IBOutlet UILabel *afternoonSnack;
@property (weak, nonatomic) IBOutlet UILabel *dinner;

@property (weak, nonatomic)  NSString *prot;
@property (weak, nonatomic)  NSString *fat;
@property (weak, nonatomic)  NSString *carb;
@property (weak, nonatomic)  NSString *program;
@property (weak, nonatomic)  NSString *weight;
- (IBAction)tellFriendPressed:(id)sender;
@end
