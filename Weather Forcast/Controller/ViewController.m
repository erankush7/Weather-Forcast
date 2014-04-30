//
//  ViewController.m
//  Weather Forcast
//
//  Created by Ankush Sharma on 28/04/14.
//  Copyright (c) 2014 Ankush. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize m_LocationManager;
@synthesize m_DayValue;
@synthesize m_WeatherDictionary;
- (void)viewDidLoad{
    [super viewDidLoad];
    //setting day value to 0
    m_DayValue=0;
    [self.m_ActivityIndicator startAnimating];
    [self getLocationManager];
}
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}
#pragma Location Update Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
        [self.m_LocationManager stopUpdatingLocation];
        CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
        [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            for (CLPlacemark * placemark in placemarks) {
                self.m_LocationName.text=[NSString stringWithFormat:@"%@",[placemark locality]];
                [self callToWeatherAPI:[placemark locality]];
            }}];
}
#pragma Custom methods
-(void)getLocationManager{
    m_LocationManager = [[CLLocationManager alloc] init];
    m_LocationManager.delegate = self;
    m_LocationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    [m_LocationManager startUpdatingLocation];
}
#pragma Call to Weather API
-(void)callToWeatherAPI :(NSString*)cityName{
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@%@%@%@",kWeatherRequest,kWeathercityString,cityName,kWeatherCNT,kWeatherAPI]]];
    NSOperationQueue *queue=[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *error) {
         NSString *result = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
         NSData *dataValue = [result dataUsingEncoding:NSUTF8StringEncoding];
         NSDictionary *WeatherInformation = [NSJSONSerialization JSONObjectWithData:dataValue options:0 error:nil];
         m_WeatherDictionary=nil;
         m_WeatherDictionary=[[NSMutableDictionary alloc]initWithDictionary:WeatherInformation ];
         dispatch_async(dispatch_get_main_queue(), ^{
             [self.m_ActivityIndicator stopAnimating];
         [self setInformation];
         });}];
}
#pragma Setting Information
-(void)setInformation{
    self.m_DayString.text=[NSString stringWithFormat:@"%i",m_DayValue+1];
    self.m_HumidityText.text=[NSString stringWithFormat:@"%@",[[[self.m_WeatherDictionary objectForKey:@"list"] objectAtIndex:m_DayValue] objectForKey:@"humidity"]];
    self.m_tempLabel.text=[NSString stringWithFormat:@"%@°",[[[self.m_WeatherDictionary objectForKey:@"list"] objectAtIndex:m_DayValue] objectForKey:@"deg"]];
    self.m_PressureText.text=[NSString stringWithFormat:@"%@",[[[self.m_WeatherDictionary objectForKey:@"list"] objectAtIndex:m_DayValue] objectForKey:@"pressure"]];
    self.m_SpeedText.text=[NSString stringWithFormat:@"%@",[[[self.m_WeatherDictionary objectForKey:@"list"] objectAtIndex:m_DayValue] objectForKey:@"speed"]];
    self.m_DayText.text=[NSString stringWithFormat:@"%@°",[[[[self.m_WeatherDictionary objectForKey:@"list"] objectAtIndex:m_DayValue] objectForKey:@"temp"] objectForKey:@"day"]];
      self.m_EveningText.text=[NSString stringWithFormat:@"%@°",[[[[self.m_WeatherDictionary objectForKey:@"list"] objectAtIndex:m_DayValue] objectForKey:@"temp"] objectForKey:@"eve"]];
       self.m_MaximumText.text=[NSString stringWithFormat:@"%@°",[[[[self.m_WeatherDictionary objectForKey:@"list"] objectAtIndex:m_DayValue] objectForKey:@"temp"] objectForKey:@"max"]];
       self.m_Minimutext.text=[NSString stringWithFormat:@"%@°",[[[[self.m_WeatherDictionary objectForKey:@"list"] objectAtIndex:m_DayValue] objectForKey:@"temp"] objectForKey:@"min"]];
       self.m_Morningtext.text=[NSString stringWithFormat:@"%@°",[[[[self.m_WeatherDictionary objectForKey:@"list"] objectAtIndex:m_DayValue] objectForKey:@"temp"] objectForKey:@"morn"]];
   self.m_nightText.text=[NSString stringWithFormat:@"%@°",[[[[self.m_WeatherDictionary objectForKey:@"list"] objectAtIndex:m_DayValue] objectForKey:@"temp"] objectForKey:@"night"]];
       self.m_detailtext.text=[NSString stringWithFormat:@"%@",[[[[[self.m_WeatherDictionary objectForKey:@"list"] objectAtIndex:m_DayValue] objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"description"]];
       self.m_Summarytext.text=[NSString stringWithFormat:@"%@",[[[[[self.m_WeatherDictionary objectForKey:@"list"] objectAtIndex:m_DayValue] objectForKey:@"weather"] objectAtIndex:0] objectForKey:@"main"]];
}
#pragma Textfield Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (textField.text.length>0) {
        [self.m_ActivityIndicator startAnimating];
        [self.view endEditing:YES];
        self.m_LocationName.text=[NSString stringWithFormat:@"%@",textField.text];
    [self callToWeatherAPI:textField.text];
    }
    return YES;
}
#pragma Gesture methods
- (IBAction)swipeleft:(id)sender {
        if (m_DayValue<13) {
        m_DayValue++;
    }
    [self setInformation];
}
- (IBAction)swipeRight:(id)sender {
    if (m_DayValue>0) {
        m_DayValue--;
    }
    [self setInformation];
}
- (IBAction)tapclicked:(id)sender {
    [self.view endEditing:YES];
}
@end
