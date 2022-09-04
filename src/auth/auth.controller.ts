/* eslint-disable prettier/prettier */
import { BadRequestException, Body, Controller, Get, HttpStatus, Post, Req, Res, UseGuards } from '@nestjs/common';
import { Request } from 'express';
import { AuthService } from './auth.service';
import { AuthDto } from './dto/auth.dto';
import { CreateUserDto } from './dto/create-user.dto';
import { JwtAuthGuard } from './guard/jwt-auth.guard';
import { RefreshTokenGuard } from './guard/refreshToken.guard';
import { UserService } from 'src/user/user.service';
import SmsService from './sms/sms.service';
import { Sms } from './sms/sms.schema';

@Controller()
export class AuthController {
    constructor(
        private authService: AuthService, 
        private userService:UserService,
        private smsService: SmsService
    ){}

    @Post("login")
    async login(@Body() user:AuthDto, @Res() response){
        const newUser = await this.authService.login(user);
        return response.status(HttpStatus.CREATED).json(newUser) ;
    }

    @Post("register")
    async register(@Body() user:CreateUserDto, @Res() response){
        try{
            const newUser = await this.authService.register(user) ;
            return response.status(HttpStatus.CREATED).json(newUser) ;
        }catch(e){
            return response.status(HttpStatus.BAD_REQUEST).send(e)
        }  
    }

    @UseGuards(JwtAuthGuard)
    @Get("logout")
    logout(@Req() req: Request){
        this.authService.logout(req.user["id"])
    }

    @UseGuards(RefreshTokenGuard)
    @Get("refresh-token")
    refreshTokens(@Req() req: Request) {
    const userId = req.user['id'];
    const refreshToken = req.user['refreshToken'];
    return this.authService.refreshTokens(userId, refreshToken);
    }

    @Post('send-code')
    async sendVerificationCode(@Body() data, @Res() response) {
        if(await this.userService.findOne({phone:data.phone})){
            throw new BadRequestException('Phone number already used');}
        const code = this.smsService.generateCode();
        const sms = {phone:data.phone,code:code}
        try{
            await this.smsService.create(sms)
            await this.authService.sendActivationCode(sms);
            return response.status(HttpStatus.CREATED).json(sms) ;
        }catch(e){
            return response.status(HttpStatus.BAD_REQUEST).send(e)
        }
    }

    @Post('verify-code')
    async verifyCode(@Body() data:Partial<Sms>, @Res() response){
        const sms = await this.smsService.findOne(data.phone);
        console.log(sms);
        if(!sms)
            throw new BadRequestException('code has expired! please try again');
        if(sms.code == data.code){
            await this.smsService.delete(data.phone);
            return response.status(HttpStatus.CREATED).json(sms) ;
        } else
            throw new BadRequestException("code doesn't match");
    }
}
