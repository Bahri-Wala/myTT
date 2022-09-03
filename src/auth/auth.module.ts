/* eslint-disable prettier/prettier */
import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { UserSchema } from 'src/user/schemas/user.schema';
import { PassportModule } from '@nestjs/passport';
import { JwtModule } from '@nestjs/jwt';
import * as dotenv from "dotenv";
import { JwtStrategy } from './strategy/passport-jwt.strategy';
import { ConfigService } from '@nestjs/config';
import { UserModule } from 'src/user/user.module';
import { RefreshTokenStrategy } from './strategy/refreshToken.strategy';
import SmsController from './sms/sms.controller';
import SmsService from './sms/sms.service';
import { SmsSchema } from './sms/sms.schema';

dotenv.config();
@Module({
  imports:[
    UserModule,
    MongooseModule.forFeature([{name:'User', schema:UserSchema},{name:'Sms', schema:SmsSchema}]),
    PassportModule.register({defaultStrategy:"jwt"}),
    JwtModule.register({secret:process.env.JWTSECRETKEY, signOptions:{expiresIn:3600}}),
  ],
  providers: [AuthService, JwtStrategy, ConfigService, RefreshTokenStrategy,SmsService],
  controllers: [AuthController,SmsController]
})
export class AuthModule {}
