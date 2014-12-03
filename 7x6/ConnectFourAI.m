//
//  ConnectFourAI.m
//  7x6
//
//  Created by Nathaniel Mendoza on 12/3/14.
//  Copyright (c) 2014 CSE494Project2. All rights reserved.
//

#import "ConnectFourAI.h"
#import <math.h>
#import <limits.h>

#define MAX_DEPTH 10
#define WIN_REVENUE 1
#define LOSE_REVENUE -1
#define UNCERTAIN_REVENUE 0
#define ROWCOUNT 6
#define COLCOUNT 7
#define AIPIECE 2
#define PLAYERPIECE 1

@implementation ConnectFourAI


-(instancetype)initWithBoardPointer:(ConnectFourGame *)board
{
    self = [super init];
    if(self)
    {
        self.board = board;
    }
    
    return self;
}

-(int)makeTurn
{
    
    double maxValue = 2. * INT_MIN;
    int move = 0;
    
    for(int column = 0; column < COLCOUNT; column++)
    {
        if([self.board isValidMoveAtColumn:column])
        {
            double value = [self moveValue:column];
            if(value > maxValue)
            {
                maxValue = value;
                move = column;
                
                if(value == WIN_REVENUE)
                {
                    break;
                }
            }
        }
    }
    
    //[self.board makeMoveAtColumn:move withPiece:AIPIECE];
    //NSLog(@"Piece placed at column %d", move);
    return move;
}

-(double)moveValue:(int)column
{
    [self.board makeMoveAtColumn:column withPiece:AIPIECE];
    double val = [self alphabetaWithDepth:MAX_DEPTH withAlpha:INT_MIN withBeta:INT_MAX maximizingPlayer:false];
    
    [self.board undoMoveAtColumn:column];
    return val;
}

-(double)alphabetaWithDepth:(int)depth withAlpha:(double)alpha withBeta:(double)beta maximizingPlayer:(BOOL)maximizingPlayer
{
    BOOL hasWinner = [self.board hasWinner];
    if(depth == 0 || hasWinner)
    {
        double score = 0;
        
        if(hasWinner)
        {
            if( [self.board getWinner] == 1)
            {
                score = LOSE_REVENUE;
            }
            else
            {
                score = WIN_REVENUE;
            }
        }
        else
        {
            score = UNCERTAIN_REVENUE;
        }
        
        return (score / (MAX_DEPTH - depth + 1));
    }
    
    if(maximizingPlayer)
    {
        for(int column = 0; column < COLCOUNT; column++)
        {
            if([self.board isValidMoveAtColumn:column])
            {
                [self.board makeMoveAtColumn:column withPiece:AIPIECE];
                alpha = fmax(alpha, [self alphabetaWithDepth:(depth - 1) withAlpha:alpha withBeta:beta maximizingPlayer:false]);
                
                [self.board undoMoveAtColumn:column];
                if(beta <= alpha)
                {
                    break;
                }
            }
        }
        
        return alpha;
    }
    else
    {
        for(int column = 0; column < COLCOUNT; column++)
        {
            if([self.board isValidMoveAtColumn:column])
            {
                [self.board makeMoveAtColumn:column withPiece:PLAYERPIECE];
                beta = fmin(beta, [self alphabetaWithDepth:(depth - 1) withAlpha:alpha withBeta:beta maximizingPlayer:true]);
                
                [self.board undoMoveAtColumn:(column)];
                if(beta <= alpha)
                {
                    break;
                }
            }
        }
        
        return beta;
    }
}




















@end
