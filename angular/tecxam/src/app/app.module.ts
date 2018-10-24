import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';

import { HttpClient, HttpClientModule } from '@angular/common/http';

import { FormsModule }        from '@angular/forms';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
//
// Extras
//

import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { AngularFontAwesomeModule } from 'angular-font-awesome';
import { ToastModule } from 'ng6-toastr/ng2-toastr';
import { NgxDatatableModule } from '@swimlane/ngx-datatable';
//
// Utility / Services
//

import { AuthGuard } from './services/auth.guard';
import { BaseService } from './services/base/base.service';
//
// Components
//

// Login
import { LoginPageComponent } from './components/_login-page/login-page.component';
import { MainPageComponent } from './components/_main-page/main-page.component';
import { NavbarComponent } from './components/navbar/navbar.component';
import { LoginComponent } from './components/login/login.component';
import { RegisterComponent } from './components/register/register.component';
import { ExamsPageComponent } from './components/_exams-page/exams-page.component';

@NgModule({
  declarations: [
    AppComponent,
    LoginPageComponent,
    MainPageComponent,
    NavbarComponent,
    LoginComponent,
    RegisterComponent,
    ExamsPageComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule,
    BrowserAnimationsModule,
    ToastModule.forRoot(),
    NgbModule,
    AngularFontAwesomeModule,
    NgxDatatableModule
  ],
  providers: [
    BaseService,
    AuthGuard
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
