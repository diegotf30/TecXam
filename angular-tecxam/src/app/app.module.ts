import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';

import { HttpClientModule } from '@angular/common/http';

import { FormsModule, ReactiveFormsModule }        from '@angular/forms';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
//
// Extras
//

import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { AngularFontAwesomeModule } from 'angular-font-awesome';
import { ToastModule } from 'ng6-toastr/ng2-toastr';
import { NgxDatatableModule } from '@swimlane/ngx-datatable';
import { TagInputModule } from 'ngx-chips';
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
import { BackButtonComponent } from './components/back-button/back-button.component';
import { NextButtonComponent } from './components/next-button/next-button.component';
import { AddCourseModalComponent } from './components/add-course-modal/add-course-modal.component';
import { AddExamModalComponent } from './components/add-exam-modal/add-exam-modal.component';
import { AddQuestionModalComponent } from './components/add-question-modal/add-question-modal.component';
import { EditExamComponent } from './components/_edit-exam/edit-exam.component';
import { NotFoundPageComponent } from './components/_not-found-page/not-found-page.component';

@NgModule({
  declarations: [
    AppComponent,
    LoginPageComponent,
    MainPageComponent,
    NavbarComponent,
    LoginComponent,
    RegisterComponent,
    ExamsPageComponent,
    BackButtonComponent,
    NextButtonComponent,
    AddCourseModalComponent,
    AddExamModalComponent,
    AddQuestionModalComponent,
    EditExamComponent,
    NotFoundPageComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule,
    ReactiveFormsModule,
    BrowserAnimationsModule,
    ToastModule.forRoot(),
    NgbModule,
    AngularFontAwesomeModule,
    NgxDatatableModule,
    TagInputModule
  ],
  providers: [
    BaseService,
    AuthGuard
  ],
  bootstrap: [AppComponent],
  entryComponents: [
    AddCourseModalComponent,
    AddExamModalComponent,
    AddQuestionModalComponent
  ]
})
export class AppModule { }
