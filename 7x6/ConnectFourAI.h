//
//  ConnectFourAI.h
//  7x6
//
//  Created by Nathaniel Mendoza on 12/3/14.
//  Copyright (c) 2014 CSE494Project2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConnectFourGame.h"

@interface ConnectFourAI : NSObject

@property ConnectFourGame *board;

-(instancetype)initWithBoardPointer:(ConnectFourGame*)board;
-(int)makeTurn;

@end
