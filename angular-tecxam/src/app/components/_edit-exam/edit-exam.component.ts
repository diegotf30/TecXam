import { Component, OnInit } from '@angular/core';
import { Location } from '@angular/common';
import { QuestionsService } from 'src/app/services/questions.service';
import { AnswersService } from 'src/app/services/answers.service';

@Component({
  selector: 'edit-exam',
  templateUrl: './edit-exam.component.html',
  styleUrls: ['./edit-exam.component.sass']
})
export class EditExamComponent implements OnInit {
  variables: number;
  checkAnswers: boolean = false;
  openvar: boolean = false;
  courseID: string;
  examID: string;

  rows = [];
  rows2 = [];

  columns = [
    { prop: 'name' },
  ];

  selected = [];
  question: boolean = false;

  temp = [];

  constructor(public questionsService: QuestionsService, public answersService: AnswersService, private _location: Location) { }

  ngOnInit() {
    let ids = window.location.pathname.match(/\d+/g);
    this.courseID = ids[0];
    this.examID = ids[1];
    this.load();
  }

  load(){
    this.questionsService.fill(this.courseID, this.examID)
      .subscribe(
        (result) => {
          this.rows = [];
          console.log(result);
          for(var i in result){
            let row = { id: result[i].id, name: result[i].name,
                        tags: result[i].tags, created_at: result[i].created_at,
                        updated_at: result[i].updated_at, user_id: result[i].user_id,
                        category: result[i].category };
            this.rows.push(row);
          }
          this.rows = [...this.rows];
        },
        (error) => {
          console.error(error);
        }
      );
  }

  loadAnswers(id: any){
    this.answersService.fill(id)
      .subscribe(
        (result) => {
          console.log(result);
          this.rows2 = [];
          for(var i in result){
            let row = { id: result[i].id, name: result[i].name,
                        question_id: result[i].question_id, created_at: result[i].created_at,
                        updated_at: result[i].updated_at };
            this.rows2.push(row);
          }
          this.rows2 = [...this.rows2];
        },
        (error) => {
          console.error(error);
        }
      );
  }

  onSelect({ selected }) {
    if(selected[0] != null){
      if(selected[0].category == 'multiple_choice' || selected[0].category == 'checkbox' || selected[0].category == 'radio'){
        this.checkAnswers = true;
      }
      else{
        this.checkAnswers = false;
      }
      this.loadAnswers(selected[0].id);
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

  openVariables(){
    this.openvar = true;
  }

  test2(){
    this._location.back();
  }

}
