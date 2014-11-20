//
//  ConnectFourGame.m
//  7x6
//
//  Created by Nathaniel Mendoza on 11/19/14.
//  Copyright (c) 2014 CSE494Project2. All rights reserved.
//

#import "ConnectFourGame.h"

@implementation ConnectFourGame

-(instancetype) initGame
{
    self = [super init];
    if(self)
    {
        //self.board = [[Board alloc] initWithZeroes];
        self.currentPlayer = 1;
        
        for(int r = 0; r < ROWCOUNT; r++)
        {
            for(int c = 0; c < COLCOUNT; c++)
            {
                grid[r][c] = 0;
            }
        }
    }
    return self;
}

-(void)placeCurrentPlayerPieceAtColumn:(int)col
{
    int row = ROWCOUNT - 1;
    while(row >= 0)
    {
        if(grid[row][col] == 0)
        {
            grid[row][col] = self.currentPlayer;
            break;
        }
        else
        {
            row--;
        }
    }
}

-(void)nextTurnPreparation
{
    self.currentPlayer = (self.currentPlayer == 1) ? 2 : 1;
}

/* CHECK FOR WIN METHOD
 LEGEND
 0: no winner yet
 1: red piece wins (player 1)
 2: black piece wins (player 2)
 */
-(int)checkForWinAtColumn:(int)col
{
    int result = 0;
    
    //TODO CHECKS HERE
    
    return result;
}

//used to find the highest row that is occupied in connect four board

-(int)findHighestRow:(int)column
{
    int row = ROWCOUNT - 1;
    
    while(row >= 0)
    {
        if(grid[row][column] != 0)
        {
            row--;
        }
        else
        {
            break;
        }
    }
    
    return row + 1;
}

-(int)getCurrentPieceAtRow:(int)row atColumn:(int)col
{
    return grid[row][col];
}

-(bool)checkSouthAtRow:(int) row atColumn:(int)column
{
    bool result = false;
    int player = grid[row][column];
    
    if(player == grid[row+1][column] && player == grid[row+2][column] && player == grid[row+3][column])
    {
        result = true;
    }
    return result;
}

-(bool)checkEastAtRow:(int) row atColumn:(int)column
{
    bool result = false;
    int player = grid[row][column];
    
    if(player == grid[row][column+1] && player == grid[row][column+2] && player == grid[row][column+3])
    {
        result = true;
    }
    
    return result;
}


-(bool)checkWestAtRow:(int) row atColumn:(int)column
{
    bool result = false;
    int player = grid[row][column];
    
    if(player == grid[row][column-1] && player == grid[row][column-2] && player == grid[row][column-3])
    {
        result = true;
    }
    
    return result;
}


-(bool)checkSouthWestAtRow:(int) row atColumn:(int)column
{
    bool result = false;
    int player = grid[row][column];
    
    if(player == grid[row+1][column-1] && player == grid[row+2][column-2] && player == grid[row+3][column-3])
    {
        result = true;
    }
    return result;
}

-(bool)checkSouthEastAtRow:(int) row atColumn:(int)column
{
    bool result = false;
    int player = grid[row][column];
    
    if(player == grid[row+1][column+1] && player == grid[row+2][column+2] && player == grid[row+3][column+3])
    {
        result = true;
    }
    return result;
}


-(bool)checkNorthEastAtRow:(int) row atColumn:(int)column
{
    bool result = false;
    int player = grid[row][column];
    
    if(player == grid[row-1][column+1] && player == grid[row-2][column+2] && player == grid[row-3][column+3])
    {
        result = true;
    }
    
    return result;
}

-(bool)checkNorthWestAtRow:(int) row atColumn:(int)column
{
    bool result = false;
    int player = grid[row][column];
    
    if(player == grid[row-1][column-1] && player == grid[row-2][column-2] && player == grid[row-3][column-3])
    {
        result = true;
    }
    
    return result;
}


-(bool)checkMidEastAtRow:(int) row atColumn:(int)column
{
    bool result = false;
    int player = grid[row][column];
    
    if(player == grid[row][column-1] && player == grid[row][column+1] && player == grid[row][column+2])
    {
        result = true;
    }
    
    return result;
}

-(bool)checkMidWestAtRow:(int) row atColumn:(int)column
{
    bool result = false;
    int player = grid[row][column];
    
    
    if(player == grid[row][column+1] && player == grid[row][column-1] && player == grid[row][column-2])
    {
        result = true;
    }
    
    return result;
}


-(bool)checkMidNorthEastAtRow:(int) row atColumn:(int)column
{
    bool result = false;
    int player = grid[row][column];
    
    
    if(player == grid[row+1][column-1] && player == grid[row-1][column+1] && player == grid[row-2][column+2])
    {
        result = true;
    }
    
    return result;
}


-(bool)checkMidNorthWestAtRow:(int) row atColumn:(int)column
{
    bool result = false;
    int player = grid[row][column];
    
    
    if(player == grid[row+1][column+1] && player == grid[row-1][column-1] && player == grid[row-2][column-2])
    {
        result = true;
    }
    
    return result;
}


-(bool)checkMidSouthEastAtRow:(int) row atColumn:(int)column
{
    bool result = false;
    int player = grid[row][column];
    
    if(player == grid[row-1][column-1] && player == grid[row+1][column+1] && player == grid[row+2][column+2])
    {
        result = true;
    }
    
    return result;
}


-(bool)checkMidSouthWestAtRow:(int) row atColumn:(int)column
{
    bool result = false;
    int player = grid[row][column];
    
    if(player == grid[row-1][column+1] && player == grid[row+1][column-1] && player == grid[row+2][column-2])
    {
        result = true;
    }
    
    return result;
}


@end
