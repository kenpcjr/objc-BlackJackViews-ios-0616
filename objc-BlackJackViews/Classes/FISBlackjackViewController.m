//
//  FISBlackjackViewController.m
//  objc-BlackJackViews
//
//  Created by Kenneth Cooke on 6/20/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "FISBlackjackViewController.h"

@interface FISBlackjackViewController ()
@property (weak, nonatomic) IBOutlet UILabel *houseCardOne;
@property (weak, nonatomic) IBOutlet UILabel *houseCardTwo;
@property (weak, nonatomic) IBOutlet UILabel *houseCardThree;
@property (weak, nonatomic) IBOutlet UILabel *houseCardFour;
@property (weak, nonatomic) IBOutlet UILabel *houseCardFive;
@property (weak, nonatomic) IBOutlet UILabel *playerCardOne;
@property (weak, nonatomic) IBOutlet UILabel *playerCardTwo;
@property (weak, nonatomic) IBOutlet UILabel *playerCardThree;
@property (weak, nonatomic) IBOutlet UILabel *playerCardFour;
@property (weak, nonatomic) IBOutlet UILabel *playerCardFive;
@property (weak, nonatomic) IBOutlet UILabel *winnerLabel;
@property (weak, nonatomic) IBOutlet UILabel *houseStayed;
@property (weak, nonatomic) IBOutlet UILabel *houseScore;
@property (weak, nonatomic) IBOutlet UILabel *houseWinsLabel;
@property (weak, nonatomic) IBOutlet UILabel *houseLosesLabel;
@property (weak, nonatomic) IBOutlet UILabel *houseBustedLabel;
@property (weak, nonatomic) IBOutlet UILabel *houseBlackjackLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerStayedLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerWinsLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerLossesLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerBustedLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerBlackjackLabel;
@property (weak, nonatomic) IBOutlet UIButton *hitTapped;
@property (weak, nonatomic) IBOutlet UIButton *stayTapped;

@property (weak, nonatomic) NSMutableArray *playerCardsForDisplay;
@property (weak, nonatomic) NSMutableArray *houseCardsForDisplay;

@property (nonatomic) BOOL isAWinner;


@end

@implementation FISBlackjackViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    FISBlackjackGame *newGame = [[FISBlackjackGame alloc]init];
    self.game = newGame;
    
    self.winnerLabel.hidden = YES;
    self.houseCardOne.hidden = YES;
    self.houseCardTwo.hidden = YES;
    self.houseCardThree.hidden = YES;
    self.houseCardFour.hidden = YES;
    self.houseCardFive.hidden = YES;
    self.playerCardOne.hidden = YES;
    self.playerCardTwo.hidden = YES;
    self.playerCardThree.hidden = YES;
    self.playerCardFour.hidden = YES;
    self.playerCardFive.hidden = YES;
    self.houseStayed.hidden = YES;
    self.playerStayedLabel.hidden = YES;
    self.houseBustedLabel.hidden = YES;
    self.playerBustedLabel.hidden = YES;
    self.houseBlackjackLabel.hidden = YES;
    self.playerBlackjackLabel.hidden = YES;
    self.houseScore.hidden = YES;
    self.playerScoreLabel.hidden = YES;
    self.playerWinsLabel.hidden = YES;
    self.houseWinsLabel.hidden = YES;
    self.playerLossesLabel.hidden = YES;
    self.houseLosesLabel.hidden = YES;
    self.isAWinner = NO;
    self.hitTapped.enabled = NO;
    
    
    
    
    
    NSLog(@"%@",self.game.player.cardsInHand);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (IBAction)dealTapped:(id)sender {
    
    [self.game.deck resetDeck];
    [self.game.house resetForNewGame];
    [self.game.player resetForNewGame];
    [self resetGame];
    [self.game dealNewRound];
    
    [self displayCards];
    [self labelUpdatedAfterTurn];
    [self checkForWin];
    
    if (!self.game.player.blackjack && !self.game.house.blackjack) {
        self.hitTapped.enabled = YES;
        self.stayTapped.enabled = YES;
        
    }

    if (self.isAWinner == YES) {
        self.hitTapped.enabled = NO;
        self.stayTapped.enabled = NO;
    }

}

