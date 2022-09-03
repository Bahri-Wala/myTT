/* eslint-disable prettier/prettier */
import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ConfigModule } from '@nestjs/config';
import { AuthModule } from './auth/auth.module';
import { UserModule } from './user/user.module';
import { MongooseModule } from '@nestjs/mongoose';
import * as Joi from '@hapi/joi';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal:true,
      validationSchema: Joi.object({
        TWILIO_ACCOUNT_SID: Joi.string().required(),
        TWILIO_AUTH_TOKEN: Joi.string().required(),
        TWILIO_VERIFICATION_SERVICE_SID: Joi.string().required(),
        TWILIO_SENDER_PHONE_NUMBER: Joi.string().required(),
      })
    }), 
    MongooseModule.forRoot(process.env.MONGODB),
    AuthModule, 
    UserModule
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
