import { Injectable } from '@angular/core';
import { BaseService } from './base/base.service';

@Injectable({
  providedIn: 'root'
})
export class CoursesService {

  constructor(public base: BaseService) { }

  fill(){
    return this.base.get('courses');
  }
}
