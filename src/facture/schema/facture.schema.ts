/* eslint-disable prettier/prettier */
import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

//don't what it does souheil
export type FactureDocument = Facture & Document;


@Schema({timestamps:true})
export class Facture {
  @Prop({type:String,required:true,trime:true})
  numero: string;

  @Prop({type:String,required:true,trime:true})
  montant: string;

  @Prop({type:Boolean,required:true,default:false})
  payement: boolean;

  @Prop({type:String,required:true,trim:true})
  type: string;
}

export const FactureSchema = SchemaFactory.createForClass(Facture);