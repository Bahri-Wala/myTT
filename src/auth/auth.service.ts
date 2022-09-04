/* eslint-disable prettier/prettier */
import { Body, ForbiddenException, Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import * as bcrypt from 'bcrypt';
import * as argon2 from 'argon2';
import { User, UserDocument } from 'src/user/schemas/user.schema';
import { AuthDto } from './dto/auth.dto';
import { CreateUserDto } from './dto/create-user.dto';
import { UserService } from 'src/user/user.service';
import { ConfigService } from '@nestjs/config';
import { Twilio } from 'twilio';
import { Sms, SmsDocument } from './sms/sms.schema';

@Injectable()
export class AuthService {
  private twilioClient: Twilio;

  constructor(
      @InjectModel(User.name) private userModel: Model<UserDocument>,
      @InjectModel(Sms.name) private smsModel: Model<SmsDocument>,
      private jwtService: JwtService,
      private userService:UserService,
      private readonly configService: ConfigService,
  ){
    const accountSid = configService.get('TWILIO_ACCOUNT_SID');
    const authToken = configService.get('TWILIO_AUTH_TOKEN');
 
    this.twilioClient = new Twilio(accountSid, authToken);
  }

  async genToken(user: User){
      const bdUser = await this.userModel.findOne({email:user.phone});
      const payload = {id:bdUser._id,phone:user.phone, firstName:user.firstName};
      const accessToken = await this.jwtService.sign(payload,{secret: process.env.JWTSECRETKEY, expiresIn: '3m'});
      const refreshToken = await this.jwtService.sign(payload,{secret: process.env.REFRESHSECRETKEY, expiresIn: '7d'});
      return [accessToken, refreshToken];

    }

  async login(@Body() userData:AuthDto){
      const user = await this.userModel.findOne({phone:userData.phone})
      if (!user) throw new UnauthorizedException('Wrong credentials!');
      const isMatch = await bcrypt.compare(userData.password,user.password)
      if(isMatch){
        const [jwt,refreshToken] = await this.genToken(user);
        user.password = undefined;
        user.salt = undefined;
        await this.updateRefreshToken(user.id, user.firstName);
        return {"user":user,"access_token":jwt, "refresh_token":refreshToken};
      }else{
        throw new UnauthorizedException('Wrong credentials!');
      }
  }

  async register(@Body() user:CreateUserDto){
      const newUser = new this.userModel(user);
      const alreadyUser = await this.userModel.findOne({phone:user.phone});
      if(alreadyUser) throw new UnauthorizedException('User already registered!');
      newUser.salt = await bcrypt.genSalt();
      newUser.password = await bcrypt.hash(newUser.password, newUser.salt);
      await newUser.save();
      newUser.password = undefined;
      newUser.salt = undefined;
      return newUser;
  }

  async updateRefreshToken(userId: string, refreshToken: string) {
    const hashedToken = await argon2.hash(refreshToken);
    await this.userService.update(userId, {refreshToken: hashedToken});
  }

  async logout(id: string){
    return this.userService.update(id, {refreshToken:null});
  }

  async refreshTokens(userId: string, refreshToken: string) {
    const user = await this.userService.findById(userId);
    if (!user || !user.refreshToken)
      throw new ForbiddenException('Access Denied');
    const refreshTokenMatches = argon2.verify(
      user.refreshToken,
      refreshToken,
    );
    if (!refreshTokenMatches) throw new ForbiddenException('Access Denied');
    const [access_token, refresh_token] = await this.genToken(user);
    await this.updateRefreshToken(user.id, refresh_token);
    return {access_token, refresh_token};
  }

  async activateAccount(userId: number) {
    return this.userModel.findByIdAndUpdate({ id: userId }, {active: true });
  }

  async sendActivationCode(sms:Sms){
    const senderPhoneNumber = this.configService.get('TWILIO_SENDER_PHONE_NUMBER');
    const message ="\nVotre code d'activation est "+sms.code;
    return this.twilioClient.messages.create({ body: message, from: senderPhoneNumber, to: "+216"+sms.phone });
  }

}

