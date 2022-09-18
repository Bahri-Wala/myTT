/* eslint-disable prettier/prettier */
import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Facture, FactureDocument } from './schema/facture.schema';

@Injectable()
export class FactureService {
    constructor(@InjectModel(Facture.name) private factureModel: Model<FactureDocument>) {}

    async add(facture){
        return await new this.factureModel(facture).save();
    }

    async getAll(){
        return this.factureModel.find();
    }

    async get(data){
        return this.factureModel.find(data);
    }

    async getById(id){
        return this.factureModel.findById(id);
    }

    async pay(id){
        return this.factureModel.findByIdAndUpdate(id,{payement:true},{new:true});
    }

    async search(filter){
        return await this.factureModel.find( {"$or": [{"numero": {"$regex" : filter, "$options": "i"}},{"type": {"$regex" : filter, "$options": "i"}}]},null,{sort:{createdAt:-1}});
    }

    async filter(data){
        const conditions = [];
        if(data.search){
            conditions.push({"$or": [{"numero": {"$regex" : data.search, "$options": "i"}},{"type": {"$regex" : data.search, "$options": "i"}}]})
        }
        if(data.type){
            conditions.push({"type":data.type});
        }
        if(data.payement != null){
            conditions.push({"payement":data.payement});
        }
        if(data.startDate){
            conditions.push({"createdAt":{"$gte": data.startDate}});
        }
        if(data.endDate){
            conditions.push({"createdAt":{"$lte": data.endDate}});
        }
        if(conditions.length > 0)
            return await this.factureModel.find({"$and":conditions},null,{sort:{createdAt:-1}});
        else return await this.factureModel.find();
    }
}
