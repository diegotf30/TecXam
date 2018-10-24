import { Component, OnInit, ViewChild } from '@angular/core';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { AddExamModalComponent } from '../add-exam-modal/add-exam-modal.component';

@Component({
  selector: 'exams-page',
  templateUrl: './exams-page.component.html',
  styleUrls: ['./exams-page.component.sass']
})
export class ExamsPageComponent implements OnInit {


  rows = [
    { Type:'Examen', Nombre: 'Primer Parcial'},
    { Type:'Examen', Nombre: 'Segundo Parcial'},
    { Type:'Tarea', Nombre: 'Tarea'},
    { Type:'Otro', Nombre: 'Documento subido por profesor'},
  ];
  columns = [
    { prop: 'Documento' },
  ];

  selected = [];

  temp = [];

  @ViewChild('table') table: any;

  constructor(private modalService: NgbModal) { }

  ngOnInit() {
  }

  onSelect({ selected }) {
    // console.log('Select Event', selected, this.selected);

    this.selected.splice(0, this.selected.length);
    this.selected.push(...selected);
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
    console.log('Toggled Expand Row!', row);
    this.table.rowDetail.toggleExpandRow(row);
  }

  toggleExpandGroup(group) {
    console.log('Toggled Expand Group!', group);
    this.table.groupHeader.toggleExpandGroup(group);
  }

  onDetailToggle(event) {
    console.log('Detail Toggled', event);
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
    this.modalService.open(AddExamModalComponent, { centered: true, windowClass: 'add-modal' }).result.then((result) => {
      let row = { Type: result.type, Nombre: result.name, NotasAdicionales: result.notes};
      this.rows.push(row);
      this.rows = [...this.rows];
    }, (reason) => {
      console.log('Closed');
    });;  //size: 'sm',
  }

}
