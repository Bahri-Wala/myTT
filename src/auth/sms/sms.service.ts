/* eslint-disable prettier/prettier */
import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Sms, SmsDocument } from './sms.schema';

 
@Injectable()
export default class SmsService {
  
  constructor(@InjectModel(Sms.name) private smsModel: Model<SmsDocument>) {}

  generateCode(){
    let code="";
    for(let i=0;i<6;i++){
        code = code + Math.floor(Math.random()*10);
    }
    return code;
  }  
  
  async create(sms:Sms){
    return this.smsModel.create(sms)
  }
  

  async findOne(phone:string){
    return this.smsModel.findOne({phone});
  }

  async delete(phone:string){
    return this.smsModel.remove({phone});
  }

}