import { Component, OnInit } from '@angular/core';
import {Location} from '@angular/common';

@Component({
  selector: 'edit-exam',
  templateUrl: './edit-exam.component.html',
  styleUrls: ['./edit-exam.component.sass']
})
export class EditExamComponent implements OnInit {
  variables: number;
  openvar: boolean = false;

  rows = [
    { Nombre: 'Pregunta 1' },
    { Nombre: 'Pregunta 2' },
    { Nombre: 'Pregunta 3' },
    { Nombre: 'Preguna 4' },
    { Nombre: 'Preguna 5' },
    { Nombre: 'Preguna 6' },
    { Nombre: 'Preguna 7' },
    { Nombre: 'Preguna 8' },
    { Nombre: 'Preguna 9' },
    { Nombre: 'Preguna 10' },
    { Nombre: 'Preguna 11' },
    { Nombre: 'Preguna N' },
  ];

  columns = [
    { prop: 'Nombre' },
  ];

  selected = [];
  question: boolean = false;

  temp = [];

  constructor(private _location: Location) { }

  ngOnInit() {
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
