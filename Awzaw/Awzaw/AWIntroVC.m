//
//  ViewController.m
//  Awzaw
//
//  Created by Darshit Vora on 11/10/17.
//  Copyright © 2017 MrpVision. All rights reserved.
//

#import "AWIntroVC.h"
#import "AWPhoneVerificationVC.h"
#import "AWCreateCollectionVC.h"
#import "AWHomeVC.h"
#import "AWSignUpVC.h"

@interface AWIntroVC ()

@property(strong,nonatomic) IBOutlet UIButton *continueWithPhoneNumberBtn;
@property(strong,nonatomic) IBOutlet UIButton *continueWithFacebookBtn;
@property(strong,nonatomic) IBOutlet UIButton *recoverPasswordBtn;

@end

@implementation AWIntroVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpButtons];
    // Do any additional setup after loading the view, typically from a nib.
//    [self showActivityIndicatorwithTitle:Title_Loading animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Custom Methods -

- (void)setUpButtons {
    NSAttributedString *titleString = [[NSAttributedString alloc] initWithString:@"recover password?" attributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid)}];
    [self.recoverPasswordBtn setAttributedTitle:titleString forState:UIControlStateNormal];
}

#pragma mark - Facebook Login Method -
- (void) fbLoginServiceWithUserDict : (NSDictionary *) dict {
    // Fetching Facebook details
    
/*
    NSString *profilePicURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large",[dict objectForKey:@"id"]];
    NSString *jsonStr = [NSString stringWithFormat:@"wsmethod=facebooklogin&user_email=%@&user_fname=%@&user_lname=%@&user_photo=%@&fb_id=%@&device_token=%@",[dict objectForKey:@"email"],[dict objectForKey:@"first_name"],[dict objectForKey:@"last_name"],profilePicURL,[dict objectForKey:@"id"],[self getDeviceToken]];
    [WSManager POST:HostName withParamters:jsonStr success:^(id results, NSURLSessionDataTask *operation) {
        NSArray *resultArray = (NSArray *) results;
        if(resultArray.count>0){
            NSMutableDictionary *dictResponse =[results objectAtIndex:0];
            if ([[dictResponse objectForKey:@"status"]intValue]==200) {
                User *user = [User getUser];
                [user saveUserWhenLoginInWithDictionary:dictResponse];
                user = [User getUser];
                if (user.isFirstTimeLogin){
                    WelcomeVc *welcm =[self.storyboard instantiateViewControllerWithIdentifier:@"WelcomeVc"];
                    [self.navigationController pushViewController:welcm animated:YES];
                }else{
                    MenuViewController  *menuVC =[self.storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
                    [self.navigationController pushViewController:menuVC animated:false];
                    HomeViewController  *home =[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
                    [self.navigationController pushViewController:home animated:YES];
                }
                
            }else if([[dictResponse objectForKey:@"status"]intValue]==400){
                [UIAlertController showAlertIn:self WithTitle:@"" message:[dictResponse objectForKey:@"status_msg"] cancelButtonTitle:@"Ok" otherButtonTitles:nil style:UIAlertControllerStyleAlert tapBlock:^(UIAlertController *alertViewController, NSInteger buttonIndex) {
                    
                }];
            }
            
        }
        [self dismissGlobalHUD];
    } failure:^(NSError *error, NSURLSessionDataTask *operation) {
        [self dismissGlobalHUD];
    }];
*/ 
}

-(void)fbDidSuccess :(NSMutableDictionary *)dictFB {
    [self performSelector:@selector(fbLoginServiceWithUserDict:) withObject:dictFB afterDelay:0.2];
}

- (void)userFacebookDetails:(NSDictionary *)details {
    NSLog(@"details : %@",details);
    
}

#pragma mark - Custom Actions -

- (IBAction)btnWithNumberClick:(id)sender {

    AWSignUpVC *Phonevc = [self.storyboard instantiateViewControllerWithIdentifier:@"AWSignUpVC"];
    [self.navigationController pushViewController:Phonevc animated:YES];
}

- (IBAction)btnWithFacebookClick:(id)sender {
    
//    AWHomeVC *Phonevc = [self.storyboard instantiateViewControllerWithIdentifier:@"AWHomeVC"];
//    [self.navigationController pushViewController:Phonevc animated:YES];
    
    if(![self checkInternetConnection]){
        [self showNotificationForInternet];
        return;
    }
    
    [self fbLogin];
}

@end