- (IBAction)hitTapped:(id)sender {
    
    [self.game dealCardToPlayer];
    [self displayCards];
    [self checkForWin];
    [self labelUpdatedAfterTurn];
    
    if (self.isAWinner == NO) {
    [self.game processHouseTurn];
    [self displayCards];
    [self checkForWin];
    [self labelUpdatedAfterTurn];
    }
    
    if (self.isAWinner == NO) {
    [self.game processHouseTurn];
    [self displayCards];
    [self checkForWin];
    [self labelUpdatedAfterTurn];
    }
    if (self.isAWinner == YES) {
        self.hitTapped.enabled = NO;
        self.stayTapped.enabled = NO;
    }


    
}

- (IBAction)stayTapped:(id)sender {
    //if (self.isAWinner == NO) {
        self.hitTapped.enabled = NO;
   // }
    self.game.player.stayed = YES;
    [self checkForWin];
    [self labelUpdatedAfterTurn];
    
    
    [self.game processHouseTurn];
    [self displayCards];
    [self checkForWin];
    [self labelUpdatedAfterTurn];
    
    [self.game processHouseTurn];
    [self displayCards];
    [self checkForWin];
    [self labelUpdatedAfterTurn];
    
    [self.game processHouseTurn];
    [self displayCards];
    [self checkForWin];
    [self labelUpdatedAfterTurn];
    
    if (self.isAWinner == YES) {
        self.hitTapped.enabled = NO;
        self.stayTapped.enabled = NO;
    }
    
}

-(void)displayCards{
    
    //Why does this have to live here if it's being saved to a property
    NSMutableArray *playerCardsForProperty = [[NSMutableArray alloc]init];
    NSMutableArray *houseCardsForProperty = [[NSMutableArray alloc]init];
    self.playerCardsForDisplay = playerCardsForProperty;
    self.houseCardsForDisplay = houseCardsForProperty;
    
    //Show Player Hand
    NSLog(@"%@",self.game.player.cardsInHand);
    for (FISCard *card in self.game.player.cardsInHand) {
        [self.playerCardsForDisplay addObject:card.cardLabel];
    }
    NSLog(@"%@",self.playerCardsForDisplay);
    self.playerCardOne.text = self.playerCardsForDisplay[0];
    self.playerCardOne.hidden = NO;
    self.playerCardTwo.text = self.playerCardsForDisplay[1];
    self.playerCardTwo.hidden = NO;
    
    if (self.playerCardsForDisplay.count > 2) {
        self.playerCardThree.text = self.playerCardsForDisplay[2];
        self.playerCardThree.hidden = NO;
    }
    if (self.playerCardsForDisplay.count > 3) {
        self.playerCardFour.text = self.playerCardsForDisplay[3];
        self.playerCardFour.hidden = NO;
    }
    if (self.playerCardsForDisplay.count > 4) {
        self.playerCardFive.text = self.playerCardsForDisplay[4];
        self.playerCardFive.hidden = NO;
    }
    
    //Show House Hand
    
    for (FISCard *card in self.game.house.cardsInHand) {
        [self.houseCardsForDisplay addObject:card.cardLabel];
    }

    self.houseCardOne.text = self.houseCardsForDisplay[0];
    self.houseCardOne.hidden = NO;
    self.houseCardTwo.text = self.houseCardsForDisplay[1];
    self.houseCardTwo.hidden = NO;
    
    if (self.houseCardsForDisplay.count > 2) {
        self.houseCardThree.text = self.houseCardsForDisplay[2];
        self.houseCardThree.hidden = NO;
    }
    if (self.houseCardsForDisplay.count > 3) {
        self.houseCardFour.text = self.houseCardsForDisplay[3];
        self.houseCardFour.hidden = NO;
    }
    if (self.houseCardsForDisplay.count > 4) {
        self.houseCardFive.text = self.houseCardsForDisplay[4];
        self.houseCardFive.hidden = NO;
    }
}

