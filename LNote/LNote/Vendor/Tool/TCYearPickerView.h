//
//  TCYearPickerView.h
//  SecurityNote
//
//  Created by HTC on 14-9-30.
//   
//

#import <UIKit/UIKit.h>

@protocol TCYearPickerViewDelegate <NSObject>

//协议，代理
@optional

-(void)didCancelSelectYear;

-(void)didSaveYear;

@end


@interface TCYearPickerView : UIView

@property (nonatomic, weak) UIPickerView * yearPickers;
@property (nonatomic, weak) id<TCYearPickerViewDelegate> delegate;


+(TCYearPickerView *)initWithPicker:(CGRect )viewFrame;

-(void) popYearPickerView;

-(void) hiddenYearPickerView;


@end
