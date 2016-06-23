//
//  FISCardDeck.m
//  OOP-Cards-Model
//
//  Created by Kenneth Cooke on 6/15/16.
//  Copyright © 2016 Al Tyus. All rights reserved.
//

#import "FISCardDeck.h"

@implementation FISCardDeck

-(void) createDeck{
    
    NSArray *ranksArray = [FISCard validRanks];
    NSArray *suitsArray = [FISCard validSuits];
    
    for (NSString *rankInArray in ranksArray) {
        for (NSString *suitInArray in suitsArray) {
            FISCard *formattedCard = [[FISCard alloc]initWithSuit:suitInArray rank:rankInArray];
            [self.remainingCards addObject:formattedCard];
        }
    }
    NSLog(@"%@",self.remainingCards);
    
}

-(FISCard *)drawNextCard{
    
    if (self.remainingCards.count != 0) {
        NSUInteger cardIndexToDraw = 0;
        FISCard *drawnCard = self.remainingCards[cardIndexToDraw];
        [self.dealtCards addObject:self.remainingCards[cardIndexToDraw]];
        [self.remainingCards removeObjectAtIndex:cardIndexToDraw];
        return drawnCard;
    } else {
        return nil;
    }
    
}

-(void)resetDeck{
    
    [self shuffleRemainingCards];
    
}

-(void)gatherDealtCards{
    [self.remainingCards addObjectsFromArray:self.dealtCards];
    [self.dealtCards removeAllObjects];
    
}

-(void)shuffleRemainingCards{
    [self gatherDealtCards];
    NSMutableArray *cardsToShuffle = [self.remainingCards mutableCopy];
    NSUInteger startingNumberOfCards = cardsToShuffle.count;
    [self.remainingCards removeAllObjects];
    
    for (NSUInteger i = 0; i < startingNumberOfCards; i++) {
        NSUInteger randomNumber = arc4random_uniform(((uint32_t)cardsToShuffle.count -1));
        [self.remainingCards addObject:cardsToShuffle[randomNumber]];
        [cardsToShuffle removeObjectAtIndex:randomNumber];
    }
    
    
}

-(instancetype)init{
    self = [super init];
    if (self) {
        _remainingCards = [@[]mutableCopy];
        _dealtCards = [@[]mutableCopy];
        [self createDeck];
        
    }
    
    return self;
}

-(NSString *)description{
    NSMutableString *newDescription = [@"" mutableCopy];
    [newDescription appendFormat:@"count:\n%li\n cards: ",self.remainingCards.count];
    for (FISCard *card in self.remainingCards) {
        [newDescription appendFormat:@"%@", card.cardLabel];
    }
    return newDescription;
}

@end
