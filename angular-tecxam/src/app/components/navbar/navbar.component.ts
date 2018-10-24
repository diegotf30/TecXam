import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router'
import { LogoutService } from 'src/app/services/logout.service';

@Component({
  selector: 'navbar',
  templateUrl: './navbar.component.html',
  styleUrls: ['./navbar.component.sass']
})
export class NavbarComponent implements OnInit {

  constructor(private logoutService: LogoutService, private router : Router) { }

  ngOnInit() {
  }

  logout(){
    this.logoutService.logout();
    setTimeout(() => {
        this.router.navigateByUrl('/login');
      }
      , 2200);
  }

}
