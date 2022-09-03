/* eslint-disable prettier/prettier */
import { IsNotEmpty, IsString } from "class-validator";


export class AuthDto{
    @IsNotEmpty({message: "phone is missing"})
    @IsString()
    phone: string;

    @IsNotEmpty({message: "password is missing"})
    @IsString()
    password: string;
}