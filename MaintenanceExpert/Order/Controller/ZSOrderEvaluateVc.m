//
//  ZSOrderEvaluateVc.m
//  MaintenanceExpert
//
//  Created by xpc on 16/12/7.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "ZSOrderEvaluateVc.h"

@interface ZSOrderEvaluateVc ()<UITextViewDelegate>

{
    UIView *upView;
    UIView *midView;
    UIView *downView;
    
    ZSStarRatingView *tempStar;
    
    UILabel *nameLabel;
    UILabel *timeLabel;
    
    UILabel *firstScore;    //  分数Label
    UILabel *secondScore;    //  分数Label
    
    UITextView *appraisalTv;
    UILabel *appraisalLabel;
}

@end

@implementation ZSOrderEvaluateVc

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = ViewController_Back_Color;
    
    [self creatEvaluateBackView];
    [self creatUpView];
    [self creatMidView];
}


- (void)creatEvaluateBackView {    //   150 + KScreenHeight * 0.4 + 10
    
    upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 160)];
    upView.backgroundColor = ViewController_Back_Color;
    [self.view addSubview:upView];
    
    midView = [[UIView alloc] initWithFrame:CGRectMake(0, upView.origin.y + 170, KScreenWidth, KScreenHeight * 0.3)];
    midView.backgroundColor = ViewController_Back_Color;
    [self.view addSubview:midView];
    
    downView = [[UIView alloc] initWithFrame:CGRectMake(0, midView.origin.y + KScreenHeight * 0.3 + 10, KScreenWidth, KScreenHeight - 170 - KScreenHeight * 0.3 - 74)];
    downView.backgroundColor = ViewController_Back_Color;
    [self.view addSubview:downView];
}


- (void)creatUpView {
    
    UIImageView *headerImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, KScreenWidth/5, KScreenWidth/5)];
    headerImg.image = [UIImage imageNamed:@"defult_header_icon"];
    headerImg.layer.cornerRadius = headerImg.frame.size.width/2;
    [upView addSubview:headerImg];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(20 + KScreenWidth/5, 30, 70, 25)];
    name.text = @"运维人员";
    name.textColor = TextField_Text_Color;
    name.font = [UIFont systemFontOfSize:14];
    [upView addSubview:name];
    
    nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + KScreenWidth/5 + 75, 30, 180, 25)];
//    nameLabel.backgroundColor = [UIColor cyanColor];
    nameLabel.text = @"张工程师";
    nameLabel.textColor = Label_Color;
    nameLabel.font = [UIFont systemFontOfSize:15 weight:2];
    [upView addSubview:nameLabel];
    
    UILabel *time = [[UILabel alloc] initWithFrame:CGRectMake(20 + KScreenWidth/5, 30+30, 70, 25)];
//    time.backgroundColor = [UIColor cyanColor];
    time.text = @"服务时间";
    time.textColor = TextField_Text_Color;
    time.font = [UIFont systemFontOfSize:14];
    [upView addSubview:time];
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20 + KScreenWidth/5 + 75, 30+30, 180, 25)];
//    timeLabel.backgroundColor = [UIColor cyanColor];
    timeLabel.text = @"9:00-12:00";
    timeLabel.textColor = Label_Color;
    timeLabel.font = [UIFont systemFontOfSize:16];
    [upView addSubview:timeLabel];
    
    
    /**
     *  LineView
     */
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 30+30 +25 +20, KScreenWidth - 15, 1)];
    lineView.backgroundColor = Line_Color;
    [upView addSubview:lineView];
    
    //  服务态度 评价
    UILabel *manner = [[UILabel alloc] initWithFrame:CGRectMake(15, 30+30 +25 +20 +15, 70, 25)];
//    manner.backgroundColor = [UIColor cyanColor];
    manner.text = @"服务态度";
    manner.textColor = TextField_Text_Color;
    manner.font = [UIFont systemFontOfSize:14];
    [upView addSubview:manner];
    
    /**
     *  StarRating  manner
     *
     *  @return temp
     */
    
    tempStar = [[ZSStarRatingView alloc] init];
    //    firstTempStar.backgroundColor = [UIColor cyanColor];
    tempStar.tag = 1010;
    tempStar.imageWidth = 24.0;
    tempStar.imageHeight = 22.0;
    tempStar.imageCount = 5;
    tempStar.isNeedHalf = NO;
    tempStar.delegate = self;
    tempStar.frame = CGRectMake(15 +60 +15, 30+30 +25 +20 +15 +2, tempStar.imageWidth * 5, tempStar.imageHeight);
    [upView addSubview:tempStar];
    
    
    firstScore = [[UILabel alloc] initWithFrame:CGRectMake(tempStar.frame.origin.x +tempStar.frame.size.width +15, tempStar.frame.origin.y, 80, tempStar.imageHeight)];
    firstScore.text = @"请评分";
    firstScore.textColor = Label_Color;
    firstScore.font = [UIFont systemFontOfSize:14];
    [upView addSubview:firstScore];
    
}

