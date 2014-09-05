//
//  DTDFavoritesList.h
//  FontsAug
//
//  Created by Tom Edgar on 8/28/14.
//  Copyright (c) 2014 Tom Edgar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DTDFavoritesList : NSObject

//factory method
+ (instancetype)sharedFavoritesList;

- (NSArray *)favorites;

- (void)addFavorites:(id)item;
- (void)removeFavorites:(id)item;

@end
