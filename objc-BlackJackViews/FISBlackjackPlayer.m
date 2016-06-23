//
//  FISBlackjackPlayer.m
//  BlackJack
//
//  Created by Kenneth Cooke on 6/16/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

#import "FISBlackjackPlayer.h"

@implementation FISBlackjackPlayer

-(instancetype)init{
    self = [self initWithName:@""];
    return self;
}

-(instancetype)initWithName:(NSString *)name{
    self = [super init];
    
    if (self) {
        _name = name;
        _cardsInHand = [[NSMutableArray alloc]init];
        _aceInHand = NO;
        _blackjack = NO;
        _busted = NO;
        _stayed = NO;
        _handscore = 0;
        _wins = 0;
        _losses = 0;
        
    }
    
    return self;
}

-(NSString *)description{
    NSMutableString *newDescription = [[NSMutableString alloc]init];
    NSMutableArray *cardLabels = [[NSMutableArray alloc]init];
    
    for (NSUInteger i = 0; i < self.cardsInHand.count; i++) {
        FISCard *currentCardForLabel = self.cardsInHand[i];
        NSString *labelToAdd = [NSString stringWithFormat:@"%@",currentCardForLabel.cardLabel];

        [cardLabels addObject:labelToAdd];
    }
    
    
    [newDescription appendFormat:@"Player Name: %@\nCards in Hand: %@\nHas an Ace: %d\n Has Blackjack: %d\n Busted: %d\n Stayed: %d\n Current Handscore: %li\n Wins: %li\n Losses: %li", self.name, cardLabels, self.aceInHand, self.blackjack, self.busted, self.stayed, self.handscore, self.wins, self.losses];
    
    return newDescription;
}

-(void)resetForNewGame{
    self.handscore = 0;
    [self.cardsInHand removeAllObjects];
    self.aceInHand = NO;
    self.blackjack = NO;
    self.busted = NO;
    self.stayed = NO;
}

-(void)acceptCard:(FISCard *)card{
    
    [self.cardsInHand addObject:card];
    self.handscore += card.cardValue;
    
    
    if ([card.cardLabel containsString:@"A"] && self.handscore <= 11) {
        self.aceInHand = YES;
        self.handscore += 10;
        
    }else if ([card.cardLabel containsString:@"A"]){
        self.aceInHand = YES;
    }
    
    if (self.handscore == 21 && self.cardsInHand.count == 2) {
        self.blackjack = YES;
        
    }
    if (self.handscore > 21) {
        _busted =YES;
        
    }
    
}

-(BOOL)shouldHit{
    if (self.handscore >= 17) {
        self.stayed = YES;
        
    } else {
        
        return YES;
    }
    return NO;
}


@end
