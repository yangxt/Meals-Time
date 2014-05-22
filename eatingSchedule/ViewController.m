//
//  ViewController.m
//  eatingSchedule
//
//  Created by nonehill on 15.04.14.
//  Copyright (c) 2014 serg. All rights reserved.
//

#import "ViewController.h"
#import "ScheduleViewController.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize nameLabel, weightLabel, ageLabel, programControl, myScheduleButton, hoursLabel, minutesLabel, switchRest, timeThings, plusHours, plusMinutes, restLabel, workoutLabel, ageLbl, weightLbl, nameLbl, acceptButton;

#pragma mark lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Load user data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *loadName = [defaults objectForKey:@"savedName"];
    NSString *loadAge = [defaults objectForKey:@"savedAge"];
    
    [nameLabel setText:loadName];
    [ageLabel setText:loadAge];
    switchRest.on = [defaults boolForKey:@"switchRest"];
    [self switchRest:self];
    
    weight = [defaults floatForKey:@"savedWeight"];
    weightLabel.text = [NSString stringWithFormat:@"%0.f", weight];
    minutes = [defaults integerForKey:@"savedMinutes"];
    hours = [defaults integerForKey:@"savedHours"];
    if (minutes < 15) {
        hoursLabel.text = [NSString stringWithFormat:@"0%i", hours];
    }else{
        minutesLabel.text = [NSString stringWithFormat:@"%i", minutes];
    }
    if (hours == 0) {
        hoursLabel.text = [NSString stringWithFormat:@"0%i", hours];
    }else{
    hoursLabel.text = [NSString stringWithFormat:@"%i", hours];
    }
    
    currentProgramNumber = [defaults integerForKey:@"savedSegment"];
    protein = [defaults floatForKey:@"savedProtein"];
    carbs = [defaults floatForKey:@"savedCarbs"];
    fat = [defaults floatForKey:@"savedFat"];
    programControl.selectedSegmentIndex = currentProgramNumber;
    NSLog(@"name is %@ age %@ weight %f time is %i:%i", nameLabel.text, ageLabel.text, weight, hours, minutes);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark button Actions
- (IBAction)workoutTime:(id)sender {
    [minutesLabel setFont:[UIFont systemFontOfSize:40.0]];
    [hoursLabel setFont:[UIFont systemFontOfSize:40.0]];
    acceptButton.hidden = NO;
    switchRest.enabled = NO;
    programControl.enabled = NO;
    myScheduleButton.enabled = NO;
    ageLabel.hidden = YES;
    weightLabel.hidden = YES;
    nameLabel.hidden = YES;
    [UIView animateWithDuration:0.25 animations:^{
                         acceptButton.frame = CGRectMake(140, 390, 40, 40);
                         nameLbl.frame = CGRectMake(20, 100, 90, 24);
                         ageLbl.frame = CGRectMake(20, 180, 90, 24);
                         weightLbl.frame = CGRectMake(200, 180, 90, 24);
                     }];
    
    UIButton *buttonPressed = (id)sender;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (buttonPressed.tag == 1) {
        if ([hoursLabel.text isEqualToString:@"00"]) {
            hours = 1;
            hoursLabel.text = [NSString stringWithFormat:@"%i", hours];
        }else {
            hours ++;
            hoursLabel.text = [NSString stringWithFormat:@"%i", hours];
            if (hours>23) {
                hours = 0;
                hoursLabel.text = @"00";
            }
        }
    }
    
    if (buttonPressed.tag == 2) {
        if ([minutesLabel.text isEqualToString:@"00"]) {
            minutes+=15;
            minutesLabel.text = [NSString stringWithFormat:@"%i", minutes];
        }else{
            minutes+=15;
            minutesLabel.text = [NSString stringWithFormat:@"%i", minutes];
            if(minutes>59){
                minutes = 0;
                minutesLabel.text = @"00";
            }
        }
        
    }
    [defaults setInteger:hours forKey:@"savedHours"];
    [defaults setInteger:minutes forKey:@"savedMinutes"];
    [defaults synchronize];
    NSLog(@"%i : %i", hours, minutes);
}

