//
//  ViewController.m
//  TicTacToe
//
//  Created by Joy Kendall on 2/9/17.
//  Copyright © 2017 Joy. All rights reserved.
//

#import "ViewController.h"
#import "Game.h"

@interface ViewController ()
// outlets whose fields get set
@property (weak, nonatomic) IBOutlet UILabel *gameStatusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *currentPlayerImageView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *gridButtons;
@property (weak, nonatomic) IBOutlet UILabel *currentPlayerLabel;
// Strings to hold names of player images
@property (nonatomic, strong) NSString *OImageName;
@property (nonatomic, strong) NSString *XImageName;
// The model
@property (nonatomic, strong) Game *ticTacToe;
@end

@implementation ViewController

#pragma mark - Setup
-(Game *)ticTacToe {
    if (!_ticTacToe) {
        _ticTacToe = [[Game alloc] init];
    }
    return _ticTacToe;
}


-(void) viewDidLoad {
    [super viewDidLoad];
    for (UIButton *button in self.gridButtons) {
        [button setImage:[UIImage imageNamed:@"blank"] forState:UIControlStateNormal|UIControlStateDisabled];
        button.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
        button.enabled = YES;
    }
    self.XImageName = @"x";
    self.OImageName = @"o";
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateCurrentPlayerImage];
}

#pragma mark - Game play
- (IBAction)squareClicked:(UIButton *)sender {
    // The squares are all buttons whose tags are preset to identify them.  When a "square"
    // is clicked, the button is done, so set its image and disable it.
    if (self.ticTacToe.whoseTurn == PlayerX) {
        [sender setImage:[UIImage imageNamed:self.XImageName] forState:UIControlStateDisabled];
 
    } else {
        [sender setImage:[UIImage imageNamed:self.OImageName] forState:UIControlStateDisabled];
    }
    // disable this button
    sender.enabled = NO;
    
    // update the model using this button's tag (a number from 0 to 15)
    [self.ticTacToe makeMove:[sender tag]];
    
    // If we have a winner, it's whoever just moved
    if ([self.ticTacToe checkWinner]) {
        self.gameStatusLabel.text = @"Woo hoo!";
        self.currentPlayerLabel.text = @"We have a winner!";
        // disable remaining buttons - the game is over, after all!
        for (UIButton *button in self.gridButtons) {
            button.enabled = NO;
        }
    }
    else if ([self.ticTacToe noMoreMoves]) {
        self.gameStatusLabel.text = @"No more moves!";
    }
    // Game continues
    else {
        [self updateCurrentPlayerImage];
    }
}


#pragma mark - New game
// The "New Game" button
- (IBAction)newGame:(UIButton *)sender {
    [self newGameWithX:@"x" andO:@"o"];
}

// The "New Other Game" button. Hope it's fun. :-)
- (IBAction)newOtherGame:(id)sender {
    [self newGameWithX:@"player1" andO:@"player2"];
}

// (Re)initialiation - get the model to clear the board,
// enable all the buttons and set them to blank.  Get the
// text label outlets to say something reasonable.  Set the
// X and O images according to passed-in image asset names.
-(void)newGameWithX:(NSString *)x andO:(NSString *)o {
    [self.ticTacToe initBoard];
    for (UIButton *button in self.gridButtons) {
        [button setImage:[UIImage imageNamed:@"blank"] forState:UIControlStateNormal|UIControlStateDisabled];
        button.enabled = YES;
    }
    self.gameStatusLabel.text = @"";
    self.currentPlayerLabel.text = @"Current player:";
    self.XImageName = x;
    self.OImageName = o;
    [self updateCurrentPlayerImage];
}

// This is the image at the top that shows whose turn it is
-(void) updateCurrentPlayerImage {
    if (self.ticTacToe.whoseTurn == PlayerX) {
        self.currentPlayerImageView.image = [UIImage imageNamed:self.XImageName];
    }
    else {
        self.currentPlayerImageView.image = [UIImage imageNamed:self.OImageName];
    }
}

@end
