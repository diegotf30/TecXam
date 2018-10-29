import { Injectable } from '@angular/core';
import { BaseService } from './base/base.service';

@Injectable({
  providedIn: 'root'
})
export class QuestionsService {

  constructor(public base: BaseService) { }

  fill(id: string){
    return this.base.get(`exams/${id}/questions`);
    ;
  }
}
