//
//  Game.m
//  TicTacToe
//
//  Created by Joy Kendall on 2/9/17.
//  Copyright © 2017 Joy. All rights reserved.
//

#import "Game.h"


@implementation Game

const NSInteger BOARD_DIMENSION = 4;

typedef NS_ENUM(NSUInteger, BoardSquare) {
    SquareEmpty,
    SquareX,
    SquareO
};

BoardSquare board[BOARD_DIMENSION][BOARD_DIMENSION];

#pragma mark - Initialization
-(void)initBoard {
    for (int i = 0; i < BOARD_DIMENSION; i++) {
        for (int j = 0; j < BOARD_DIMENSION; j++) {
            board[i][j] = SquareEmpty;
        }
    }
    self.gameOver = NO;
}

#pragma mark - Handling moves
// translate a number from 0 to number of square - 1 into row and col
-(void)makeMove:(NSInteger)square {
    if (square < 0 || square > (BOARD_DIMENSION*BOARD_DIMENSION) - 1) {
        // out of bounds
        return;
    }
    NSInteger row = square / BOARD_DIMENSION;
    NSInteger col = square % BOARD_DIMENSION;
    board[row][col] = (self.whoseTurn == PlayerX) ? SquareX : SquareO;

}

#pragma mark - Board conditions
-(BOOL) noMoreMoves {
    for (int i = 0; i < BOARD_DIMENSION; i++) {
        for (int j = 0; j < BOARD_DIMENSION; j++) {
            if (board[i][j] == SquareEmpty)
                return NO;
        }
    }
    return YES;
}

// Whoever just moved would be the winner, if there was one, so check
// for that player's marker.
-(BOOL) checkWinner {
    BoardSquare squareType = (self.whoseTurn == PlayerX) ? SquareX : SquareO;
    
    BOOL winner = ([self checkLeftDiagonal:squareType] ||
                   [self checkRightDiagonal:squareType] ||
                   [self checkFourCorners:squareType] ||
                   [self checkHorizAndVert:squareType] ||
                   [self checkFourSquare:squareType]);
    
    if (winner) {
        self.gameOver = YES;
    } else {
        // prepare for the next turn
        self.whoseTurn = (self.whoseTurn == PlayerX) ? PlayerO : PlayerX;
    }
    return winner;
}

#pragma mark - Methods for checking a winning board

// The ways to win: diagonals, row, column, corners, and a 2x2 square.
-(BOOL) checkLeftDiagonal:(BoardSquare) squareType {
    for (int i = 0; i < BOARD_DIMENSION; i++) {
        if (board[i][i] != squareType) return NO;
    }
    return YES;
}

-(BOOL) checkRightDiagonal:(BoardSquare) squareType  {
    for (int i = 0; i < BOARD_DIMENSION; i++) {
        if (board[i][BOARD_DIMENSION-i-1] != squareType) return NO;
    }
    return YES;
}


-(BOOL) checkFourCorners:(BoardSquare) squareType  {
    return (board[0][0] == squareType
            && board[0][BOARD_DIMENSION-1] == squareType
            && board[BOARD_DIMENSION-1][0] == squareType
            && board[BOARD_DIMENSION-1][BOARD_DIMENSION-1] == squareType);

}

-(BOOL) checkHorizAndVert:(BoardSquare) squareType {
    for (int i = 0; i < BOARD_DIMENSION; i++) {
        if ([self checkThisRow:squareType atRow:i])
            return YES;
        if ([self checkThisColumn:squareType atCol:i])
            return YES;
    }
    return NO;
}

-(BOOL) checkThisRow:(BoardSquare) squareType atRow:(NSInteger)row {
    for (int col = 0; col < BOARD_DIMENSION; col++) {
        if (board[row][col] != squareType) return NO;
    }
    return YES;
}

-(BOOL) checkThisColumn:(BoardSquare) squareType atCol:(NSInteger)col {
    for (int row = 0; row < BOARD_DIMENSION; row++) {
        if (board[row][col] != squareType) return NO;
    }
    return YES;
}

// Check for a 2x2 square of all the same type.
-(BOOL) checkFourSquare:(BoardSquare) squareType {
    for (int r = 0; r < BOARD_DIMENSION-1; r++) {
        for (int c = 0; c < BOARD_DIMENSION-1; c++) {
            if (board[r][c] == squareType && board[r][c+1] == squareType
                && board[r+1][c] == squareType && board[r+1][c+1] == squareType)
                return YES;
        }
        
    }
    return NO;
    
}


@end
