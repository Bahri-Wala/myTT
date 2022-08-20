/* eslint-disable prettier/prettier */
import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Exclude } from 'class-transformer';
import { Document } from 'mongoose';

//don't what it does souheil
export type UserDocument = User & Document;


@Schema({timestamps:true})
export class User {
  @Prop({type:String,required:true,unique:true,trime:true})
  phone: string;

  @Exclude()
  @Prop({type:String,required:true,trime:true})
  password: string;

  @Prop({type:String,required:true,trim:true})
  firstName: string;

  @Prop({type:String,required:true,trim:true})
  lastName: string;

  @Prop({type:String,required:true,trim:true})
  gender

  @Prop({type:Boolean,default:false})
  active ;

  @Exclude()
  @Prop({type:String})
  salt ; 

  @Prop()
  refreshToken: string;
}

export const UserSchema = SchemaFactory.createForClass(User);