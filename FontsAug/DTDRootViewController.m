//
//  DTDRootViewController.m
//  FontsAug
//
//  Created by Tom Edgar on 8/28/14.
//  Copyright (c) 2014 Tom Edgar. All rights reserved.
//

#import "DTDRootViewController.h"
#import "DTDFavoritesList.h"
#import "DTDFontsListViewController.h"

@interface DTDRootViewController ()

@property (copy,nonatomic) NSArray *familyNames;
@property (assign, nonatomic) CGFloat cellPointSize;
@property (strong, nonatomic) DTDFavoritesList *favoritesList;


@end

@implementation DTDRootViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.familyNames = [[UIFont familyNames] sortedArrayUsingSelector:@selector(compare:)];
    UIFont *preferredTableViewFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.cellPointSize = preferredTableViewFont.pointSize;
    self.favoritesList = [DTDFavoritesList sharedFavoritesList];
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *myDocDir = paths[0];
//    NSLog(@"File is at %@", myDocDir);
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

//utility method
- (UIFont *)fontForDisplayAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString *familyName = self.familyNames[indexPath.row];
        NSString *fontName = [[UIFont fontNamesForFamilyName:familyName] firstObject];
        return [UIFont fontWithName:fontName size:self.cellPointSize];
    } else {
        return nil;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.favoritesList.favorites count] > 0) {
        return 2;
    } else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.familyNames count];
    } else {
        return 1;
    }
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"All Font Families";
    } else {
        return @"Font Favorites";
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *familyNameCell = @"FamilyName";
    static NSString *favoritesCell = @"Favorites";
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:familyNameCell
                                               forIndexPath:indexPath];
        cell.textLabel.font = [self fontForDisplayAtIndexPath:indexPath];
        cell.textLabel.text = self.familyNames[indexPath.row];
        cell.detailTextLabel.text = self.familyNames[indexPath.row];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:favoritesCell
                                               forIndexPath:indexPath];
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        UIFont *font = [self fontForDisplayAtIndexPath:indexPath];
        return 25 + font.ascender - font.descender;
    } else {
        return tableView.rowHeight;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    DTDFontsListViewController *fontListVC = segue.destinationViewController;
    
    if (indexPath.section == 0) {
        NSString *familyName = self.familyNames[indexPath.row];
        fontListVC.fontNames = [[UIFont fontNamesForFamilyName:familyName]
                                sortedArrayUsingSelector:@selector(compare:)];
        
        fontListVC.navigationItem.title = familyName;
        fontListVC.showsFavorites = NO;
    } else {
        fontListVC.fontNames = self.favoritesList.favorites;
        fontListVC.navigationItem.title = @"Favorites";
        fontListVC.showsFavorites = YES;
    }
}

@end
