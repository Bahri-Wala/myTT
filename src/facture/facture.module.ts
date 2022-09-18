/* eslint-disable prettier/prettier */
import { Module } from '@nestjs/common';
import { FactureService } from './facture.service';
import { FactureController } from './facture.controller';
import { MongooseModule } from '@nestjs/mongoose';
import { Facture, FactureSchema } from './schema/facture.schema';

@Module({
  providers: [FactureService],
  imports:[MongooseModule.forFeature([{name: Facture.name, schema: FactureSchema}])], 
  controllers: [FactureController]
})
export class FactureModule {}
