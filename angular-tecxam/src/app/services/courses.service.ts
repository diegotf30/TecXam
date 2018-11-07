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

  add(postBody: any){
    console.log(postBody);
    return this.base.post('courses', postBody);
  }

  delete(id: any){
    return this.base.delete(`courses/${id}`, null);
  }
}
