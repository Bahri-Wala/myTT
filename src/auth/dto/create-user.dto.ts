/* eslint-disable prettier/prettier */
import { Transform } from 'class-transformer';
import { IsString, MinLength, IsNotEmpty, Matches, IsBoolean } from 'class-validator';
import { defaultIfEmpty } from 'rxjs';


export class CreateUserDto {

  @IsString()
  @MinLength(8,{message:"phone number length is less than 8!"})
  @IsNotEmpty({message:"phone is empty!"}) 
  @Matches(/^[259]\d{7}$/)
  phone: string;

  @IsNotEmpty({message:"Pasword is empty!"})
  @MinLength(4,{message:"password length is less than 4!"})
  @IsString()
  password: string;

  @IsNotEmpty({message:"firstName is empty!"})
  @IsString()
  firstName: string;

  @IsNotEmpty({message:"lastName is empty!"})
  @IsString()
  lastName: string;

}