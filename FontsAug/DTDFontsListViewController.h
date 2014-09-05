//
//  DTDFontsListViewController.h
//  FontsAug
//
//  Created by Tom Edgar on 8/28/14.
//  Copyright (c) 2014 Tom Edgar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTDFontsListViewController : UITableViewController

@property (copy,nonatomic) NSArray *fontNames;
@property (assign, nonatomic) BOOL showsFavorites;

@end
