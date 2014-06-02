//
//  MainViewController.h
//  eatingSchedule
//
//  Created by nonehill on 24.04.14.
//  Copyright (c) 2014 serg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import "GADBannerView.h"

@interface MainViewController : UIViewController <UIAlertViewDelegate, MFMailComposeViewControllerDelegate>{
    
    GADBannerView *bannerView_;
}
@property (weak, nonatomic) IBOutlet UIView *adMobView;
- (IBAction)ratePressed:(id)sender;
- (IBAction)tweetPressed:(id)sender;
- (IBAction)mailPressed:(id)sender;
@end
