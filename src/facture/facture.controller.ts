/* eslint-disable prettier/prettier */
import { Body, Controller, Get, HttpStatus, Param, Patch, Post, Query, Req, Res, UseGuards } from '@nestjs/common';
import { response,Request } from 'express';
import { JwtAuthGuard } from 'src/auth/guard/jwt-auth.guard';
import { FactureService } from './facture.service';
import { Facture } from './schema/facture.schema';

@Controller('facture')
@UseGuards(JwtAuthGuard)
export class FactureController {
    constructor(private factureService: FactureService){}
    
    @Post()
    async add(@Body() facture: Facture, @Res() response){
        try{
            const fact = await this.factureService.add(facture);
            return response.status(HttpStatus.CREATED).json(fact) ;
        }catch(e){
            console.log(e);
        }
    }

    @Get("all")
    async getAll(@Res() response){
        try{
            const factures = await this.factureService.getAll();
            return response.status(HttpStatus.CREATED).json(factures) ;
        }catch(e){
            console.log(e);
        }
    }

    @Get()
    async get(@Res() response, @Body() data: Partial<Facture>){
        try{
            const factures = await this.factureService.get(data);
            return response.status(HttpStatus.CREATED).json(factures) ;
        }catch(e){
            console.log(e);
        }
    }

    @Get("search")
    async search(@Query("filter") filter, @Res() response){
        try{
            const factures = await this.factureService.search(filter);
            return response.status(HttpStatus.CREATED).json(factures);
        }catch(e){
            console.log(e);
        }
    }

    @Get(":id")
    async getById(@Res() response, @Param("id") id){
        try{
            const facture = await this.factureService.getById(id);
            return response.status(HttpStatus.CREATED).json(facture) ;
        }catch(e){
            console.log(e);
        }
    }

    @Patch("pay/:id")
    async pay(@Param("id") id, @Res() response){
        try{
            const paid = await this.factureService.pay(id);
            return response.status(HttpStatus.CREATED).json(paid);
        }catch(e){
            console.log(e)
        }
    }

    @Post("filter")
    async filter(@Req() req: Request, @Body() data:Partial<Facture>,@Res() response){
        try{
            data["owner"] = req.user["id"];
            const factures = await this.factureService.filter(data);
            return response.status(HttpStatus.CREATED).json(factures);
        }catch(e){
        console.log(e);
        }
    }

}
