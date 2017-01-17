//
//  OrderScrollView.m
//  fengzhuangbiaoge
//
//  Created by koka on 16/12/21.
//  Copyright © 2016年 ZSYW. All rights reserved.
//

#import "OrderScrollView.h"
#import "WeixiuxitongSeclectView.h"
#import "TimeTextField.h"
#import "GuzhangdianSeclectView.h"
#import "HighWorkSelectView.h"
#import "jiaoxianSeclectView.h"
#import "ServiceKindTextField.h"
#import "PowerTextField.h"
#import "NormalTextField.h"
#import "UPSKindSeclectView.h"
#import "UPSNumSeclectView.h"
#import "UPSPowerSeclectView.h"
#import "DianchiZhujiLineSelectView.h"


#define KScreenWidth [UIScreen mainScreen].bounds.size.width
#define KScreenHeight [UIScreen mainScreen].bounds.size.height

@implementation OrderScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor cyanColor];
        self.showsHorizontalScrollIndicator = YES;
        self.showsVerticalScrollIndicator = YES;
        [self createUI];
        index = 0;
    }
    return self;
}

- (void)createUI {
    
    NSMutableArray *array = [NSMutableArray array];
    if ([ZSDetailOrderModel shareDetailOrder].KindIndex == 0) {
        array = [[NSMutableArray alloc]initWithObjects:@"维修系统",@"维修时间",@"故障点",@"是否高空作业",@"郊县", nil];
    }else{
        array =[[NSMutableArray alloc]initWithObjects:@"服务类型",@"服务时间",@"UPS类型",@"功率",@"主机品牌",@"UPS主机台数",@"电池组",@"UPS功率",@"电池主机间连线",@"是否郊县", nil];
    }
    for (int i = 0; i < array.count; i++) {
        if ([array[i] isEqualToString:@"维修系统"]) {
            [self weixiuxitong];
            index++;
            index++;
        }else if ([array[i] isEqualToString:@"维修时间"]) {
            [self weixiushijian];
            index++;
        }else if ([array[i] isEqualToString:@"故障点"]) {
            [self guzhangdian];
            index++;
            index++;
        }else if ([array[i] isEqualToString:@"是否高空作业"]) {
            [self highwork];
            index++;
        }else if ([array[i] isEqualToString:@"郊县"]) {
            [self jiaoxian];
            index++;
        }else if ([array[i] isEqualToString:@"服务类型"]) {
            [self servicekind];
            index++;
        }else if ([array[i] isEqualToString:@"服务时间"]) {
            [self weixiushijian];
            index++;
        }else if ([array[i] isEqualToString:@"UPS类型"]) {
            [self UPSKind];
            index++;
        }else if ([array[i] isEqualToString:@"功率"]) {
            [self power];
            index++;
        }else if ([array[i] isEqualToString:@"主机品牌"]) {
            [self Normalzhuji];
            index++;
        }else if ([array[i] isEqualToString:@"UPS主机台数"]) {
            [self UPSNum];
            index++;
        }else if ([array[i] isEqualToString:@"电池组"]) {
            [self Normaldianchizu];
            index++;
        }else if ([array[i] isEqualToString:@"UPS功率"]) {
            [self UPSPower];
            index++;
        }else if ([array[i] isEqualToString:@"电池主机间连线"]) {
            [self DianchiLine];
            index++;
        }
    }
    [ZSDetailOrderModel shareDetailOrder].index = index;
}


