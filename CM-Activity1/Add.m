//
//  Add.m
//  CM-Activity1
//
//  Created by Cristian Najar on 18/06/15.
//  Copyright (c) 2015 AdHoc. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "Add.h"
#import "Declarations.h"

UIImagePickerController *imgPicker;

@interface AddNew ()

@end

@implementation AddNew

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
    //[[self.txtViewDesc layer] setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    //[[self.txtViewDesc layer] setBorderWidth:1];
    //[[self.txtViewDesc layer] setCornerRadius:5];
    //self.txtViewDesc.clipsToBounds = YES;
}


/**********************************************************************************************/
#pragma mark - Action button methods
/**********************************************************************************************/
- (IBAction)btnAdd:(id)sender {
    [maNombre  addObject:  self.txtNombre.text];
    [maDescripcion addObject:  self.txtDescripcion.text];
    [maLatitud  addObject:  self.txtLatitud.text];
    [maLongitud  addObject:  self.txtLongitud.text];
  /*
    NSString *imgName = [self.txtName.text stringByAppendingString:@".png"];
    
    [imgName stringByReplacingOccurrencesOfString: @" " withString: @"_"];
    [maImgs addObject: imgName];
    
    UIImage *image = self.imgAddImg.image;
    NSString *cachedFolderPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *cachedImagePath = [cachedFolderPath stringByAppendingPathComponent:imgName];
    [UIImagePNGRepresentation(image) writeToFile:cachedImagePath atomically:YES];
    */
    
    [self dismissViewControllerAnimated:YES completion:nil];
   
   
}


- (IBAction)btnCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnGetLocation:(id)sender {
}
 
 

@end
