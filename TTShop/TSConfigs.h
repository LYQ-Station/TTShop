//
//  TSConfigs.h
//  TTShop
//
//  Created by Steven Li on 11-12-16.
//  Copyright (c) 2011年 TTF Inc. All rights reserved.
//

#ifndef TTShop_TSConfigs_h
#define TTShop_TSConfigs_h

#pragma mark -

//当前版本
#define VERSION_STR                 @"1.0"

#pragma mark - 接口地址

//根地址
#define BASE_URL                    @"http://192.168.0.108"

//检测升级接口
#define URL_CHECK_NEW_VERSION       @"/ttpay/terminal/getEdition.php"

//软件包归属地来源接口
#define URL_GET_SOURCE              @"/ttpay/terminal/getSource.php"

//获取系统消息提醒接口
#define URL_SYS_MSG_COUNT           @"/ttpay/terminal/getRemind.php"

//意见反馈接口
#define URL_FEEDBACK                @"/ttpay/terminal/feedback.php"

//发送短信识别码接口
#define URL_SEND_SMS_CODE           @"/ttpay/terminal/sendSMSCode.php"

//获得手机充值相应的产品信息接口
#define URL_GET_PHONE_PRODUCT       @"/ttpay/terminal/getPhoneProduct.php"

//4.7短信重发接口接口：
//http://192.168.0.33:8080/ttpay/terminal/resend.php
//4.8交易记录查询接口：
//http://192.168.0.33:8080/ttpay/terminal/dealInfo.php
//4.9提交手机充值请求接口：
//http://192.168.0.33:8080/ttpay/terminal/submitMobileTopup.php  
//4.10提交获取游戏卡密接口：
//http://192.168.0.33:8080/ttpay/terminal/submitGameTopup.php  
//4.11 钱包支付接口
//http://192.168.0.33:8080/ttpay/terminal/terminalBursePay.php
//4.12充值卡支付接口
//http://192.168.0.33:8080/ttpay/terminal/terminalCardPay.php
//4. 13wap支付接口
//http://192.168.0.33:8080/ttpay/terminal/terminalWapPay.php
//4.14 查询钱包余额接口
//http://192.168.0.33:8080/ttpay/terminal/queryBurseBalance.php
//4.15 语音支付提交接口
//http://192.168.0.33:8080/ttpay/terminal/terminalSpeechPay.php
//4.16获取游戏点卡列表信息接口
//http://192.168.0.33:8080/ttpay/terminal/getGameProduct.php
//4.17校验验证码
//http://192.168.0.33:8080/ttpay/terminal/checkVerifyCode.php
//4.18提交转账信息
//http://192.168.0.33:8080/ttpay2/terminal/terminalShortCutPay.php
//4.19查询订单状态接口
//http://192.168.0.33:8080/ttpay2/terminal/queryOrderStatus.php
//4.20快捷支付接口
//http://192.168.1.66:8080/mobileClient/terminal/terminalShortCutPay.php
//4.21查询订单状态接口
//http://192.168.0.33:8080/ttpay2/terminal/queryOrderStatus.php
//3.22查询wap支付银行列表接口
//http://192.168.0.33:8080/ttpay2/terminal/loadWapBank.php
//4.9获取游戏支付金额（废弃）
//http://192.168.0.33:8080/ttpay2/terminal/getOrderMoneyByPayType.php
//4.10 获取手机充值费率接口(废弃)
//http://192.168.0.33:8080/ttpay2/terminal/getRateByMobile.php

#endif
