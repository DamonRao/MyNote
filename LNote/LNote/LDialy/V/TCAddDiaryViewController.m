//
//  TCAddDiaryViewController.m
//  SecurityNote
//


#import "TCAddDiaryViewController.h"
#import "TCDatePickerView.h"
#import "TCDiary.h"
#import "MBProgressHUD+MJ.h"
#import "DHDeviceUtil.h"
#import "ICLanguageTool.h"
@interface TCAddDiaryViewController ()<UITextFieldDelegate,UITextViewDelegate, TCDatePickerViewDelegate,UIScrollViewDelegate>

@property (nonatomic, weak) UITextField * titleField;
@property (nonatomic, weak) UITextView * detailView;
@property (nonatomic, weak) UILabel * dateLabel;
@property (nonatomic, strong) TCDatePickerView * pickerView;
@property (nonatomic, strong) TCDiary * diaryNote;
@property (nonatomic, weak) UITextField * weatherField;
@property (nonatomic, weak) UITextField * moodField;

@property (nonatomic, copy) NSString * originalDate;

@end

@implementation TCAddDiaryViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //导航栏颜色
    [self topColor];
    
    //标题
    [self titleFileds];
    
    //简记内容
    [self detailViews];
    
    //取消返回
    [self backBtn];
    
    //保存更改
    [self saveBtn];
    
    //时间标签
    [self showdateLabel];
    
    //天气标签
    [self showWeather];
    
    //心情标签
    [self showMood];
    
    
    
    //时间选择器 !!!必须放在最后，点击时，可以显示出来
    self.pickerView = [TCDatePickerView initWithPicker:self.view.frame];
    self.pickerView.delegate = self;
    [self.view addSubview:self.pickerView];

    
    
}


//懒加载
-(TCDiary *)diaryNote
{
    if (_diaryNote == nil)
    {
        _diaryNote = [[TCDiary alloc]init];
    }
    
    return _diaryNote;
}


//导航栏颜色
-(void)topColor
{
    
    CGFloat top = TopBarHeight;
    UIView * topColor = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, top)];
    
    topColor.backgroundColor  = TCBgColor;//[UIColor colorWithRed:0/255.0 green:122/255.0 blue:252/255.0 alpha:1];
    
    [self.view addSubview:topColor];

}


//LNote
-(void)titleFileds
{
    CGFloat top = StatueBarHeight+20;
    
    UITextField * titleField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 125, 44)];
    titleField.center = CGPointMake(self.view.frame.size.width /2+10,top);
    titleField.font = [UIFont boldSystemFontOfSize:16];
    titleField.placeholder = LocalString(@"LNote title");
    titleField.textAlignment = NSTextAlignmentCenter;
    titleField.clearButtonMode =UITextFieldViewModeWhileEditing;
    [titleField becomeFirstResponder];

    self.titleField = titleField;
    
    [self.view addSubview:titleField];
    
}


//内容栏
-(void)detailViews
{
    CGFloat top = 120 + (MACRO_IS_IPHONE_X ? 14 : 0);
    UITextView * detailView =[[UITextView alloc]initWithFrame:CGRectMake(10, top, self.view.frame.size.width - 20, self.view.frame.size.height - 120)];
    detailView.font = [UIFont systemFontOfSize:18];
//    detailView.layer.borderWidth = 1.5;
//    detailView.layer.borderColor = [[UIColor colorWithRed:0/255.0 green:122/255.0 blue:252/255.0 alpha:1] CGColor];
//    detailView.layer.cornerRadius = 4.0f;
    detailView.layer.masksToBounds = YES;
    detailView.alwaysBounceVertical = YES;

    //初始化
    detailView.text = @"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n";

    self.detailView = detailView;
    self.detailView.delegate = self;
    [self.view addSubview:detailView];

}


//时间标签
-(void)showdateLabel
{
   CGFloat top = 95 +  (MACRO_IS_IPHONE_X ? 14 : 0);
    UILabel * dateLabel =[[UILabel alloc]initWithFrame:CGRectMake(10, top, 120, 15)];
    dateLabel.text = [TCDatePickerView getNowDateFormat:@"MMdd HH:mm"];
    dateLabel.font = [UIFont systemFontOfSize:16];
   // dateLabel.userInteractionEnabled = YES;
    self.dateLabel = dateLabel;
    [self.view addSubview:dateLabel];
    
    //提供点击显示时间选择器
    UIButton * touchLabel = [[UIButton alloc]initWithFrame:CGRectMake(0, top -5, 130, 20)];
    [touchLabel addTarget:self action:@selector(showPicker) forControlEvents:UIControlEventTouchUpInside];
    
    self.diaryNote.time = [TCDatePickerView getNowDateFormat:@"yyyyMMdd HH:mm"];

    [self.view addSubview:touchLabel];

}

