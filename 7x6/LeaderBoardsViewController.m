//
//  LeaderBoardsViewController.m
//  7x6
//
//  Created by Nathaniel Mendoza on 12/3/14.
//  Copyright (c) 2014 CSE494Project2. All rights reserved.
//

#import "LeaderBoardsViewController.h"
#import <Parse/Parse.h>

@interface LeaderBoardsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *highScores;
@property (weak, nonatomic) IBOutlet UITextView *winloss;
- (IBAction)BackButton:(id)sender;

@end

@implementation LeaderBoardsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.highScores.text = @"";
    self.winloss.text = @"";
    [self LoadHighScores];
    [self LoadWinLoss];
    
}

-(void) LoadHighScores
{
    __block NSString *result = @"";
    

    PFQuery *query = [PFQuery queryWithClassName:@"HighScores"];
    [query orderByDescending:@"score"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if(!error)
        {
            int i = 0;
            for(PFObject *object in objects)
            {
                NSString *username = object[@"username"];
                NSString *score = object[@"score"];
                
                
                if(i <= 9)
                {
                    result = [NSString stringWithFormat:@"%@\n%d. Name: %@   Score: %@", result, (i+1), username, score];
                }
                
                i++;
                if(i > 9)
                {
                    break;
                }
                
            }
            NSLog(@"%@", result);
            self.highScores.text = result;
        }
        else{
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
    
}

-(void) LoadWinLoss
{
    __block NSString *result = @"";
    
    
    PFQuery *query = [PFUser query];
    [query orderByDescending:@"ratio"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        if(!error)
        {
            int i = 0;
            for(PFUser *object in objects)
            {
                NSString *username = object[@"username"];
                NSString *ratio = object[@"ratio"];
                int r = (int)[ratio integerValue];
                
                
                if(i <= 9)
                {
                    result = [NSString stringWithFormat:@"%@\n%d. Name: %@  Ratio: %d", result, (i+1), username, r];
                }
            
                i++;
                if(i > 9)
                {
                    break;
                }
                
            }
            NSLog(@"Count: %d", i);
            NSLog(@"%@", result);
            self.winloss.text = result;
        }
        else{
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
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

- (IBAction)BackButton:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
