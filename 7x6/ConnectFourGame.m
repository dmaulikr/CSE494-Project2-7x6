//
//  ConnectFourGame.m
//  7x6
//
//  Created by Nathaniel Mendoza on 11/19/14.
//  Copyright (c) 2014 CSE494Project2. All rights reserved.
//

#import "ConnectFourGame.h"

@implementation ConnectFourGame


/*CONNECT FOUR GAME PROCEDURE

 
initialize object
game loop
 {
    place piece at column
    check for win
    next turn preparation
 }
 
*/
-(instancetype) initGame
{
    self = [super init];
    if(self)
    {
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


//functions for minimax AI
-(BOOL)makeMoveAtColumn:(int)col withPiece:(int)piece
{
    int row = ROWCOUNT - 1;
    while(row >= 0)
    {
        if(grid[row][col] == 0)
        {
            grid[row][col] = piece;
            //NSLog(@"Piece placed at column %d", col);
            return true;
        }
        else
        {
            row--;
        }
    }
    
    return false;
}

-(BOOL)isValidMoveAtColumn:(int)col
{
    if( grid[0][col] != 0)
    {
        return false;
    }
    else
    {
        return true;
    }
}

-(BOOL)undoMoveAtColumn:(int)col
{
    int row = [self findHighestRow:col];
    grid[row][col] = 0;
    //NSLog(@"Piece removed at column %d", col);
    return true;
}

-(BOOL)hasWinner
{
    for(int i = 0; i < COLCOUNT; i++)
    {
        if( [self checkForWinAtColumn:i] != 0)
        {
            return true;
        }
    }
    
    return false;
}

-(int)getWinner
{
    for(int i = 0; i < COLCOUNT; i++)
    {
        if( [self checkForWinAtColumn:i] != 0)
        {
            return [self checkForWinAtColumn:i];
        }
    }
    
    return 0;
}


//END functions for minimax AI


//preparation for next turn
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
-(int)checkForWinAtColumn:(int)column
{
    int result = 0;
    
    int row = [self findHighestRow:column];
    int player = grid[row][column];
    
    
    if(row >= 0 && row <= 2)
    {
        if([self checkSouthAtRow:row atColumn:column])
            result = player;
        
        if(column >= 0 && column <= 3)
        {
            if([self checkSouthEastAtRow:row atColumn:column])
                result = player;
            if([self checkEastAtRow:row atColumn:column])
                result = player;
        }
        if(column >= 3 && column <= 6)
        {
            if([self checkSouthWestAtRow:row atColumn:column])
                result = player;
            if([self checkWestAtRow:row atColumn:column])
                result = player;
        }
        if(column >= 1 && column <= 4)
        {
            if([self checkMidEastAtRow:row atColumn:column])
                result = player;
        }
        if(column >= 2 && column <= 5)
        {
            if([self checkMidWestAtRow:row atColumn:column])
                result = player;
        }
    }
    
    if(row >= 3 && row <= 5)
    {
        if(column >= 0 && column <= 3)
        {
            if([self checkNorthEastAtRow:row atColumn:column])
                result = player;
            if([self checkEastAtRow:row atColumn:column])
                result = player;
        }
        if(column >= 3 && column <= 6)
        {
            if([self checkNorthWestAtRow:row atColumn:column])
                result = player;
            if([self checkWestAtRow:row atColumn:column])
                result = player;
        }
        if(column >= 1 && column <= 4)
        {
            if([self checkMidEastAtRow:row atColumn:column])
                result = player;
        }
        if(column >= 2 && column <= 5)
        {
            if([self checkMidWestAtRow:row atColumn:column])
                result = player;
        }
    }
    
    if(row >= 1 && row <= 3)
    {
        if(column >= 1 && column <= 4)
        {
            if([self checkMidSouthEastAtRow:row atColumn:column])
                result = player;
        }
        if(column >= 2 && column <= 5)
        {
            if([self checkMidSouthWestAtRow:row atColumn:column])
                result = player;
        }
    }
    
    if(row >= 2 && row <= 4)
    {
        if(column >= 1 && column <= 4)
        {
            if([self checkMidNorthEastAtRow:row atColumn:column])
                result = player;
        }
        if(column >= 2 && column <= 5)
        {
            if([self checkMidNorthWestAtRow:row atColumn:column])
                result = player;
        }
    }
    
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
