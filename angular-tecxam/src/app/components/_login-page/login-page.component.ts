import { Component, OnInit, ViewContainerRef } from '@angular/core';
import { Router } from '@angular/router';
import { ToastsManager } from 'ng6-toastr/ng2-toastr';

@Component({
  selector: 'login-page',
  templateUrl: './login-page.component.html',
  styleUrls: ['./login-page.component.sass']
})
export class LoginPageComponent implements OnInit {

  loading: boolean;
  register: boolean;

  constructor(private router : Router, public toastr: ToastsManager, vcr: ViewContainerRef) {
    this.toastr.setRootViewContainerRef(vcr);
  }

  ngOnInit() {
    this.loading = false;
    this.register = false;
  }

  onChange(){
    this.register = !this.register;
  }

  onSubmitLogin(e){
    if(e){
      this.showSuccess('Bienvenido!');
      this.loading = true;
      setTimeout(() => {
          this.router.navigateByUrl('');
        }
        , 1100);
    }
    else{
      this.showError('Revisa tus datos!');
    }
  }

  onSubmitRegister(e){
    if(e){
      // this.showSuccess();
      // this.loading = true;
      // setTimeout(() => {
      //     this.router.navigateByUrl('/dashboard');
      //   }
      //   , 2200);
    }
    else{
      this.showError('De momento no estamos aceptando usuarios nuevos');
    }
  }

  showSuccess(msg: string) {
    this.toastr.success(msg, 'Whoo!');
  }

  showError(msg: string) {
    this.toastr.error(msg, 'Oops!');
  }
}