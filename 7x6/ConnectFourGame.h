//
//  ConnectFourGame.h
//  7x6
//
//  Created by Nathaniel Mendoza on 11/19/14.
//  Copyright (c) 2014 CSE494Project2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Board.h"
#define ROWCOUNT 6
#define COLCOUNT 7

@interface ConnectFourGame : NSObject

/*
 LEGEND
 0: empty space
 1: player 1 piece(red)
 2: player 2 piece(black)
 */
{
    int grid[ROWCOUNT][COLCOUNT];
}

@property int currentPlayer;

-(instancetype)initGame;

-(void)placeCurrentPlayerPieceAtColumn:(int)col;

-(void) nextTurnPreparation;

-(int)findHighestRow:(int)column;

-(BOOL)makeMoveAtColumn:(int)col withPiece:(int)piece;
-(BOOL)undoMoveAtColumn:(int)col;
-(BOOL)isValidMoveAtColumn:(int)col;
-(BOOL)hasWinner;
-(int)getWinner;


/*
 LEGEND
 0: no winner yet
 1: red piece wins (player 1)
 2: black piece wins (player 2)
 */
-(int)checkForWinAtColumn:(int)col;

-(int)getCurrentPieceAtRow:(int)row atColumn:(int)col;

@end

