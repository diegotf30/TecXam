import { Component, OnInit } from '@angular/core';
import { Location } from '@angular/common';
import { QuestionsService } from 'src/app/services/questions.service';
import { AnswersService } from 'src/app/services/answers.service';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { AddQuestionModalComponent } from '../add-question-modal/add-question-modal.component';
import { AddAnswerModalComponent } from '../add-answer-modal/add-answer-modal.component';

@Component({
  selector: 'edit-exam',
  templateUrl: './edit-exam.component.html',
  styleUrls: ['./edit-exam.component.sass']
})
export class EditExamComponent implements OnInit {
  variables: number;
  checkAnswers: boolean = false;
  courseID: string;
  examID: string;

  rows = [];
  rows2 = [];

  columns = [
    { prop: 'name' },
    { prop: 'points' },
  ];

  columns2 = [
    { prop: 'name' },
    { prop: 'correct' },
  ];

  selected = [];
  selectedAns = [];
  question: boolean = false;

  temp = [];

  constructor(public questionsService: QuestionsService, public answersService: AnswersService, private _location: Location,  private modalService: NgbModal) { }

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
          for(var i in result){
            let row = { id: result[i].id, name: result[i].name,
                        tags: result[i].tags, created_at: result[i].created_at,
                        updated_at: result[i].updated_at, user_id: result[i].user_id,
                        category: result[i].category, points: result[i].points };
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
          this.rows2 = [];
          console.log(result); // borrar
          for(var i in result){
            let row = { id: result[i].id, name: result[i].name,
                        question_id: result[i].question_id, created_at: result[i].created_at,
                        updated_at: result[i].updated_at, correct: result[i].correct };
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

  open(){
    this.modalService.open(
        AddQuestionModalComponent,
        { centered: true, windowClass: 'add-modal' }
        ).result.then((result) => {
          let question =  {
                            'question': {
                            	'name': result.name,
                            	'points': result.points,
                            	'category': result.category,
                            	'tags': null
                            }
                          }
          let tags = result.tags.split(',');
          question.question.tags = tags;
      this.add(question);

    }, (reason) => {
      console.log('Closed');
    });  //size: 'sm',
  }

  add(postBody: any){
    this.questionsService.add(this.courseID, this.examID, postBody)
      .subscribe(
        (result) => {
          this.load();
          this.openAns2(result);
        },
        (error) => {
          console.error(error);
        }
      );
  }

  openAns(){
    this.modalService.open(
        AddAnswerModalComponent,
        { centered: true, windowClass: 'add-modal' }
        ).result.then((result) => {
          let answer =  {
                            'answer': {
                            	'name': result.name,
                            	'variables': {},
                              'correct': result.correct
                            }
                          }
          let vars = result.variables;
          for(let v in vars){
            let temp = vars[v].values.split(',');
            answer.answer.variables[vars[v].var] = temp;
          }
          this.addAns(answer);
    }, (reason) => {
      console.log('Closed');
    });  //size: 'sm',
  }

  addAns(postBody: any){
    this.answersService.add(this.selected[0].id, postBody)
      .subscribe(
        (result) => {
          this.loadAnswers(this.selected[0].id);
        },
        (error) => {
          console.error(error);
        }
      );
  }

  openAns2(res: any){
    let id = res.id;
    this.modalService.open(
        AddAnswerModalComponent,
        { centered: true, windowClass: 'add-modal' }
        ).result.then((result) => {
          let answer =  {
                            'answer': {
                            	'name': result.name,
                            	'variables': {}
                            }
                          }
          let vars = result.variables;
          for(let v in vars){
            let temp = vars[v].values.split(',');
            answer.answer.variables[vars[v].var] = temp;
          }
          this.addAns2(id, answer);
    }, (reason) => {
      console.log('Closed');
    });  //size: 'sm',
  }

  addAns2(id: any, postBody: any){
    this.answersService.add(id, postBody)
      .subscribe(
        (result) => {
        },
        (error) => {
          console.error(error);
        }
      );
  }

  test2(){
    this._location.back();
  }
}

export interface Question {
    id: any;
    category: any;
    created_at: number;
    points: any;
    tags: any;
    updated_at: any;
    user_id: any;
}
