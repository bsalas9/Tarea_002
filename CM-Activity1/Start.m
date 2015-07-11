//
//  ViewController.m
//  CM-Activity1
//
//  Created by Cristian Najar on 18/06/15.
//  Copyright (c) 2015 AdHoc. All rights reserved.
//
#import <GoogleMaps/GoogleMaps.h>
#import "Start.h"
#import "CustomizedCell.h"
#import "Declarations.h"
#import "CharacterDetails.h"
#import "Add.h"
@import GoogleMaps;

@interface Start ()

@end

#define         nLocalizing     0
#define         nLocalized      1

//Localization
float                   mlatitude;
float                   mlongitude;
static int              iLocalizeState = nLocalizing;

NSMutableArray          *maPlacesTitle;
NSMutableArray          *maPlacesSnippet;
NSMutableArray          *maPlacesLat;
NSMutableArray          *maPlacesLng;



@implementation Start {
    GMSMapView          *mapView;
    GMSMarker           *markerLocation;
    GMSCameraPosition   *camera;
}

/**********************************************************************************************/
#pragma mark - Initialization methods
/**********************************************************************************************/
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initController];
    
    
    //Location
    self.locationManager                    = [[CLLocationManager alloc] init];
    self.locationManager.delegate           = self;
    self.location                           = [[CLLocation alloc] init];
    self.locationManager.desiredAccuracy    = kCLLocationAccuracyBest;
    [self.locationManager  requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    [self initPlaces];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tblMain reloadData];
}
//-------------------------------------------------------------------------------
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-------------------------------------------------------------------------------
-(void)initController {
    //Initialize arrays
    maNombre         = [[NSMutableArray alloc] initWithObjects: @"UAG", @"ITESO", @"UVM", @"CUCEA", @"TEC", nil];
    maDescripcion         = [[NSMutableArray alloc] initWithObjects: @"uag", @"iteso", @"uvm", @"cucea", @"tec", nil];
    maLatitud          = [[NSMutableArray alloc] initWithObjects: @"20.694609", @"20.608193", @"20.603197", @"20.742370", @"20.733393", nil];
    maLongitud          = [[NSMutableArray alloc] initWithObjects:
                       @"-103.418136" ,
                       @"-103.413389",
                       @"-103.397583",
                       @"-103.380201",
                       @"-103.456170", nil];
}

/**********************************************************************************************/
#pragma mark - Table source and delegate methods
/**********************************************************************************************/


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//-------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return maNombre.count;
}
//-------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}
//-------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Initialize cells
    CustomizedCell *cell = (CustomizedCell *)[self.tblMain dequeueReusableCellWithIdentifier:@"CustomizedCell"];
    
    if (cell == nil) {
        [self.tblMain  registerNib:[UINib nibWithNibName:@"CustomizedCell" bundle:nil] forCellReuseIdentifier:@"CustomizedCell"];
        cell = [self.tblMain  dequeueReusableCellWithIdentifier:@"CustomizedCell"];
    }
    //Fill cell with info from arrays
    cell.lblNombre.text   = maNombre[indexPath.row];
    cell.lblDescripcion.text    = maDescripcion[indexPath.row];
    cell.lblLatitud.text   = maLatitud[indexPath.row];
    cell.lblLongitud.text    = maLongitud[indexPath.row];
    
    /*
    //Check if there are not image in the carpet and load the image from memory
    if ([UIImage imageNamed:maImgs[indexPath.row]] == nil) {
        NSString *cachedFolderPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString *cachedImagePath = [cachedFolderPath stringByAppendingPathComponent:maImgs[indexPath.row]];
        cell.imgCharacter.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:cachedImagePath]];
    }else {
        cell.imgCharacter.image  = [UIImage imageNamed:maImgs[indexPath.row]];
    }
     
     */
    
    return cell;
}
//-------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    miCharacterIndex = (int)indexPath.row;
    CharacterDetails *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CharacterDetails"];
    
    [self presentViewController:viewController animated:YES completion:nil];
    
}

/**********************************************************************************************/
#pragma mark - Action methods
/**********************************************************************************************/
- (IBAction)btnAddNew:(id)sender {
     AddNew *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"AddNew"];
    
    [self presentViewController:viewController animated:YES completion:nil];
}

