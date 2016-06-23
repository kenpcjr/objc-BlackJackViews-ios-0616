//
//  FISBlackjackGame.m
//  BlackJack
//
//  Created by Kenneth Cooke on 6/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "FISBlackjackGame.h"

@implementation FISBlackjackGame

-(instancetype)init{
    self = [super init];
    if (self){
        _deck = [[FISCardDeck alloc]init];
        FISBlackjackPlayer *house = [[FISBlackjackPlayer alloc]init];
        house.name = @"House";
        _house = house;
        FISBlackjackPlayer *player = [[FISBlackjackPlayer alloc]init];
        player.name = @"Player";
        _player = player;
    }
    
    return self;
}

-(void)playBlackJack{
    
    [self.deck resetDeck];
    [self.house resetForNewGame];
    [self.player resetForNewGame];
    [self dealNewRound];
    
    for (NSUInteger i = 0; i < 3; i++) {
        [self dealCardToPlayer];
        if (self.player.busted) {
            break;
        }
        [self dealCardToHouse];
        if (self.house.busted) {
            break;
        }
    }
    
    
    BOOL winner = [self houseWins];
    [self incrementWinsAndLossesForHouseWins:winner];
    
    NSLog(@"%@",[self.player description]);
    NSLog(@"%@",[self.house description]);
    
}

-(void)dealNewRound{
    
    [self dealCardToPlayer];
    [self dealCardToHouse];
    [self dealCardToPlayer];
    [self dealCardToHouse];
    
}

-(void)dealCardToPlayer{
    
    [self.player acceptCard:[self.deck drawNextCard]];
}

-(void)dealCardToHouse{
    
    [self.house acceptCard:[self.deck drawNextCard]];
}

-(void)processPlayerTurn{
    
    if (self.player.busted == NO && self.player.stayed == NO && self.player.shouldHit) {
        [self dealCardToPlayer];
    }
    
}

-(void)processHouseTurn{
    
    if (self.house.busted == NO && self.house.stayed == NO && self.house.shouldHit) {
        [self dealCardToHouse];
    }else{
        self.house.stayed = YES;
    }
    
}

-(BOOL)houseWins{
    
    if (self.player.busted && !self.house.busted) {
        return YES;
    }
    
    if (self.player.handscore < self.house.handscore && !self.house.busted) {
        return YES;
    }
    
    if (self.player.handscore == self.house.handscore && !self.house.blackjack && !self.house.busted) {
        return YES;
    }
    if (self.house.blackjack && !self.player.blackjack) {
        return YES;
    }
    
    return NO;
}

-(void)incrementWinsAndLossesForHouseWins:(BOOL)houseWins{
    
    if (houseWins) {
        self.house.wins++;
        self.player.losses++;
        
        NSLog(@"Sweet! %@ won!\n Wins: %li\n Losses: %li", self.house.name, self.house.wins, self.house.losses);
        
    }else{
        
        self.player.wins++;
        self.house.losses++;
        
        NSLog(@"Sweet! %@ won!\n Wins: %li\n Losses: %li", self.player.name, self.player.wins, self.player.losses);
    }
    
    
    
}

@end
