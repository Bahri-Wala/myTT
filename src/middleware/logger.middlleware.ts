/* eslint-disable prettier/prettier */
// import { Injectable, NestMiddleware } from '@nestjs/common';
// import { JwtService } from '@nestjs/jwt';
// import { Request, Response, NextFunction } from 'express';
// import { JwtStrategy } from 'src/auth/strategy/passport-jwt.strategy';

// @Injectable()
// export class LoggerMiddleware implements NestMiddleware {
//   use(req: Request, res: Response, next: NextFunction) {
//     console.log('middleware...');
//     const token = req.headers["authorization"];
//     if(typeof token !== "undefined"){
//         req.user = await JwtStrategy.validate(token, process.env.JWTSECRETKEY);
//         next();
//     }else{
//         return res.status(403).send("not authorized");
//     }
//     next();
//   }
// }