//
//  MainViewController.m
//  eatingSchedule
//
//  Created by nonehill on 24.04.14.
//  Copyright (c) 2014 serg. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSInteger launchCount = [def integerForKey:@"launchCount"];
    launchCount++;
    if (launchCount == 3) {
        launchCount = 0;
        UIAlertView *rateAlert = [[UIAlertView alloc]initWithTitle:@"Please rate Meals Time on App Store!"
                                                           message:@"It helps us to make more cool updates."
                                                          delegate:self
                                                 cancelButtonTitle:@"No, thanks"
                                                 otherButtonTitles:@"Rate", nil];
        [rateAlert show];
        
        NSLog(@"ALERT RATE");
    }
    NSLog(@"launchCount %li", (long)launchCount);

    [def setInteger:launchCount forKey:@"launchCount"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"clickedButtonAtIndex = %i", buttonIndex);
    if (buttonIndex != alertView.cancelButtonIndex) {
        NSLog(@"Rate clicked");
        [[UIApplication sharedApplication]
         openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/UA/app/id873941719?mt=8"]];
    }
}

#pragma mark Twitter
- (IBAction)ratePressed:(id)sender {
    [[UIApplication sharedApplication]
     openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/UA/app/id873941719?mt=8"]];
}

- (IBAction)tweetPressed:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *twitter = [[SLComposeViewController alloc]init];
        twitter = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [twitter setInitialText:[NSString stringWithFormat:@"@MealsTimeApp "]];
        [self presentViewController:twitter animated:YES completion:nil];
    }
}

#pragma mark Mail
- (IBAction)mailPressed:(id)sender {
    NSString *emailTitle = @"Feedback";
    NSArray *toRecipents = [NSArray arrayWithObject:@"mealstimeapp@gmail.com"];
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc]init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setToRecipients:toRecipents];
    [self presentViewController:mc animated:YES completion:nil];
}

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"mail canceled");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"mail failed %@", [error localizedDescription]);
        case MFMailComposeResultSaved:
            NSLog(@"mail saved");
        case MFMailComposeResultSent:
            NSLog(@"Success");
        default:
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
