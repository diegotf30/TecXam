import { Injectable } from '@angular/core';
import { BaseService } from './base/base.service';

@Injectable({
  providedIn: 'root'
})
export class QuestionsService {

  constructor(public base: BaseService) { }

  fill(cid: string, eid: string){
    return this.base.get(`courses/${cid}/exams/${eid}/questions`);
    ;
  }
}