//时间选择器
-(void)showPicker
{
    
    self.originalDate = self.dateLabel.text;
    
    [self.pickerView popDatePickerView];
    
    //点击DateLable时，归零(到现在的时间）
    [self.pickerView resetToZero];
    
    
    [self.view endEditing:YES];
    
}


//天气标签
-(void)showWeather
{
    CGFloat top = 93 + (MACRO_IS_IPHONE_X ? 14 : 0);
    UITextField * weatherField = [[UITextField alloc]initWithFrame:CGRectMake(130, top, (self.view.frame.size.width -135)/ 2, 20)];
    weatherField.font = [UIFont systemFontOfSize:16];
    weatherField.placeholder = LocalString(@"weather");
    weatherField.textAlignment = NSTextAlignmentCenter;
    weatherField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.weatherField = weatherField;
    
    [self.view addSubview:weatherField];

}


//心情标签
-(void)showMood
{
    CGFloat top = 93 + (MACRO_IS_IPHONE_X ? 14 : 0);
    UITextField * moodField = [[UITextField alloc]initWithFrame:CGRectMake( 135 +(self.view.frame.size.width -135)/ 2, top, (self.view.frame.size.width -135)/ 2, 20)];
    moodField.font = [UIFont systemFontOfSize:16];
    moodField.placeholder = LocalString(@"mood");
    moodField.textAlignment = NSTextAlignmentCenter;
    moodField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.moodField = moodField;
    
    [self.view addSubview:moodField];

}



//取消按钮
-(void)backBtn
{
     CGFloat top = StatueBarHeight+10;
    UIButton * backBn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [backBn  setFrame:CGRectMake(5, top, 60, 30)];
    
    [backBn setTitle:LocalString(@"cancel") forState:UIControlStateNormal];
    
    backBn.tintColor = [UIColor whiteColor];
    
    backBn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    
    [backBn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:backBn];
}


//选择按钮
-(void)saveBtn
{
     CGFloat top = StatueBarHeight+10;
    UIButton * saveBn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [saveBn  setFrame:CGRectMake(self.view.frame.size.width - 65 , top, 60, 30)];
    
    [saveBn setTitle:LocalString(@"save") forState:UIControlStateNormal];
    
    saveBn.tintColor = [UIColor whiteColor];
    
    saveBn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    
    [saveBn addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:saveBn];

}



//取消保存
-(void)back:(id)sender
{
    
    [self.view endEditing:YES];
    
    self.diaryNote = nil;
    
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
    
}


//保存
-(void)save:(id)sender
{
    
    //标题不能空
    if ([self.titleField.text length] == 0)
    {
        [MBProgressHUD showError:LocalString(@"The title can not be blank")];
        
        return ;
    }

    
    //隐藏时间选择器
    [self.pickerView hiddenDatePickerView];
    [self.view endEditing:YES];
    
    
    self.diaryNote.title = self.titleField.text;
    self.diaryNote.content = self.detailView.text;
    self.diaryNote.weather = self.weatherField.text;
    self.diaryNote.mood = self.moodField.text;

    //插入到数据库中
    [self.diaryNote insertNote:self.diaryNote];
    
    //返回
    [self dismissViewControllerAnimated:YES completion:^{
        
        ;
    }];
    
}


//取消时间选择器
-(void)didCancelSelectDate
{
    self.dateLabel.text = self.originalDate;
}


//保存时间选择
-(void)didSaveDate
{
    self.dateLabel.text = [self.pickerView getNowDatePicker:@"MMdd HH:mm"];
    self.diaryNote.time = [self.pickerView getNowDatePicker:@"yyyyMMdd HH:mm"];

}


//改变时间选择
-(void)didDateChangeTo
{
    self.dateLabel.text = [self.pickerView getNowDatePicker:@"MMdd HH:mm"];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //隐藏键盘
    [self.view endEditing:YES];
    
    //隐藏时间选择器
    [self.pickerView hiddenDatePickerView];
}


//设置代理后，点击return，响应
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{

    return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];

    //隐藏时间选择器
    [self.pickerView hiddenDatePickerView];
    
}


@end
