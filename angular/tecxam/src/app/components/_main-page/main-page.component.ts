import { Component, OnInit, ViewChild } from '@angular/core';

@Component({
  selector: 'app-main-page',
  templateUrl: './main-page.component.html',
  styleUrls: ['./main-page.component.sass']
})
export class MainPageComponent implements OnInit {
  rows = [
    { Siglas: 'TC1019', Nombre: ' Introduction to Software Engineering', Info: 'Upon completion of this course, students will be able to understand the fundamentals of software engineering and use object-oriented modeling tools and methodologies'},
    { Siglas: 'TC1020', Nombre: ' Databases', Info: 'Upon completion of this course, students will be able to design and build an effective, efficient information system that meets the information requirements of an organization using relational databases, producing the appropriate documentation for the analysis and design phases, and ensuring the consistency of the data given the multi-user access. '},
  ];

  columns = [
    { prop: 'Siglas' },
    { prop: 'Nombre' },
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
