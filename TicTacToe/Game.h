//
//  Game.h
//  TicTacToe
//
//  Created by Joy Kendall on 2/9/17.
//  Copyright © 2017 Joy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, Player) {
    PlayerX,
    PlayerO
};

@interface Game : NSObject

@property (nonatomic) BOOL gameOver;
@property (nonatomic) Player whoseTurn;

-(void)initBoard;
-(void)makeMove:(NSInteger)square;
-(BOOL) noMoreMoves;
-(BOOL) checkWinner ;
@end
