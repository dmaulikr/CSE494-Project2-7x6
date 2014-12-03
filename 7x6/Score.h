//
//  Score.h
//  7x6
//
//  Created by Buv Sethia on 12/3/14.
//  Copyright (c) 2014 CSE494Project2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Score : NSObject

@property NSDate *startOfTurn;
@property int score;
@property int turnPenalty;

-(void)applyTurnPenalty;
-(void)stampTurnStart;
-(void)applyTimePenalty;
-(void)addLossPenalty;
-(void)addWinBonus;
-(NSString*)getScore;


@end
