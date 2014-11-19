//
//  Board.m
//  7x6
//
//  Created by Nathaniel Mendoza on 11/19/14.
//  Copyright (c) 2014 CSE494Project2. All rights reserved.
//

#import "Board.h"

@implementation Board

-(void)placePiece:(int)piece atRow:(int)row atCol:(int)col
{
    grid[row][col] = piece;
}

-(int)getPieceAtRow:(int)row atCol:(int)col
{
    return grid[row][col];
}

-(instancetype) initWithZeroes
{
    self = [super init];
    if(self)
    {
        for(int i = 0; i < ROWCOUNT; i++)
        {
            for(int j = 0; j < COLCOUNT; j++)
            {
                grid[i][j] = 0;
            }
        }
    }
    
    return self;
}

@end
