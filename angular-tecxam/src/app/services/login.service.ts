import { Injectable } from '@angular/core';
import { BaseService } from './base/base.service';

const user = 'test'
const password = '1234567a';

@Injectable({
  providedIn: 'root'
})
export class LoginService {

  constructor(public base: BaseService) { }

  login(postBody: any) {
    if(postBody.value.user == user && postBody.value.password == password){
      localStorage.setItem('user', user);
      localStorage.setItem('password', password);
      return true;
    }
    return false;
    // return this.base.post('association/registration', postBody);
  }

  isLogged(){
    return localStorage.getItem('user') != null;
  }
}