-(void)checkForWin{
    if (self.game.house.stayed && self.game.player.handscore > self.game.house.handscore && !self.isAWinner) {
        [self.game houseWins];
        [self announceWinner];
    }
    
    if (self.game.player.handscore == 21 && self.game.house.handscore == 21 && !self.isAWinner) {
        [self.game houseWins];
        [self announceWinner];
    }
    
    if (self.game.house.stayed && self.game.player.stayed && !self.isAWinner) {
        [self.game houseWins];
        [self announceWinner];

    }
    if (self.game.player.cardsInHand.count == 5 && !self.isAWinner) {
        [self.game houseWins];
        [self announceWinner];
    }
    
    if (self.game.player.cardsInHand.count == 5 && self.game.house.cardsInHand.count == 5 && !self.isAWinner) {
        [self.game houseWins];
        [self announceWinner];
    }
    
    if (self.game.player.busted && !self.isAWinner) {
        [self.game houseWins];
        [self announceWinner];
    }
    if (self.game.house.busted && !self.isAWinner) {
        [self.game houseWins];
        [self announceWinner];
    }
    if (self.game.player.blackjack && !self.isAWinner) {
        [self.game houseWins];
        [self announceWinner];
    }
    if (self.game.house.blackjack && !self.isAWinner) {
        [self.game houseWins];
        [self announceWinner];
    }
    [self updateWins];
    
}

-(void)updateWins{
    self.playerWinsLabel.hidden = NO;
    self.playerLossesLabel.hidden = NO;
    self.houseWinsLabel.hidden = NO;
    self.houseLosesLabel.hidden = NO;
    self.houseWinsLabel.text = [NSString stringWithFormat:@"Wins %li",self.game.house.wins];
    self.houseLosesLabel.text = [NSString stringWithFormat:@"Losses %li",self.game.house.losses];
    self.playerWinsLabel.text = [NSString stringWithFormat:@"Wins %li",self.game.player.wins];
    self.playerLossesLabel.text = [NSString stringWithFormat:@"Losses %li",self.game.player.losses];
}

-(void)announceWinner{
    
    if (self.game.houseWins == YES) {
        self.winnerLabel.text = @"House Wins";
        self.isAWinner = YES;
        self.winnerLabel.hidden = NO;
        [self.game incrementWinsAndLossesForHouseWins:YES];
    }
    if (self.game.houseWins == NO) {
        self.isAWinner = YES;
        self.winnerLabel.hidden = NO;
        self.winnerLabel.text = @"You Win!";
        [self.game incrementWinsAndLossesForHouseWins:NO];
    }
    [self updateWins];
}

-(void)checkToDisplayBusted{
    if (self.game.player.busted == YES) {
        self.playerBustedLabel.hidden = NO;
    }
    if (self.game.house.busted == YES) {
        self.houseBustedLabel.hidden = NO;
    }
}

-(void)checkToDisplayStay{
    if (self.game.player.stayed == YES) {
        self.playerStayedLabel.hidden = NO;
    }
    if (self.game.house.stayed == YES) {
        self.houseStayed.hidden = NO;
    }
}

-(void)checkToDisplayBlackjack{
    if (self.game.player.blackjack == YES) {
        self.playerBlackjackLabel.hidden = NO;
    }
    if (self.game.house.blackjack == YES) {
        self.houseBlackjackLabel.hidden = NO;
    }
}

-(void)labelUpdatedAfterTurn {
    [self checkToDisplayStay];
    [self checkToDisplayBusted];
    [self checkToDisplayBlackjack];
    self.playerScoreLabel.hidden = NO;
    self.houseScore.hidden = NO;
    self.houseScore.text = [NSString stringWithFormat:@"%li",self.game.house.handscore];
    self.playerScoreLabel.text = [NSString stringWithFormat:@"%li",self.game.player.handscore];
    
}

-(void)resetGame{
    self.winnerLabel.hidden = YES;
    self.houseCardOne.hidden = YES;
    self.houseCardTwo.hidden = YES;
    self.houseCardThree.hidden = YES;
    self.houseCardFour.hidden = YES;
    self.houseCardFive.hidden = YES;
    self.playerCardOne.hidden = YES;
    self.playerCardTwo.hidden = YES;
    self.playerCardThree.hidden = YES;
    self.playerCardFour.hidden = YES;
    self.playerCardFive.hidden = YES;
    self.houseStayed.hidden = YES;
    self.playerStayedLabel.hidden = YES;
    self.houseBustedLabel.hidden = YES;
    self.playerBustedLabel.hidden = YES;
    self.houseBlackjackLabel.hidden = YES;
    self.playerBlackjackLabel.hidden = YES;
    self.houseScore.hidden = YES;
    self.playerScoreLabel.hidden = YES;
    self.playerWinsLabel.hidden = YES;
    self.houseWinsLabel.hidden = YES;
    self.playerLossesLabel.hidden = YES;
    self.houseLosesLabel.hidden = YES;
    self.isAWinner = NO;
}

@end
