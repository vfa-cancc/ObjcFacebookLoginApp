//
//  LogoutViewController.m
//  ObjcFacebookLoginApp
//
//  Created by Natsumo Ikeda on 2016/06/07.
//  Copyright 2017 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
//

#import "LogoutViewController.h"
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
    // ログアウト
    [NCMBUser logOut];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
