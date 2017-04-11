//
//  LoginViewController.m
//  ObjcFacebookLoginApp
//
//  Created by Natsumo Ikeda on 2016/06/07.
//  Copyright 2017 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
//

#import "LoginViewController.h"
#import "NCMB/NCMB.h"

@interface LoginViewController ()
// label
@property (weak, nonatomic) IBOutlet UILabel *label;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

// Loginボタン押下時の処理
- (IBAction)FacebookLoginBtn:(UIButton *)sender {
    // labelを空にする
    self.label.text = @"";
    
    [NCMBFacebookUtils logInWithReadPermission:@[@"email"] block:^(NCMBUser *user, NSError *error) {
        if (error) {
            if (error.code == NCMBErrorFacebookLoginCancelled) {
                // Facebookのログインがキャンセルされた場合
                NSLog(@"Facebookのログインがキャンセルされました");
                self.label.text = @"Facebookのログインがキャンセルされました";
                
            } else {
                // その他のエラーが発生した場合
                NSLog(@"エラーが発生しました:%ld", error.code);
                self.label.text = [NSString stringWithFormat:@"エラーが発生しました:%ld", error.code];
                
            }
        } else {
            // 会員登録後の処理
            NSLog(@"Facebookの会員登録とログインに成功しました：%@", user.objectId);
            [self performSegueWithIdentifier:@"login" sender:self];
            
        }
    }];
     
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
