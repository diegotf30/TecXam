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

  rows = [];

  columns = [
    { prop: 'name' },
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
          for(var i in result){
            let row = { id: result[i].id, name: result[i].name,
                        tags: result[i].tags, created_at: result[i].created_at,
                        updated_at: result[i].updated_at, user_id: result[i].user_id };
            this.rows.push(row);
          }
          this.rows = [...this.rows];
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
