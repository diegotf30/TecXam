import { Component, OnInit, ViewChild } from '@angular/core';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { AddCourseModalComponent } from '../add-course-modal/add-course-modal.component';
import { CoursesService } from 'src/app/services/courses.service';

@Component({
  selector: 'app-main-page',
  templateUrl: './main-page.component.html',
  styleUrls: ['./main-page.component.sass']
})
export class MainPageComponent implements OnInit {
  rows = [];

  columns = [
    { prop: 'acronym' },
    { prop: 'name' },
  ];

  selected = [];

  temp = [];

  @ViewChild('table') table: any;

  constructor(public courseService: CoursesService, private modalService: NgbModal) { }

  ngOnInit() {
    this.load();
  }

  load(){
    this.courseService.fill()
      .subscribe(
        (result) => {
          this.rows = [];
          for(var i in result){
            let row = { acronym: result[i].acronym, name: result[i].name,
                        description: result[i].description, created_at: result[i].created_at,
                        updated_at: result[i].updated_at, user_id: result[i].user_id,
                        id: result[i].id};
            this.rows.push(row);
          }
          this.rows = [...this.rows];
        },
        (error) => {
          console.error(error);
        }
      );
  }

  add(course: any){
    this.courseService.add(course)
      .subscribe(
        (result) => {
          this.load();
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

  onDetailToggle(event) {
    // console.log('Detail Toggled', event);
  }

  onDelete(){
    for(let s in this.selected){
      this.deleteCourse(this.selected[s]);
    }
  }

  deleteCourse(id: number){
    this.courseService.delete(id)
      .subscribe(
        (result) => {
          this.load();
        },
        (error) => {
          console.error(error);
        }
      );
  }

  open(){
    this.modalService.open(AddCourseModalComponent,
                          { centered: true, windowClass: 'add-modal' }
                          ).result.then((result) => {
      let course = {
        course: {
          acronym: result.acronym,
          name: result.name,
          description: result.description
        }
      };
      this.add(course);
    }, (reason) => {
      console.log('Closed');
    });  //size: 'sm',
  }
}
