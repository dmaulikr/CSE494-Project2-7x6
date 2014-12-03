//
//  ViewController.m
//  7x6
//
//  Created by Nathaniel Mendoza on 11/14/14.
//  Copyright (c) 2014 CSE494Project2. All rights reserved.
//

#import "ViewController.h"
#import "BoardView.h"
#import "ConnectFourAI.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet BoardView *gameView;
@property (weak, nonatomic) IBOutlet UILabel *thinkingLabel;


@property ConnectFourAI *ai;
@end

@implementation ViewController

bool processingMove;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.game = [[ConnectFourGame alloc] initGame];
    self.ai = [[ConnectFourAI alloc] initWithBoardPointer:self.game];
    processingMove = false;
}

//Code borrowed from http://hayageek.com/uialertcontroller-example-ios/#action-action
//Creates a pause menu with options to Quit and Resume
- (IBAction)menuPressed:(id)sender {
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:@"Menu"
                                 message:@"What would you like to do?"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Quit Game (will count as loss)"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [view dismissViewControllerAnimated:YES completion:nil];
                             [self.navigationController popViewControllerAnimated:YES];
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"Resume"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 
                             }];
    
    
    [view addAction:ok];
    [view addAction:cancel];
    [self presentViewController:view animated:YES completion:nil];
}

//Game stuff happens here
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //int currentPlayer = [self.game currentPlayer];
    
    if(!processingMove){
        
        processingMove = true;
        
        //Get where the user touched the screen
        NSArray *touchesArray = [touches allObjects];
        UITouch *touch = (UITouch *)[touchesArray objectAtIndex:(touchesArray.count - 1)];
        CGPoint point = [touch locationInView:nil];
    
        //Find out which column was touched
        float xTouched = point.x;
        float columnWidth = self.view.frame.size.width/COLUMNS;
    
        int columnTouched = (int) floorf(xTouched/columnWidth);
        if(columnTouched == 7){
            columnTouched = 6;
        }
        
        //Game logic for user player
        if([self.game isValidMoveAtColumn:columnTouched]){
            
            //Setup stuff
            UIColor *currentColor;
            if(self.game.currentPlayer == 1)
            {
                currentColor = [UIColor redColor];
                self.thinkingLabel.hidden = NO;
                //[self.view setNeedsDisplay];
            }
            else
            {
                currentColor = [UIColor blackColor];
                self.thinkingLabel.hidden = YES;
                // [self.view setNeedsDisplay];
            }
            
            [self.game placeCurrentPlayerPieceAtColumn:columnTouched];
            //update UI
            [self.gameView updatePieceColorAt:[self.game findHighestRow:columnTouched] And:columnTouched With:currentColor];
            [self.gameView setNeedsDisplay];
            [self checkForWinAt:columnTouched];
        
            
            [NSTimer scheduledTimerWithTimeInterval:1
                                            target:self
                                           selector:@selector(aiTurn)
                                            userInfo:nil
                                            repeats:NO];
        
            //AI MAKES ITS MOVE
         
            //Game logic for AI player
        
        }
        else
        {
            [self invalidMoveAlert];
        }
        
    }
    
    processingMove = false;

}

-(void)aiTurn
{
    UIColor *currentColor;
    int columnTouched;
    if(self.game.currentPlayer == 1)
    {
        currentColor = [UIColor redColor];
        self.thinkingLabel.hidden = NO;
        //[self.view setNeedsDisplay];
    }
    else
    {
        currentColor = [UIColor blackColor];
        self.thinkingLabel.hidden = YES;
        // [self.view setNeedsDisplay];
    }
    
    columnTouched = [self.ai makeTurn];
    [self.game placeCurrentPlayerPieceAtColumn:columnTouched];
    //update UI
    [self.gameView updatePieceColorAt:[self.game findHighestRow:columnTouched] And:columnTouched With:currentColor];
    [self.gameView setNeedsDisplay];
    [self checkForWinAt:columnTouched];
}

-(void)invalidMoveAlert
{
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Invalid Move!"
                                  message:@"You cannot place a piece here. Please try again."
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)checkForWinAt:(int)column
{
    int winner = [self.game checkForWinAtColumn:column];
    if(winner == 1)
    {
        [self endGameActionsWith:@"You Win!"];
    }
    else if(winner == 2)
    {
        [self endGameActionsWith:@"You Lose!"];
    }
    else if(winner == 3)
    {
        [self endGameActionsWith:@"It's a tie!"];
    }
    else
    {
        [self.game nextTurnPreparation];
    }
}

-(void)endGameActionsWith:(NSString *)result
{
    UIAlertController * view=   [UIAlertController
                                 alertControllerWithTitle:result
                                 message:@"Would you like to submit your score?"
                                 preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"Yes"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [view dismissViewControllerAnimated:YES completion:nil];
                             UIAlertController * alert=   [UIAlertController
                                                           alertControllerWithTitle:@"Success!"
                                                           message:@"Your score has been submitted."
                                                           preferredStyle:UIAlertControllerStyleAlert];
                             
                             UIAlertAction* ok = [UIAlertAction
                                                  actionWithTitle:@"OK"
                                                  style:UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction * action)
                                                  {
                                                      [alert dismissViewControllerAnimated:YES completion:nil];
                                                      [self.navigationController popViewControllerAnimated:YES];
                                                      
                                                  }];

                             
                             [alert addAction:ok];
                             
                             [self presentViewController:alert animated:YES completion:nil];
                             
                         }];
    UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:@"No"
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [view dismissViewControllerAnimated:YES completion:nil];
                                 [self.navigationController popViewControllerAnimated:YES];
                                 
                             }];
    
    
    [view addAction:ok];
    [view addAction:cancel];
    
    [self presentViewController:view animated:YES completion:nil];
}

@end
