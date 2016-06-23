//
//  FISCard.h
//  OOP-Cards-Model
//
//  Created by Kenneth Cooke on 6/15/16.
//  Copyright © 2016 Al Tyus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FISCard : NSObject

@property (readonly, strong, nonatomic) NSString *suit;
@property (readonly, strong, nonatomic) NSString *rank;
@property (readonly, strong, nonatomic) NSString *cardLabel;
@property (readonly, nonatomic) NSUInteger cardValue;

-(instancetype)init;

-(instancetype)initWithSuit:(NSString *)suit rank:(NSString *)rank;

+(NSArray *)validSuits;
+(NSArray *)validRanks;

-(NSString *)description;

@end
