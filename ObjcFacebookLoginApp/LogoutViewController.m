//
//  LogoutViewController.m
//  ObjcFacebookLoginApp
//
//  Created by Natsumo Ikeda on 2016/06/07.
//  Copyright 2020 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
//

#import "LogoutViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "NCMB/NCMB.h"

@interface LogoutViewController ()

@end

@implementation LogoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

// Logoutボタン押下時の処理
- (IBAction)logoutBtn:(UIButton *)sender {
    NSLog(@"ログアウトしました");
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    // 非同期でログアウト
    [NCMBUser logOutInBackgroundWithBlock:^(NSError *error) {
        if (error){
            //エラー処理
            NSLog(@"Logout error %@", error);
        } else {
            // Facebookの認証情報を削除
            [loginManager logOut];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
