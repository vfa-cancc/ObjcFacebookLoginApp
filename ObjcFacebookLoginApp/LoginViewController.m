//
//  LoginViewController.m
//  ObjcFacebookLoginApp
//
//  Created by Natsumo Ikeda on 2016/06/07.
//  Copyright 2017 FUJITSU CLOUD TECHNOLOGIES LIMITED All Rights Reserved.
//

#import "LoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([FBSDKAccessToken currentAccessToken]) {
        [self performSegueWithIdentifier:@"login" sender:self];
    }
}

// Loginボタン押下時の処理
- (IBAction)FacebookLoginBtn:(UIButton *)sender {
    // labelを空にする
    self.label.text = @"";
    if ([FBSDKAccessToken currentAccessToken]) {
        [self performSegueWithIdentifier:@"login" sender:self];
    } else {
        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
        [loginManager logInWithPermissions:@[@"public_profile", @"email"] fromViewController:self handler:^(FBSDKLoginManagerLoginResult * _Nullable result, NSError * _Nullable error) {
           //TODO: process error or result
           if(error){
               // その他のエラーが発生した場合
               NSLog(@"エラーが発生しました:%ld", error.code);
               self.label.text = [NSString stringWithFormat:@"エラーが発生しました:%ld", error.code];
           } else {
               if(result.token.userID != nil){
                   // mobile backend会員登録するための認証情報を作成
                   NSDictionary *facebookInfo = @{@"id":result.token.userID,
                                                  @"access_token":result.token.tokenString,
                                                  @"expiration_date":result.token.expirationDate};

                   //会員のインスタンスを作成
                   NCMBUser *user = [NCMBUser user];

                   //Facebookの認証情報を利用して会員登録を行う
                   [user signUpWithFacebookToken:facebookInfo withBlock:^(NSError *error) {
                       if (error){
                           //会員登録に失敗した場合の処理
                           NSLog(@"Facebookの会員登録とログインに成功しました：%@", user.objectId);
                       } else {
                           //会員登録に成功した場合の処理
                           NSLog(@"Facebookの会員登録とログインに成功しました：%@", user.objectId);
                           [self performSegueWithIdentifier:@"login" sender:self];
                       }
                   }];
               } else {
                   if (result.isCancelled) {
                       // Facebookのログインがキャンセルされた場合
                       NSLog(@"Facebookのログインがキャンセルされました");
                       self.label.text = @"Facebookのログインがキャンセルされました";
                   } else {
                       // その他のエラーが発生した場合
                       NSLog(@"エラーが発生しました:%ld", error.code);
                       self.label.text = [NSString stringWithFormat:@"エラーが発生しました:%ld", error.code];
                   }

               }

           }

       }];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
