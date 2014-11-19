//
//  Board.h
//  7x6
//
//  Created by Nathaniel Mendoza on 11/19/14.
//  Copyright (c) 2014 CSE494Project2. All rights reserved.
//

#import <Foundation/Foundation.h>
#define ROWCOUNT 6
#define COLCOUNT 7

@interface Board : NSObject
{
    /*
     LEGEND
     0: empty space
     1: player 1 piece(red)
     2: player 2 piece(black)
     */
    
    int grid[ROWCOUNT][COLCOUNT];
}

-(void) placePiece:(int) piece atRow:(int)row atCol:(int)col;
-(int) getPieceAtRow:(int)row atCol:(int)col;
-(instancetype)initWithZeroes;
@end
