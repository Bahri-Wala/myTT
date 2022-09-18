/* eslint-disable prettier/prettier */
import { Injectable } from '@nestjs/common';
import { InjectModel } from "@nestjs/mongoose";
import { Model } from "mongoose";
import { User, UserDocument } from "./schemas/user.schema";

@Injectable()
export class UserService{
  constructor(@InjectModel(User.name) private userModel: Model<UserDocument>) {}

  async findAll(){
    return this.userModel.find();
  }

  async find(condition:Partial<User>){
    return this.userModel.find(condition);
  }

  async findOne(condition:Partial<User>){
    return this.userModel.findOne(condition);
  }

  async findById(id: string){
    return this.userModel.findById(id);
  }

  async update(id: string, user: Partial<User>): Promise<User> {
    const updatedUser = await this.userModel.findByIdAndUpdate(id, user, {new:true});
    updatedUser.password = undefined;
    updatedUser.salt = undefined;
    return updatedUser;
  }

  async updatePassword(user: Partial<User>): Promise<User>{
    const updatedUser = await this.userModel.findOneAndUpdate({phone:user.phone}, user);
    updatedUser.password = undefined;
    updatedUser.salt = undefined;
    return updatedUser;
  }

  async delete(id: string){
    await this.userModel.remove({ _id: id });
    return "user deleted successfully";
  }

}
