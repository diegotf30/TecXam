import { Component, OnInit } from '@angular/core';
import {Location} from '@angular/common';
import { QuestionsService } from 'src/app/services/questions.service';

@Component({
  selector: 'edit-exam',
  templateUrl: './edit-exam.component.html',
  styleUrls: ['./edit-exam.component.sass']
})
export class EditExamComponent implements OnInit {
  variables: number;
  openvar: boolean = false;
  courseID: string;

  rows = [
    // { Nombre: 'Pregunta 1' },
    // { Nombre: 'Pregunta 2' },
    // { Nombre: 'Pregunta 3' },
    // { Nombre: 'Preguna 4' },
    // { Nombre: 'Preguna 5' },
    // { Nombre: 'Preguna 6' },
    // { Nombre: 'Preguna 7' },
    // { Nombre: 'Preguna 8' },
    // { Nombre: 'Preguna 9' },
    // { Nombre: 'Preguna 10' },
    // { Nombre: 'Preguna 11' },
    // { Nombre: 'Preguna N' },
  ];

  columns = [
    { prop: 'Nombre' },
  ];

  selected = [];
  question: boolean = false;

  temp = [];

  constructor(public questionsService: QuestionsService, private _location: Location) { }

  ngOnInit() {
    this.courseID = window.location.pathname.substr(13);
    this.load();
  }

  load(){
    this.questionsService.fill(this.courseID)
      .subscribe(
        (result) => {
          this.rows = [];
          console.log(result);
          // for(var i in result){
          //   let row = { acronym: result[i].acronym, name: result[i].name,
          //               description: result[i].description, created_at: result[i].created_at,
          //               updated_at: result[i].updated_at, user_id: result[i].user_id,
          //               id: result[i].id};
          //   this.rows.push(row);
          // }
          // this.rows = [...this.rows];
        },
        (error) => {
          console.error(error);
        }
      );
  }

  onSelect({ selected }) {
    // console.log('Select Event', selected, this.selected);
    if(selected != null){
      console.log(selected.length);
    }
  }

  singleSelectCheck (row:any) {
     return this.selected.indexOf(row) === -1;
  }

  onActivate(event) {
    // console.log('Activate Event', event);
  }

  onChangeVar(e){
    console.log(e.value);
    this.variables = e.value;
  }

  test(){
    this.openvar = true;
  }

  test2(){
    this._location.back();
  }

}
