//
//  ViewController.h
//  CM-Activity1
//
//  Created by Cristian Najar on 18/06/15.
//  Copyright (c) 2015 AdHoc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>

@interface Start : UIViewController<CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic)   CLLocationManager   *locationManager;
@property (strong, nonatomic)   CLLocation          *location;

- (IBAction)btnAddNew:(id)sender;


@property (strong, nonatomic) IBOutlet UITableView *tblMain;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segControl;
- (IBAction)Cambio:(UISegmentedControl *)sender;

@end

