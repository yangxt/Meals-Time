//
//  ViewController.h
//  eatingSchedule
//
//  Created by nonehill on 15.04.14.
//  Copyright (c) 2014 serg. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ViewController : UIViewController <UITextFieldDelegate>
{
    int minutes;
    int hours;
    int currentProgramNumber;
    float weight;
    float carbs;
    float fat;
    float protein;

}

@property (strong, nonatomic) IBOutlet UIButton *myScheduleButton;
@property (strong, nonatomic) IBOutlet UILabel *hoursLabel;
@property (strong, nonatomic) IBOutlet UILabel *minutesLabel;
@property (strong, nonatomic) IBOutlet UISegmentedControl *programControl;
@property (strong, nonatomic) IBOutlet UIButton *plusMinutes;
@property (strong, nonatomic) IBOutlet UIButton *plusHours;
@property (strong, nonatomic) IBOutlet UILabel *restLabel;
@property (weak, nonatomic) IBOutlet UILabel *weightLbl;
@property (weak, nonatomic) IBOutlet UILabel *ageLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;

@property (strong, nonatomic) IBOutlet UILabel *timeThings;
@property (strong, nonatomic) IBOutlet UITextField *nameLabel;
@property (strong, nonatomic) IBOutlet UITextField *ageLabel;
@property (strong, nonatomic) IBOutlet UITextField *weightLabel;
@property (strong, nonatomic) IBOutlet UISwitch *switchRest;
@property (strong, nonatomic) IBOutlet UILabel *workoutLabel;
@property (weak, nonatomic) IBOutlet UIButton *acceptButton;

- (IBAction)workoutTime:(id)sender;
- (IBAction)switchRest:(id)sender;
- (IBAction)programSegment:(id)sender;
- (IBAction)schedulePressed:(id)sender;
- (IBAction)acceptTime:(id)sender;

- (float)calculateDailyProtein:(float)P;
- (float)calculateDailyFat:(float)F;
- (float)calculateDailyCarbs:(float)C;

- (void)checkNotifications;

@end
