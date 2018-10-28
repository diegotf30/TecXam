import { Injectable } from '@angular/core';
import { BaseService } from './base/base.service';

@Injectable({
  providedIn: 'root'
})
export class ExamsService {

  constructor(public base: BaseService) { }

  fill(){
    return this.base.get('exams');
  }
}
