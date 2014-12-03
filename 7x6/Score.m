//
//  Score.m
//  7x6
//
//  Created by Buv Sethia on 12/3/14.
//  Copyright (c) 2014 CSE494Project2. All rights reserved.
//

#import "Score.h"

@implementation Score

-(id)init
{
    self = [super init];
    if(self)
    {
        self.score = 10000;
        self.turnPenalty = 4;
    }
    
    return self;
}

-(void)applyTurnPenalty
{
    self.score -= self.turnPenalty;
    if(self.score < 0)
    {
        self.score = 0;
    }
    NSLog(@"Score: %d", self.score);
}

-(void)stampTurnStart
{
    self.startOfTurn = [NSDate date];
}

-(void)applyTimePenalty
{
    self.score += round([self.startOfTurn timeIntervalSinceNow]);
    if(self.score < 0)
    {
        self.score = 0;
    }
    
}

-(NSString*)getScore
{
    return [NSString stringWithFormat:@"%d", self.score];
}

-(void)addWinBonus
{
    self.score += 5000;
}

-(void)addLossPenalty
{
    self.score /= 10000/(10000-self.score);
    if(self.score < 0)
    {
        self.score = 0;
    }
}

@end
