//
//  ConnectFourGame.h
//  7x6
//
//  Created by Nathaniel Mendoza on 11/19/14.
//  Copyright (c) 2014 CSE494Project2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Board.h"

@interface ConnectFourGame : NSObject

/*
 LEGEND
 0: empty space
 1: player 1 piece(red)
 2: player 2 piece(black)
 */
@property Board *board;

@end

