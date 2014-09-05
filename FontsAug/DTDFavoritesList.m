//
//  DTDFavoritesList.m
//  FontsAug
//
//  Created by Tom Edgar on 8/28/14.
//  Copyright (c) 2014 Tom Edgar. All rights reserved.
//

#import "DTDFavoritesList.h"

@interface DTDFavoritesList ()

@property (strong, nonatomic) NSMutableArray *favorites;

@end

@implementation DTDFavoritesList

+ (instancetype)sharedFavoritesList
{
    static DTDFavoritesList *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        shared = [[self alloc] init];
        
    });
    
    return shared;
}


- (instancetype)init
{
    
    self = [super init];
    
    if (self) {
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSArray *storedFavorites = [defaults objectForKey:@"favorites"];
        //any faves in prefs? if so, put a mutable copy in fave prop -
        //otherwise - empty mutable array in prop
        if (storedFavorites) {
            self.favorites = [storedFavorites mutableCopy];
        } else {
            self.favorites = [NSMutableArray array];
        }
        
    }
    return self;
}


- (void)addFavorites:(id)item
{
    [_favorites insertObject:item atIndex:0];
    [self saveFavorites];
}

- (void)removeFavorites:(id)item
{
    [_favorites removeObject:item];
    [self saveFavorites];
}

- (void)saveFavorites
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.favorites forKey:@"favorites"];
    [defaults synchronize];
}


@end

















