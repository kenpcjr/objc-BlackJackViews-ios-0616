//
//  FISCard.m
//  OOP-Cards-Model
//
//  Created by Kenneth Cooke on 6/15/16.
//  Copyright © 2016 Al Tyus. All rights reserved.
//

#import "FISCard.h"

@interface  FISCard ()

@property (readwrite, strong, nonatomic) NSString *suit;
@property (readwrite, strong, nonatomic) NSString *rank;
@property (readwrite, strong, nonatomic) NSString *cardLabel;
@property (readwrite, nonatomic) NSUInteger cardValue;

@end

@implementation FISCard

+(NSArray *)validSuits{
    NSArray *suits = @[@"♠", @"♥", @"♣", @"♦"];
    return  suits;
}

+(NSArray *)validRanks{
    NSArray *ranks = @[@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
    return ranks;
}

-(instancetype)init{
    self = [self initWithSuit:@"!" rank:@"N"];
    
    return self;
}

-(instancetype)initWithSuit:(NSString *)suit rank:(NSString *)rank{
    self = [super init];
    if (self) {
        _suit = suit;
        _rank = rank;
        NSString *cardSuitAndRank = [NSString stringWithFormat:@"%@%@", suit, rank];
        _cardLabel = cardSuitAndRank;
        
        NSArray *ranks = [FISCard validRanks];
        
        NSUInteger rankValue = [ranks indexOfObject:rank] + 1;
        if (rankValue <= 10) {
            _cardValue = rankValue;
        }else{
            
            _cardValue = 10;
            
        }
    }
    
    return self;
}

-(NSString *)description{
    return self.cardLabel;
}

@end

