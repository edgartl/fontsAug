//
//  DTDFontsListViewController.m
//  FontsAug
//
//  Created by Tom Edgar on 8/28/14.
//  Copyright (c) 2014 Tom Edgar. All rights reserved.
//

#import "DTDFontsListViewController.h"
#import "DTDFavoritesList.h"
#import "DTDFontSizesViewController.h"
#import "DTDFontInfoViewController.h"

@interface DTDFontsListViewController ()

@property (assign, nonatomic) CGFloat cellPointSize;

@end

@implementation DTDFontsListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIFont *preferredTableViewFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    self.cellPointSize = preferredTableViewFont.pointSize;
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.showsFavorites) {
        self.fontNames = [DTDFavoritesList sharedFavoritesList].favorites;
        [self.tableView reloadData];
    }
}

//utility method
- (UIFont *)fontForDisplayAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *fontName = self.fontNames[indexPath.row];
    return [UIFont fontWithName:fontName size:self.cellPointSize];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.fontNames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FontName";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    // Configure the cell...
    cell.textLabel.font = [self fontForDisplayAtIndexPath:indexPath];
    cell.textLabel.text = self.fontNames[indexPath.row];
    cell.detailTextLabel.text = self.fontNames[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont *font = [self fontForDisplayAtIndexPath:indexPath];
    return 25 + font.ascender - font.descender;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    UIFont *font = [self fontForDisplayAtIndexPath:indexPath];
    [segue.destinationViewController navigationItem].title = font.fontName;
    
    if ([segue.identifier isEqualToString:@"ShowSizes"]) {
        DTDFontSizesViewController *fontSizesVC = segue.destinationViewController;
        fontSizesVC.font = font;
    } else if ([segue.identifier isEqualToString:@"ShowFontInfo"]){
        DTDFontInfoViewController *fontInfoVC = segue.destinationViewController;
        fontInfoVC.font = font;
        fontInfoVC.favorite = [[DTDFavoritesList sharedFavoritesList].favorites containsObject:font.fontName];
    }
}


@end
