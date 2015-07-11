//
//  CharacterDetailsViewController.h
//  CM-Activity1
//
//  Created by Cristian Najar on 18/06/15.
//  Copyright (c) 2015 AdHoc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CharacterDetails : UIViewController


@property (strong, nonatomic) IBOutlet UIImageView *imgCharacter;

- (IBAction)btnBack:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *lblDescription;

@end