- (IBAction)switchRest:(id)sender {
    if (switchRest.on) {
        hoursLabel.hidden = YES;
        minutesLabel.hidden = YES;
        timeThings.hidden = YES;
        plusMinutes.hidden = YES;
        plusHours.hidden = YES;
        [UIView animateWithDuration:0.25 animations:^{
            workoutLabel.frame = CGRectMake(20, 325, 182, 31);
        }];
    }else{
        [UIView animateWithDuration:0.25 animations:^{
            workoutLabel.frame = CGRectMake(20, 293, 182, 31);
        }];
        hoursLabel.hidden = NO;
        minutesLabel.hidden = NO;
        plusMinutes.hidden = NO;
        plusHours.hidden = NO;
        timeThings.hidden = NO;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:switchRest.on forKey:@"switchRest"];
    [defaults synchronize];
    [self checkNotifications];
}

- (void)schedulePressed:(id)sender{
    weight = [[weightLabel text]floatValue];
    [self programSegment:self];
}


#pragma mark choise program
- (IBAction)programSegment:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (programControl.selectedSegmentIndex == 0) {
        currentProgramNumber = 0;
        [self calculateDailyProtein:1.9];
        [self calculateDailyCarbs:2];
        [self calculateDailyFat:0.5];
    }else if (programControl.selectedSegmentIndex == 1){
        currentProgramNumber = 1;
        [self calculateDailyProtein:2.5];
        [self calculateDailyCarbs:4];
        [self calculateDailyFat:1];
    }else if (programControl.selectedSegmentIndex == 2){
        currentProgramNumber = 2;
        [self calculateDailyProtein:2.1];
        [self calculateDailyCarbs:3.7];
        [self calculateDailyFat:0.8];
    }
    NSLog(@"Calculate prot %f fat %f carb %f", protein, fat, carbs);

    [defaults setInteger:currentProgramNumber forKey:@"savedSegment"];
    [defaults setFloat:protein forKey:@"savedProtein"];
    [defaults setFloat:carbs forKey:@"savedCarbs"];
    [defaults setFloat:fat forKey:@"savedFat"];
    [defaults synchronize];
}

- (IBAction)acceptTime:(id)sender {
    [minutesLabel setFont:[UIFont systemFontOfSize:25.0]];
    [hoursLabel setFont:[UIFont systemFontOfSize:25.0]];
    programControl.enabled = YES;
    switchRest.enabled = YES;
    myScheduleButton.enabled = YES;
    ageLabel.hidden = NO;
    weightLabel.hidden = NO;
    nameLabel.hidden = NO;
    [UIView animateWithDuration:0.25
                          delay:0
                        options:UIViewAnimationOptionTransitionCrossDissolve
                     animations:^{
        acceptButton.frame = CGRectMake(-50, 390, 40, 40);
        nameLbl.frame = CGRectMake(20, 88, 90, 24);
        ageLbl.frame = CGRectMake(20, 168, 90, 24);
        weightLbl.frame = CGRectMake(200, 168, 90, 24);
    }
                     completion:^(BOOL finished){acceptButton.hidden = YES;}];
    
    [self checkNotifications];
}


#pragma mark dismiss number pad and keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{    
    [ageLabel resignFirstResponder];
    [weightLabel resignFirstResponder];
    weight = [[weightLabel text]floatValue];
    if (weight > 500) {
        weightLabel.text = @"LOL";
    }
    NSString *saveAge = ageLabel.text;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:saveAge forKey:@"savedAge"];
    [defaults setFloat:weight forKey:@"savedWeight"];
    [defaults synchronize];
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    NSString *saveName = nameLabel.text;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:saveName forKey:@"savedName"];
    [defaults synchronize];
    
   
    [self checkNotifications];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    myScheduleButton.enabled = NO;
    if (textField == nameLabel) {
        ageLabel.hidden = YES;
        weightLabel.hidden = YES;
        [UIView animateWithDuration:0.25 animations:^{
            ageLbl.frame = CGRectMake(20, 190, 90, 24);
            weightLbl.frame = CGRectMake(200, 190, 90, 24);
        }];
    }else if (textField == ageLabel || weightLabel){
        nameLabel.enabled = NO;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    myScheduleButton.enabled = YES;
    weightLabel.hidden = YES;
    [UIView animateWithDuration:0.25 animations:^{
        ageLbl.frame = CGRectMake(20, 168, 90, 24);
        weightLbl.frame = CGRectMake(200, 168, 90, 24);
    }];
    nameLabel.enabled = YES;
    ageLabel.hidden = NO;
    weightLabel.hidden = NO;
}

