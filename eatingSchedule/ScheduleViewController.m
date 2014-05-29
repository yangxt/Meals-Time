//
//  ScheduleViewController.m
//  eatingSchedule
//
//  Created by nonehill on 17.04.14.
//  Copyright (c) 2014 serg. All rights reserved.
//

#import "ScheduleViewController.h"

@interface ScheduleViewController ()

@end

@implementation ScheduleViewController 
@synthesize breakfast, morningSnack, lunch, afternoonSnack, dinner, prot, carb, fat, weight;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    fat = [defaults stringForKey:@"fatValue"];
    weight = [defaults stringForKey:@"weightValue"];
    prot = [defaults stringForKey:@"protValue"];
    carb = [defaults stringForKey:@"carbsValue"];    
    [defaults synchronize];
    
    fatValue = fat.floatValue;
    proteinValue = prot.floatValue;
    carbsValue = carb.floatValue;
    weightValue = weight.floatValue;
    
    NSLog(@"fat %f carb %f prot %f", fatValue, carbsValue, proteinValue);
    
    if (weightValue < 30) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"Set your weight for calculate schedule" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
        [alertView show];
        breakfast.text = @"Eat schedule";
        morningSnack.text = @"Eat schedule";
        lunch.text = @"Eat schedule";
        afternoonSnack.text = @"Eat schedule";
        dinner.text = @"Eat schedule";
    }else{
    breakfast.text = [NSString stringWithFormat:@"protein %.f fat %.f carbs %.f", proteinValue/5+5.2, fatValue/4-1.7, carbsValue/4+6.3];
    morningSnack.text = [NSString stringWithFormat:@"protein %.f fat %.f carbs %.f", proteinValue/5, fatValue/4+1.7, carbsValue/4-6.3];
    lunch.text = [NSString stringWithFormat:@"protein %.f fat %.f carbs %.f", proteinValue/5-5.2, fatValue/4-1.8, carbsValue/4-6.5];
    afternoonSnack.text = [NSString stringWithFormat:@"protein %.f fat %.f carbs %.f", proteinValue/5+7, fatValue/4+1.8, carbsValue/4+6.5];
    dinner.text = [NSString stringWithFormat:@"protein %.f fat %.f carbs %.f", proteinValue/5-10, weightValue/100, weightValue/100+5];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark Share schedule
- (IBAction)tellFriendPressed:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"Share your schedule with friends via ..." delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Facebook", @"Twitter", @"Message", @"Mail", nil];
    [actionSheet showInView:self.view];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
            SLComposeViewController *facebook =[[SLComposeViewController alloc]init];
            facebook = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            [facebook setInitialText:[NSString stringWithFormat:@"My daily amount(grams) of protein - %.f, fat - %.f, carbs - %.f. Eat right with Meals Time app. Download it today https://itunes.apple.com/UA/app/id873941719?mt=8", proteinValue, fatValue, carbsValue]];
            [self presentViewController:facebook animated:YES completion:nil];
        }
        NSLog(@"FACEBOOK SHARE");
    }else if (buttonIndex == 1){
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
            SLComposeViewController *twitter = [[SLComposeViewController alloc]init];
            twitter = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            [twitter setInitialText:[NSString stringWithFormat:@"My daily amount(grams) of protein - %.f, fat - %.f, carbs - %.f. Eat right with @MealsTimeApp. Download it today https://itunes.apple.com/UA/app/id873941719?mt=8", proteinValue, fatValue, carbsValue]];
            [self presentViewController:twitter animated:YES completion:nil];
        }
    }else if (buttonIndex == 2){
        MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc]init];
        [messageController setMessageComposeDelegate:self];
        if ([MFMessageComposeViewController canSendText]) {
            [messageController setRecipients:[NSArray arrayWithObjects:nil]];
            [messageController setBody:[NSString stringWithFormat:@"My daily amount(grams) of protein - %.f, fat - %.f, carbs - %.f. And what yours? Go and check it! https://itunes.apple.com/UA/app/id873941719?mt=8", proteinValue, fatValue, carbsValue]];
            [self presentViewController:messageController animated:YES completion:nil];
        }
    }else if (buttonIndex == 3){
        
        MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc]init];
        [mailController setMailComposeDelegate:self];
        [mailController setSubject:@"Check out Meals Time app, it's awesome bro!"];
        [mailController setMessageBody:[NSString stringWithFormat:@"My daily amount(grams) of protein - %.f, fat - %.f, carbs - %.f. And what yours? Go and check it! https://itunes.apple.com/UA/app/id873941719?mt=8", proteinValue, fatValue, carbsValue] isHTML:NO];
        [self presentViewController:mailController animated:YES completion:nil];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
