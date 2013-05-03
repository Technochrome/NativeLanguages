//
//  FirstViewController.h
//  ANLCMapApp
//
//  Created by Rijo Simon on 3/14/13.
//  Copyright (c) 2013 Rijo Simon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface FirstViewController : UIViewController{

    MKMapView *mapView;
}

@property(nonatomic, retain) IBOutlet MKMapView *mapView;

@end
