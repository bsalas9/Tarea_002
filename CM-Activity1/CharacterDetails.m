//
//  CharacterDetailsViewController.m
//  CM-Activity1
//
//  Created by Cristian Najar on 18/06/15.
//  Copyright (c) 2015 AdHoc. All rights reserved.
//

#import "CharacterDetails.h"
#import "Declarations.h"

@interface CharacterDetails ()

@end

@implementation CharacterDetails

/**********************************************************************************************/
#pragma mark - Init Methods
/**********************************************************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initController];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initController {
    self.lblDescription.adjustsFontSizeToFitWidth = YES;
    self.lblDescription.text   = maDescripcion[miCharacterIndex];
    /*
    if ([UIImage imageNamed:maImgs[miCharacterIndex]] == nil) {
        NSString *cachedFolderPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString *cachedImagePath = [cachedFolderPath stringByAppendingPathComponent:maImgs[miCharacterIndex]];
        self.imgCharacter.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:cachedImagePath]];
    }else {
        self.imgCharacter.image  = [UIImage imageNamed:maImgs[miCharacterIndex]];
    }
     
     */
}

/**********************************************************************************************/
#pragma mark - Buttons methods
/**********************************************************************************************/
- (IBAction)btnBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
