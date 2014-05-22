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
    breakfast.text = [NSString stringWithFormat:@"protein %.1f fat %.1f carbs %.1f", proteinValue/5+5.2, fatValue/4-1.7, carbsValue/4+6.3];
    morningSnack.text = [NSString stringWithFormat:@"protein %.1f fat %.1f carbs %.1f", proteinValue/5, fatValue/4+1.7, carbsValue/4-6.3];
    lunch.text = [NSString stringWithFormat:@"protein %.1f fat %.1f carbs %.1f", proteinValue/5-5.2, fatValue/4-1.8, carbsValue/4-6.5];
    afternoonSnack.text = [NSString stringWithFormat:@"protein %.1f fat %.1f carbs %.1f", proteinValue/5+7, fatValue/4+1.8, carbsValue/4+6.5];
    dinner.text = [NSString stringWithFormat:@"protein %.1f fat %.1f carbs %.1f", proteinValue/5-10, weightValue/100, weightValue/100+5];
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

@end
