/* eslint-disable prettier/prettier */
import { IsString, MinLength, IsNotEmpty } from 'class-validator';


export class createUserDto {

  @IsString()
  @MinLength(8,{message:"phone number length is less than 8!"})
  @IsNotEmpty({message:"phone is empty!"}) 
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

  @IsString()
  @IsNotEmpty({message:"gender is empty!"})
  gender
}