//维修系统
- (void)weixiuxitong {
    NSArray *kindArr = [[NSArray alloc]initWithObjects:@"闭路监控",@"防盗报警",@"停车场",@"电子巡更",@"防爆安检",@"广播",@"门禁一卡通", nil];
    
    WeixiuxitongSeclectView *weixiu = [[WeixiuxitongSeclectView alloc]initWithFrame:CGRectMake(KScreenWidth/3, index*60, KScreenWidth *2/3 - 30, 120) titles:kindArr column:2];
    [self addSubview:weixiu];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, index*60, KScreenWidth/3-10, 120)];
    label.text = @"维修系统:";
    label.textAlignment = NSTextAlignmentRight;
    [self addSubview:label];
    
    LineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, index*60+109, KScreenWidth - 20, 1)];
    [self addSubview:LineImage];
    
    label.textColor = Label_Color;
    LineImage.backgroundColor = Line_Color;
    
}
//时间
- (void)weixiushijian {
    TimeTextField *time = [[TimeTextField alloc]initWithFrame:CGRectMake(KScreenWidth/3, index*60, KScreenWidth *2/3 - 30, 40)];
    [self addSubview:time];
    time.textColor = TextField_Text_Color;
    NSString *messageStr = @"请输入时间";
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc]initWithString:messageStr];
    [placeholderString addAttribute:NSForegroundColorAttributeName
                              value:Placeholder_Color
                              range:NSMakeRange(0, messageStr.length)];
    time.attributedPlaceholder = placeholderString;
   
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, index*60, KScreenWidth/3-10, 40)];
    label.text = @"维修时间:";
    label.textAlignment = NSTextAlignmentRight;
    [self addSubview:label];
    
    LineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, index*60+39, KScreenWidth - 20, 1)];
    [self addSubview:LineImage];
    
    label.textColor = Label_Color;
    LineImage.backgroundColor = Line_Color;
}
//故障点
- (void)guzhangdian {
    NSArray *kindArr = [[NSArray alloc]initWithObjects:@"1-3",@"4-6",@"7-9",@"10-12",@"> 12", nil];
    // 自动计算view的高度
    GuzhangdianSeclectView *btnView = [[GuzhangdianSeclectView alloc] initWithFrame:CGRectMake(KScreenWidth/3, index*60, KScreenWidth *2/3 - 30, 60)                                                               titles:kindArr column:2];
    [self addSubview:btnView];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, index*60, KScreenWidth/3-10, 60)];
    label.text = @"故障点:";
    label.textAlignment = NSTextAlignmentRight;
    [self addSubview:label];
    
    LineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, index*60+89, KScreenWidth - 20, 1)];
    [self addSubview:LineImage];
    
    label.textColor = Label_Color;
    LineImage.backgroundColor = Line_Color;
    
}
//高空作业
- (void)highwork {
    NSArray *kindArr = [[NSArray alloc]initWithObjects:@"是",@"否", nil];
    // 自动计算view的高度
    HighWorkSelectView *btnView = [[HighWorkSelectView alloc] initWithFrame:CGRectMake(KScreenWidth/3 ,index*60-20,KScreenWidth *2/3 - 30,40)
                                                                     titles:kindArr column:2];
    [self addSubview:btnView];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, index*60-20, KScreenWidth/3-10, 40)];
    label.text = @"是否高空作业:";
    label.textAlignment = NSTextAlignmentRight;
    [self addSubview:label];
    
    LineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, index*60+19, KScreenWidth - 20, 1)];
    [self addSubview:LineImage];
    
    label.textColor = Label_Color;
    LineImage.backgroundColor = Line_Color;
    
}
//郊县
- (void)jiaoxian {
    NSArray *kindArr = [[NSArray alloc]initWithObjects:@"是",@"否", nil];
    // 自动计算view的高度
    jiaoxianSeclectView *btnView = [[jiaoxianSeclectView alloc] initWithFrame:CGRectMake(KScreenWidth/3 ,index*60-20,KScreenWidth *2/3 - 30,60)
                                                                       titles:kindArr column:2];
    [self addSubview:btnView];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, index*60-20, KScreenWidth/3-10, 40)];
    label.text = @"是否郊县:";
    label.textAlignment = NSTextAlignmentRight;
    [self addSubview:label];
    
    LineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, index*60+19, KScreenWidth - 20, 1)];
    [self addSubview:LineImage];
    
    label.textColor = Label_Color;
    LineImage.backgroundColor = Line_Color;
}
//服务类型
- (void)servicekind {
    ServiceKindTextField *service = [[ServiceKindTextField alloc]initWithFrame:CGRectMake(KScreenWidth/3, index*60, KScreenWidth *2/3 - 30, 60)];
    [self addSubview:service];
    service.textColor = TextField_Text_Color;
    NSString *messageStr = @"请选择种类";
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc]initWithString:messageStr];
    [placeholderString addAttribute:NSForegroundColorAttributeName
                              value:Placeholder_Color
                              range:NSMakeRange(0, messageStr.length)];
    service.attributedPlaceholder = placeholderString;

    label = [[UILabel alloc]initWithFrame:CGRectMake(0, index*60, KScreenWidth/3-10, 60)];
    label.text = @"服务类型:";
    label.textAlignment = NSTextAlignmentRight;
    [self addSubview:label];
    
    LineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, index*60+49, KScreenWidth - 20, 1)];
    [self addSubview:LineImage];
    
    label.textColor = Label_Color;
    LineImage.backgroundColor = Line_Color;
}
//功率
- (void)power {
    PowerTextField *power = [[PowerTextField alloc]initWithFrame:CGRectMake(KScreenWidth/3, index*60, KScreenWidth *2/3 - 30, 40)];
    [self addSubview:power];
    power.textColor = TextField_Text_Color;
    NSString *messageStr = @"请选择功率";
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc]initWithString:messageStr];
    [placeholderString addAttribute:NSForegroundColorAttributeName
                              value:Placeholder_Color
                              range:NSMakeRange(0, messageStr.length)];
    power.attributedPlaceholder = placeholderString;

    label = [[UILabel alloc]initWithFrame:CGRectMake(0, index*60, KScreenWidth/3-10, 40)];
    label.text = @"功    率:";
    label.textAlignment = NSTextAlignmentRight;
    [self addSubview:label];
    
    LineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, index*60+39, KScreenWidth - 20, 1)];
    [self addSubview:LineImage];
    
    label.textColor = Label_Color;
    LineImage.backgroundColor = Line_Color;
}
//普通（主机品牌，电池组）
- (void)Normalzhuji {
    NormalTextField *normal = [[NormalTextField alloc]initWithFrame:CGRectMake(KScreenWidth/3, index*60, KScreenWidth * 2/3 - 30, 44)];
    [self addSubview:normal];
    normal.textColor = TextField_Text_Color;
    NSString *messageStr = @"请输入主机品牌";
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc]initWithString:messageStr];
    [placeholderString addAttribute:NSForegroundColorAttributeName
                              value:Placeholder_Color
                              range:NSMakeRange(0, messageStr.length)];
    normal.attributedPlaceholder = placeholderString;

    label = [[UILabel alloc]initWithFrame:CGRectMake(0, index*60, KScreenWidth/3-10, 44)];
    label.text = @"主机品牌:";
    label.textAlignment = NSTextAlignmentRight;
    [self addSubview:label];
    
    LineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, index*60+39, KScreenWidth - 20, 1)];
    [self addSubview:LineImage];
    
    label.textColor = Label_Color;
    LineImage.backgroundColor = Line_Color;
}
- (void)Normaldianchizu {
    NormalTextField *normal = [[NormalTextField alloc]initWithFrame:CGRectMake(KScreenWidth/3, index*60, KScreenWidth * 2/3 - 30, 44)];
    [self addSubview:normal];
    normal.textColor = TextField_Text_Color;
    NSString *messageStr = @"请输入电池数量";
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc]initWithString:messageStr];
    [placeholderString addAttribute:NSForegroundColorAttributeName
                              value:Placeholder_Color
                              range:NSMakeRange(0, messageStr.length)];
    normal.attributedPlaceholder = placeholderString;
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, index*60, KScreenWidth/3-10, 44)];
    label.text = @"电池组数量:";
    label.textAlignment = NSTextAlignmentRight;
    [self addSubview:label];
    
    LineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, index*60+39, KScreenWidth - 20, 1)];
    [self addSubview:LineImage];
    
    label.textColor = Label_Color;
    LineImage.backgroundColor = Line_Color;
}
//UPS类型
- (void)UPSKind {
    NSArray *kindArr = [[NSArray alloc]initWithObjects:@"单相",@"三相", nil];
    // 自动计算view的高度
    UPSKindSeclectView *btnView = [[UPSKindSeclectView alloc] initWithFrame:CGRectMake(KScreenWidth/3 ,index*60+3 ,KScreenWidth *2/3 - 30,0)
                                                                     titles:kindArr column:2];
    [self addSubview:btnView];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, index*60, KScreenWidth/3-10, 40)];
    label.text = @"UPS类型:";
    label.textAlignment = NSTextAlignmentRight;
    [self addSubview:label];
    
    LineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, index*60+39, KScreenWidth - 20, 1)];
    [self addSubview:LineImage];
    
    label.textColor = Label_Color;
    LineImage.backgroundColor = Line_Color;
}
//电池主机间连线
- (void)DianchiLine {
    NSArray *kindArr = [[NSArray alloc]initWithObjects:@"需要",@"不需要", nil];
    // 自动计算view的高度
    DianchiZhujiLineSelectView *btnView = [[DianchiZhujiLineSelectView alloc] initWithFrame:CGRectMake(KScreenWidth/3 ,index*60+10,KScreenWidth *2/3-20,0)
                                                                                     titles:kindArr column:2];
    [self addSubview:btnView];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, index*60, KScreenWidth/3-10, 60)];
    label.text = @"电池主机连线:";
    label.textAlignment = NSTextAlignmentRight;
    [self addSubview:label];
    
    LineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, index*60+59, KScreenWidth - 20, 1)];
    [self addSubview:LineImage];
    
    label.textColor = Label_Color;
    LineImage.backgroundColor = Line_Color;
    
}
//UPS功率
- (void)UPSPower {
    NSArray *kindArr = [[NSArray alloc]initWithObjects:@"120A/H以下",@"150A/H以上", nil];
    // 自动计算view的高度
    UPSPowerSeclectView *btnView = [[UPSPowerSeclectView alloc] initWithFrame:CGRectMake(KScreenWidth/3 ,index*60,KScreenWidth *2/3 - 30,0)
                                                                       titles:kindArr column:1];
    [self addSubview:btnView];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, index*60, KScreenWidth/3-10, 60)];
    label.text = @"UPS功率:";
    label.textAlignment = NSTextAlignmentRight;
    [self addSubview:label];
    
    LineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, index*60+59, KScreenWidth - 20, 1)];
    [self addSubview:LineImage];
    
    label.textColor = Label_Color;
    LineImage.backgroundColor = Line_Color;
}
//UPS主机台数
- (void)UPSNum {
    NSArray *kindArr = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6", nil];
    // 自动计算view的高度
    UPSNumSeclectView *btnView = [[UPSNumSeclectView alloc] initWithFrame:CGRectMake(KScreenWidth/3 ,index*60,KScreenWidth *2/3 - 30,0)
                                                                   titles:kindArr column:3];
    [self addSubview:btnView];
    
    label = [[UILabel alloc]initWithFrame:CGRectMake(0, index*60, KScreenWidth/3-10, 60)];
    label.text = @"UPS主机台数:";
    label.textAlignment = NSTextAlignmentRight;
    [self addSubview:label];
    
    LineImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, index*60+59, KScreenWidth - 20, 1)];
    [self addSubview:LineImage];
    
    label.textColor = Label_Color;
    LineImage.backgroundColor = Line_Color;
    
}

@end
