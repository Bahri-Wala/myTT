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

dotenv.config();
@Module({
  imports:[
    UserModule,
    MongooseModule.forFeature([{name:'User', schema:UserSchema}]),
    PassportModule.register({defaultStrategy:"jwt"}),
    JwtModule.register({secret:process.env.JWTSECRETKEY, signOptions:{expiresIn:3600}}),
  ],
  providers: [AuthService, JwtStrategy, ConfigService, RefreshTokenStrategy],
  controllers: [AuthController]
})
export class AuthModule {}
