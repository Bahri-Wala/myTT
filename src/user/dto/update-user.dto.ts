/* eslint-disable prettier/prettier */
import { IsString, IsNotEmpty } from 'class-validator';


export class UpdateUserDto {
  @IsNotEmpty({message:"firstName is empty!"})
  @IsString()
  firstName: string;

  @IsNotEmpty({message:"lastName is empty!"})
  @IsString()
  lastName: string;

  @IsString()
  refreshToken: string;
}