import { Component, OnInit, ViewChild } from '@angular/core';

@Component({
  selector: 'exams-page',
  templateUrl: './exams-page.component.html',
  styleUrls: ['./exams-page.component.sass']
})
export class ExamsPageComponent implements OnInit {
  rows = [
    { Examen: 'Primer Parcial', NotasAdicionales: 'Aqui se puede escribir mucho'},
    { Examen: 'Segundo Parcial', NotasAdicionales: 'Aqui se puede escribir mucho'},
  ];
  columns = [
    { prop: 'Examen' },
  ];

  selected = [];

  temp = [];

  @ViewChild('table') table: any;

  constructor() { }

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

  onDetailToggle(event) {
    console.log('Detail Toggled', event);
  }
}