/**********************************************************************************************/
#pragma mark - Action methods
/**********************************************************************************************/

- (IBAction)Cambio:(UISegmentedControl *)sender {
    switch (self.segControl.selectedSegmentIndex) {
        case 0:
            self.tblMain.hidden = NO;
            mapView.hidden = YES;
            break;
            
        case 1:
            
            self.tblMain.hidden = YES;
            [self paintMap];
            [self paintMarker];
            break;
            
        default:
            break;
    }
}
- (void)initPlaces {
    maPlacesLat     = [[NSMutableArray alloc] initWithObjects: @"20.674815", @"20.710549",@"20.677541",@"20.682093", nil];
    maPlacesLng     = [[NSMutableArray alloc] initWithObjects: @"-103.387295", @"-103.412525",@"-103.432751",@"-103.462570", nil];
    maPlacesTitle   = [[NSMutableArray alloc] initWithObjects: @"Minerva", @"Andares", @"Galerías", @"Omnilife", nil];
    maPlacesSnippet = [[NSMutableArray alloc] initWithObjects: @"Av Vallarta", @"Zapopan",@"Fashion Mall", @"Chivas", nil];
}
/**********************************************************************************************/
#pragma mark - Maps methods
/**********************************************************************************************/

- (void) paintMap {
    [mapView removeFromSuperview];
    camera                      = [GMSCameraPosition cameraWithLatitude:20.694609 longitude:-103.418136 zoom:14.0];
    mapView                     = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.frame               = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height-100);
    mapView.myLocationEnabled   = YES;
    
    [self.view addSubview:mapView];
    //[self.view bringSubviewToFront:self.lblName];
    //[self.view bringSubviewToFront:self.lblCountry];
}
//------------------------------------------------------------
- (void) paintMarker {
    GMSMarker *marker       = [[GMSMarker alloc] init];
    marker.position         = camera.target;
    marker.title            = @"UAG";
    marker.snippet          = @"Clase de Maestría";
    marker.appearAnimation  = kGMSMarkerAnimationPop;
    marker.map = mapView;
    
    CLLocationCoordinate2D position;
    NSLog(@"maPlacesTitle.count %d", (int)maPlacesTitle.count);
    for (int i = 0; i<maPlacesTitle.count; i++)
    {
        CGFloat lat                     = (CGFloat)[maPlacesLat[i] floatValue];
        CGFloat lng                     = (CGFloat)[maPlacesLng[i] floatValue];
        NSLog(@"Marker lat %f, long %f", lat, lng);
        position                        = CLLocationCoordinate2DMake(lat, lng);
        markerLocation                  = [GMSMarker markerWithPosition:position];
        markerLocation.icon             = [GMSMarker markerImageWithColor:[UIColor greenColor]];
        markerLocation.title            = maPlacesTitle[i];
        markerLocation.snippet          = maPlacesSnippet[i];
        markerLocation.appearAnimation  = kGMSMarkerAnimationPop;
        markerLocation.map              = mapView;
    }
}
/**********************************************************************************************/
#pragma mark - Localization
/**********************************************************************************************/
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.location = locations.lastObject;
    NSLog(@"didUpdateLocation!");
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:self.locationManager.location completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark *placemark in placemarks) {
            NSString *addressName = [placemark name];
            NSString *city = [placemark locality];
            NSString *administrativeArea = [placemark administrativeArea];
            NSString *country  = [placemark country];
            NSString *countryCode = [placemark ISOcountryCode];
            NSLog(@"name is %@ and locality is %@ and administrative area is %@ and country is %@ and country code %@", addressName, city, administrativeArea, country, countryCode);
            //self.lblCountry.text = country;
            //self.lblName.text = addressName;
            //self.lblName.adjustsFontSizeToFitWidth = YES;
        }
        
        mlatitude = self.locationManager.location.coordinate.latitude;
        mlongitude = self.locationManager.location.coordinate.longitude;
        NSLog(@"mlatitude = %f", mlatitude);
        NSLog(@"mlongitude = %f", mlongitude);
        if (iLocalizeState == nLocalizing) {
            [self paintMap];
            [self paintMarker];
            iLocalizeState = nLocalized;
        }
    }];
    
}
@end
