//
//  Board.h
//  7x6
//
//  Created by Nathaniel Mendoza on 11/19/14.
//  Copyright (c) 2014 CSE494Project2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Board : NSObject
{
    int grid[6][7];
}

-(void) placePiece:(int) piece atRow:(int)row atCol:(int)col;
-(int) getPieceAtRow:(int)row atCol:(int)col;
@end
