import { Controller, Get, Post } from '@nestjs/common';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get('profiles/count')
  async count() {
    return await this.appService.getProfileCount();
  }

  @Post('profiles/test')
  async createTest() {
    return await this.appService.createTestProfile();
  }
}
