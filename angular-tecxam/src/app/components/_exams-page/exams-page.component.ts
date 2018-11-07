import { Component, OnInit, ViewChild } from '@angular/core';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { AddExamModalComponent } from '../add-exam-modal/add-exam-modal.component';
import { ExamsService } from 'src/app/services/exams.service';

@Component({
  selector: 'exams-page',
  templateUrl: './exams-page.component.html',
  styleUrls: ['./exams-page.component.sass']
})
export class ExamsPageComponent implements OnInit {
  courseID: string;
  rows = [];
  columns = [
    { prop: 'Documento' },
  ];

  selected = [];

  temp = [];

  @ViewChild('table') table: any;

  constructor(public examsService: ExamsService, private modalService: NgbModal) { }

  ngOnInit() {
    this.courseID = window.location.pathname.substr(9).match(/\d+/)[0];
    this.load();
  }

  load(){
    this.examsService.fill(this.courseID)
      .subscribe(
        (result) => {
          this.rows = [];
          // console.log(result);
          for(var i in result){
            let row = { name: result[i].name, created_at: result[i].created_at,
                        uploaded_at: result[i].updated_at, course_id: result[i].course_id,
                        id: result[i].id, is_random: result[i].is_random, type: 'Examen'};
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
    this.selected.splice(0, this.selected.length);
    for(let s in selected){
      this.selected.push(selected[s].id);
    }
    console.log(this.selected);
  }

  onActivate(event) {
    // var obj = this.rows.some((val) => {
    // 	return Object.values(val).includes('TC0001');
    // });
    // var index = this.rows.findIndex(x => x.Siglas=="TC00000");

    // var filtered = this.rows.filter(x => x.Siglas != "TC00000");

    // console.log('Activate Event', event);
  }

  toggleExpandRow(row) {
    // console.log('Toggled Expand Row!', row);
    this.table.rowDetail.toggleExpandRow(row);
  }

  toggleExpandGroup(group) {
    // console.log('Toggled Expand Group!', group);
    this.table.groupHeader.toggleExpandGroup(group);
  }

  onDetailToggle(event) {
    // console.log('Detail Toggled', event);
  }

  info(group: string){
    if(group == 'Examen'){
      return 'Sección de examenes genearados';
    }
    if(group == 'Tarea'){
      return 'Sección de tareas genearados';
    }
    if(group == 'Otro'){
      return 'Sección de documentos subidos que no se pueden editar';
    }
  }

  open(){
    this.modalService.open(AddExamModalComponent,
                          { centered: true, windowClass: 'add-modal' }
                          ).result.then((result) => {
      let exam = {
        exam: {
          name: result.name,
          random_questions: { },
          time_limit: result.time
        }
      };

      if(result.tags.length > 0){
        console.log('aqui toy');
      }

      // this.add(exam);
    }, (reason) => {
      console.log('Closed');
    });;  //size: 'sm',
  }


  add(postBody: any){
    this.examsService.add(this.courseID, postBody)
      .subscribe(
        (result) => {
          this.load();
        },
        (error) => {
          console.error(error);
        }
      );
  }

  onDelete(){
    for(let s in this.selected){
      this.deleteExam(this.selected[s]);
    }
  }

  deleteExam(id: string){
    this.examsService.delete(this.courseID, id)
      .subscribe(
        (result) => {
          this.load();
        },
        (error) => {
          console.error(error);
        }
      );
  }

}
