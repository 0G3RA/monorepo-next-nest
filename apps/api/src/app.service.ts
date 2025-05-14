import { Injectable } from '@nestjs/common';
import { sum } from '@plinks-pw/domain';

@Injectable()
export class AppService {
  getHello(): string {
    return 'Hello World! ' + sum(2, 2);
  }
}
