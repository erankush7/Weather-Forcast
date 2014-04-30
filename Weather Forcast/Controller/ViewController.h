//
//  ViewController.h
//  Weather Forcast
//
//  Created by Ankush Sharma on 28/04/14.
//  Copyright (c) 2014 Ankush. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController<CLLocationManagerDelegate,UITextFieldDelegate>
//Object Properties
@property (weak, nonatomic) IBOutlet UILabel *m_LocationName;
@property (weak, nonatomic) IBOutlet UILabel *m_Minimutext;
@property (weak, nonatomic) IBOutlet UILabel *m_PressureText;
@property (weak, nonatomic) IBOutlet UILabel *m_SpeedText;
@property (weak, nonatomic) IBOutlet UILabel *m_Morningtext;
@property (weak, nonatomic) IBOutlet UILabel *m_EveningText;
@property (weak, nonatomic) IBOutlet UILabel *m_DayText;
@property (weak, nonatomic) IBOutlet UILabel *m_Summarytext;
@property (weak, nonatomic) IBOutlet UILabel *m_detailtext;
@property (weak, nonatomic) IBOutlet UITextField *m_CityTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *m_ActivityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *m_tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *m_UnitLabel;
@property (weak, nonatomic) IBOutlet UILabel *m_HumidityText;
@property (weak, nonatomic) IBOutlet UILabel *m_nightText;
@property (weak, nonatomic) IBOutlet UILabel *m_MaximumText;
@property(nonatomic,strong)CLLocationManager *m_LocationManager;
@property (weak, nonatomic) IBOutlet UILabel *m_DayString;
@property(nonatomic)int m_DayValue;
@property(nonatomic,strong)NSMutableDictionary *m_WeatherDictionary;
//Actions
- (IBAction)tapclicked:(id)sender;
- (IBAction)swipeleft:(id)sender;
- (IBAction)swipeRight:(id)sender;
//Functions
-(void)getLocationManager;
-(void)callToWeatherAPI :(NSString*)cityName;
@end
