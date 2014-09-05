//
//  DTDFontSizesViewController.m
//  FontsAug
//
//  Created by Tom Edgar on 8/28/14.
//  Copyright (c) 2014 Tom Edgar. All rights reserved.
//

#import "DTDFontSizesViewController.h"

@interface DTDFontSizesViewController ()

@property (strong, nonatomic) NSArray *pointSizes;

@end

@implementation DTDFontSizesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.pointSizes = @[@9,@10,@11,@12,@13,@14,@18,@24,@36,@48,@64,@72,@96,@144];
    
}
- (UIFont *)fontForDisplayAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *pointSize = self.pointSizes[indexPath.row];
    return [self.font fontWithSize:pointSize.floatValue];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.pointSizes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"FontNameAndSize";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.font = [self fontForDisplayAtIndexPath:indexPath];
    cell.textLabel.text = self.font.fontName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ point", self.pointSizes[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont *font = [self fontForDisplayAtIndexPath:indexPath];
    return 25 + font.ascender - font.descender;
}

@end
