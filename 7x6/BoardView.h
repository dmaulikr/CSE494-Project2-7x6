//
//  BoardView.h
//  7x6
//
//  Created by Buv Sethia on 11/26/14.
//  Copyright (c) 2014 CSE494Project2. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ROWS 6
#define COLUMNS 7

@interface BoardView : UIView

{
    UIColor *pieceColors[ROWS][COLUMNS];
}

-(void)updatePieceColorAt:(int)row And:(int)column With:(UIColor *)color;

@end
