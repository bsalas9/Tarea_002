//
//  AddN.h
//  CM-Activity1
//
//  Created by Cristian Najar on 18/06/15.
//  Copyright (c) 2015 AdHoc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddNew : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *txtNombre;
@property (strong, nonatomic) IBOutlet UITextField *txtDescripcion;
@property (strong, nonatomic) IBOutlet UITextField *txtLatitud;
@property (strong, nonatomic) IBOutlet UITextField *txtLongitud;



- (IBAction)btnAdd:(id)sender;
- (IBAction)btnCancel:(id)sender;
- (IBAction)btnGetLocation:(id)sender;


@property (strong, nonatomic) IBOutlet UIButton *btnAddImgProp;

@end
