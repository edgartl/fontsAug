//
//  DTDFontInfoViewController.m
//  FontsAug
//
//  Created by Tom Edgar on 8/28/14.
//  Copyright (c) 2014 Tom Edgar. All rights reserved.
//

#import "DTDFontInfoViewController.h"
#import "DTDFavoritesList.h"
#import "DTDFontInfoViewController.h"

@interface DTDFontInfoViewController ()

@property (weak, nonatomic) IBOutlet UILabel *fontSampleLabel;
@property (weak, nonatomic) IBOutlet UISlider *fontSizeSlider;
@property (weak, nonatomic) IBOutlet UILabel *fontSizeLabel;
@property (weak, nonatomic) IBOutlet UISwitch *favoriteSwitch;

@end

@implementation DTDFontInfoViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.fontSampleLabel.font = self.font;
    self.fontSampleLabel.text = @"AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz 0123456789";
    self.fontSizeSlider.value = self.font.pointSize;
    self.fontSizeLabel.text = [NSString stringWithFormat:@"%.0f", self.font.pointSize];
    self.favoriteSwitch.on = self.favorite;
}

- (IBAction)slideFontSize:(UISlider *)sender
{
    float newSize = roundf(sender.value);
    self.fontSampleLabel.font = [self.font fontWithSize:newSize];
    self.fontSizeLabel.text = [NSString stringWithFormat:@"%.0f", newSize];
}

- (IBAction)toggleFavorite:(UISwitch *)sender
{
    DTDFavoritesList *favoritesList = [DTDFavoritesList sharedFavoritesList];
    if (sender.isOn) {
        [favoritesList addFavorites:self.font.fontName];
    } else {
        [favoritesList removeFavorites:self.font.fontName];
    }
}



@end
