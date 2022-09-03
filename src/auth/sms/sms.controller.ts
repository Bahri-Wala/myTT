/* eslint-disable prettier/prettier */
import {
    Controller,
    UseGuards,
    UseInterceptors,
    ClassSerializerInterceptor, Post, Req, BadRequestException, Body,
  } from '@nestjs/common';
  import SmsService from './sms.service';
  import { JwtAuthGuard } from '../guard/jwt-auth.guard';
import { Request } from 'express';
import { CreateUserDto } from '../dto/create-user.dto';
   
@Controller("sms")
@UseInterceptors(ClassSerializerInterceptor)
export default class SmsController {
    constructor(
        private readonly smsService: SmsService
    ) {}

    // @Post('send-code')
    // async sendVerificationCode(@Req() request: Request) {
    //     if (request.body["active"]) {
    //     throw new BadRequestException('Phone number already confirmed');
    //     }
    //     await this.smsService.initiatePhoneNumberVerification(request.body["phone"]);
    // }

    // @Post('check-verification-code')
    // //@UseGuards(JwtAuthenticationGuard)
    // async checkVerificationCode(@Req() request: Request, @Body() verificationData: any) {
    //     if (request.body["active"]) {
    //     throw new BadRequestException('Phone number already confirmed');
    //     }
    //     await this.smsService.confirmPhoneNumber(request.body["_id"], request.body["phone"], verificationData.code);
    // }

}