#pragma mark status bar Hidden
- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark Calculate CPF
- (float)calculateDailyProtein:(float)P{
    protein = weight * P;
    return protein;
}

- (float)calculateDailyFat:(float)F{
    fat = weight * F;
    return fat;
}

- (float)calculateDailyCarbs:(float)C{
    carbs = weight * C;
    return carbs;
}

#pragma mark Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [self schedulePressed:self];
    if ([segue.identifier isEqualToString:@"schedule"]) {
        ScheduleViewController *svc = [segue destinationViewController];
            svc.prot = [NSString stringWithFormat:@"%f", protein];
            svc.fat = [NSString stringWithFormat:@"%f", fat];
            svc.carb = [NSString stringWithFormat:@"%f", carbs];
            svc.program = [NSString stringWithFormat:@"%i", currentProgramNumber];
            weight = [[weightLabel text]floatValue];
            svc.weight = [NSString stringWithFormat:@"%f", weight];
        NSLog(@"segue prot %@ fat %@ carb %@", svc.prot, svc.fat, svc.carb);
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:svc.carb forKey:@"carbsValue"];
        [defaults setObject:svc.prot forKey:@"protValue"];
        [defaults setObject:svc.fat forKey:@"fatValue"];
        [defaults setObject:svc.weight forKey:@"weightValue"];
        [defaults synchronize];
    }
}

#pragma mark local notification
- (void)checkNotifications{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    minutes = [defaults integerForKey:@"savedMinutes"];
    hours = [defaults integerForKey:@"savedHours"];
    NSLog(@"name %@ hours - %i minutes - %i ", nameLabel.text, hours, minutes);

    NSArray *oldNotification = [[UIApplication sharedApplication]scheduledLocalNotifications];
    if ([oldNotification count] > 0) {
        [[UIApplication sharedApplication]cancelAllLocalNotifications];
        NSLog(@"cancel old notifications");
    }
    
    NSCalendar *gregCalendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [gregCalendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit fromDate:[NSDate date]];
    
    [dateComponents setHour:8];
    [dateComponents setMinute:0];
    
    UIDatePicker *dd = [[UIDatePicker alloc]init];
    [dd setDate:[gregCalendar dateFromComponents:dateComponents]];
    UILocalNotification *notif = [[UILocalNotification alloc]init];

    NSLog(@"create new notifications");
    for (int i = 1; i < 6; i++) {
        if (i == 1) {
            if (switchRest.isOn == NO) {
                [notif setAlertBody:[NSString stringWithFormat:@"Good morning %@! :) It's time for breakfast! You have workout today at %i:%i. Have a nice day!", nameLabel.text, hours, minutes]];
                [notif setFireDate:[NSDate dateWithTimeInterval:60*i sinceDate:dd.date]];
            }else{
                [notif setAlertBody:[NSString stringWithFormat:@"Good morning %@! :) It's time for breakfast! Have a nice day!", nameLabel.text]];
                [notif setFireDate:[NSDate dateWithTimeInterval:60*i sinceDate:dd.date]];
            }
        }else if (i == 2){
            [notif setAlertBody:@"Lunch time! Bon appetit! :)"];
            [notif setFireDate:[NSDate dateWithTimeInterval:60*60*4 sinceDate:dd.date]];

        }else if (i == 3){
            [notif setAlertBody:@"Time for afternoon snack!"];
            [notif setFireDate:[NSDate dateWithTimeInterval:60*60*7 sinceDate:dd.date]];

        }else if (i == 4){
            [notif setAlertBody:@"Dinner is waiting for you! :) Bon appetit!"];
            [notif setFireDate:[NSDate dateWithTimeInterval:60*60*11 sinceDate:dd.date]];

        }else if (i == 5){
            [notif setAlertBody:[NSString stringWithFormat:@"It was a good day! It's time for night snack %@. :)", nameLabel.text]];
            [notif setFireDate:[NSDate dateWithTimeInterval:60*60*13 sinceDate:dd.date]];
        }
        [notif setSoundName:UILocalNotificationDefaultSoundName];
        [notif setTimeZone:[NSTimeZone defaultTimeZone]];
        [notif setRepeatInterval:NSCalendarUnitDay];
        [[UIApplication sharedApplication] scheduleLocalNotification:notif];
    }
}

@end
