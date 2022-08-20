/* eslint-disable prettier/prettier */
import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import * as dotenv from 'dotenv';


async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  // const corsOptions = { origin: ['http://10.0.2.2:8000'] };
  // app.enableCors(corsOptions);
  dotenv.config();
  await app.listen(3000);
}
bootstrap();