- (void)creatMidView {
    
    //  运维服务 评价
    UILabel *condition = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 70, 25)];
//    condition.backgroundColor = [UIColor cyanColor];
    condition.text = @"运维服务";
    condition.textColor = TextField_Text_Color;
    condition.font = [UIFont systemFontOfSize:16];
    [midView addSubview:condition];
    
    /**
     *  StarRating  condition
     *
     *  @return temp
     */
    
    tempStar = [[ZSStarRatingView alloc] init];
    //    tempStar.backgroundColor = [UIColor cyanColor];
    tempStar.tag = 1011;
    tempStar.imageWidth = 24.0;
    tempStar.imageHeight = 22.0;
    tempStar.imageCount = 5;
    tempStar.isNeedHalf = NO;
    tempStar.delegate = self;
    tempStar.frame = CGRectMake(15 +60 +15, 15 +2, tempStar.imageWidth * 5, tempStar.imageHeight);
    [midView addSubview:tempStar];
    
    secondScore = [[UILabel alloc] initWithFrame:CGRectMake(tempStar.frame.origin.x +tempStar.frame.size.width +15, tempStar.frame.origin.y, 80, tempStar.imageHeight)];
    secondScore.text = @"请评分";
    secondScore.textColor = Label_Color;
    secondScore.font = [UIFont systemFontOfSize:14];
    [midView addSubview:secondScore];
    
    
    /**
     *  LineView
     */
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, 15 +25 +15, KScreenWidth - 15, 1)];
    lineView.backgroundColor = Line_Color;
    [midView addSubview:lineView];
    
    appraisalTv = [[UITextView alloc] initWithFrame:CGRectMake(15, 15 +25 +15 + 10, KScreenWidth - 30, midView.frame.size.height - 15 -25 -20 -10 -10)];
    appraisalTv.textColor = TextField_Text_Color;
    appraisalTv.backgroundColor = ViewController_Back_Color;
    appraisalTv.returnKeyType = UIReturnKeyDone;
    appraisalTv.delegate = self;
    appraisalTv.editable = YES;
    appraisalTv.layer.cornerRadius = 4.0f;
    appraisalTv.layer.borderColor = Label_Color.CGColor;
    appraisalTv.layer.borderWidth = 0.5;
    [appraisalTv setFont:[UIFont systemFontOfSize:15]];
    [midView addSubview:appraisalTv];
    
    appraisalLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 2, appraisalTv.frame.size.width -10, 30)];
    appraisalLabel.backgroundColor = ViewController_Back_Color;
    appraisalLabel.text = @"点评一下, 您的意见很重要";
    appraisalLabel.textColor = Placeholder_Color;
//    appraisalLabel.enabled = YES;
    appraisalLabel.font = [UIFont systemFontOfSize:15];
    [appraisalTv addSubview:appraisalLabel];
    
    
    /**
     *  提交按钮
     */
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15, downView.height/9, KScreenWidth - 30, 40)];
    
//    button.backgroundColor = [UIColor cyanColor];
    [button setBackgroundImage:[UIImage imageNamed:@"wancheng"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"wancheng-hov"] forState:UIControlStateSelected];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [downView addSubview:button];
    
}


- (void)mannerGrade:(NSString *)grade withView:(UIView *)selfView {
    
    NSLog(@"%ld",(long)tempStar.tag);
    if (selfView.tag == 1010) {
        firstScore.text = [NSString stringWithFormat:@"%@分",grade];
    }else if (selfView.tag == 1011) {
        secondScore.text = [NSString stringWithFormat:@"%@分",grade];
    }
    
    NSLog(@"%@--%@",firstScore.text,secondScore.text);
    NSLog(@"manner grade:%@",grade);
}

//- (void)conditionGrade:(NSString *)secondGrade {
//
//
//
//    NSLog(@"condition grade:%@",secondGrade);
//}


#pragma mark - 键盘响应
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [appraisalTv resignFirstResponder];
    
    [self.view endEditing:YES];
}

#pragma mark - UITextViewDelegate收回键盘
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark - UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView {
    
    if ([textView.text length] == 0) {
        [appraisalLabel setHidden:NO];
    }else {
        [appraisalLabel setHidden:YES];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
