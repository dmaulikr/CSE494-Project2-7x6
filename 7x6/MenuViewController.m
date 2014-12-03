//
//  MenuViewController.m
//  7x6
//
//  Created by Nathaniel Mendoza on 12/3/14.
//  Copyright (c) 2014 CSE494Project2. All rights reserved.
//

#import "MenuViewController.h"


@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![PFUser currentUser]) { // No user logged in
        [self showLogInView];
    }
}

- (void)showLogInView {
    
    PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
    
    [logInViewController setDelegate:self];
    
    [logInViewController setFields: PFLogInFieldsUsernameAndPassword | PFLogInFieldsLogInButton | PFLogInFieldsSignUpButton | PFLogInFieldsPasswordForgotten];
    
    PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
    [signUpViewController setDelegate:self];
    

    [logInViewController setSignUpController:signUpViewController];
    
    [self presentViewController:logInViewController animated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
