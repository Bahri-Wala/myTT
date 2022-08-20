/* eslint-disable prettier/prettier */
import { Body, Controller, Get, HttpStatus, Post, Req, Res, UseGuards } from '@nestjs/common';
import { Request } from 'express';
import { AuthService } from './auth.service';
import { AuthDto } from './dto/auth.dto';
import { createUserDto } from './dto/create-user.dto';
import { JwtAuthGuard } from './guard/jwt-auth.guard';
import { RefreshTokenGuard } from './guard/refreshToken.guard';

@Controller()
export class AuthController {
    constructor(private authService: AuthService){}

    @Post("login")
    async login(@Body() user:AuthDto, @Res() response){
        const newUser = await this.authService.login(user);
        return response.status(HttpStatus.CREATED).json(newUser) ;
    }

    @Post("register")
    async register(@Body() user:createUserDto, @Res() response){
        try{
            const newUser = await this.authService.register(user) ;
            return response.status(HttpStatus.CREATED).json(newUser) ;
        }catch(e){
            return response.status(HttpStatus.BAD_REQUEST).send(e)
        }  
    }

    //@UseGuards(JwtAuthGuard)
    @Get("logout")
    logout(@Req() req: Request){
        this.authService.logout(req.body["id"])
    }

    @UseGuards(RefreshTokenGuard)
    @Get("refresh_token")
    refreshTokens(@Req() req: Request) {
    const userId = req.body['id'];
    const refreshToken = req.body['refreshToken'];
    return this.authService.refreshTokens(userId, refreshToken);
    }
}
