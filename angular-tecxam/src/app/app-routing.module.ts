import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { AuthGuard } from './services/auth.guard';
import { LoginPageComponent } from 'src/app/components/_login-page/login-page.component';
import { MainPageComponent } from './components/_main-page/main-page.component';
import { ExamsPageComponent } from './components/_exams-page/exams-page.component';
import { EditExamComponent } from './components/_edit-exam/edit-exam.component';

const routes: Routes = [
  {
     path: '',
     component: MainPageComponent,
     canActivate: [AuthGuard]
  },
  {
     path: 'login',
     component: LoginPageComponent
  },
  {
     path: 'course/:id',
     component: ExamsPageComponent,
     canActivate: [AuthGuard]
  },
  {
     path: 'editar',
     component: EditExamComponent,
     canActivate: [AuthGuard]
  },
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
