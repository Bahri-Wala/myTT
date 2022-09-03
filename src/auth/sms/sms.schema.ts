/* eslint-disable prettier/prettier */
import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

//don't what it does souheil
export type SmsDocument = Sms & Document;


@Schema({timestamps:true})
export class Sms {

  @Prop({type:String,required:true,unique:true,trime:true})
  phone: string;

  @Prop({type:String,required:true,unique:true,trime:true})
  code: string;



}

export const SmsSchema = SchemaFactory.createForClass(Sms);
SmsSchema.index({"createdAt":1},{expires:"2m"})