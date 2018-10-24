import { Component, OnInit, ViewContainerRef } from '@angular/core';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import { NgForm } from '@angular/forms';
import { ToastsManager } from 'ng6-toastr/ng2-toastr';

@Component({
  selector: 'add-course-modal',
  templateUrl: './add-course-modal.component.html',
  styleUrls: ['./add-course-modal.component.sass']
})
export class AddCourseModalComponent implements OnInit {

  constructor(private modal: NgbActiveModal, public toastr: ToastsManager, vcr: ViewContainerRef) {
    this.toastr.setRootViewContainerRef(vcr);
  }

  ngOnInit() {
  }

  onSubmit(f: NgForm){
    if(f.value.siglas && f.value.name){
      this.modal.close(f.value);
    }
    else{
      if(!f.value.siglas){
        this.showError('Agrega las siglas!');
      }
      if(!f.value.name){
        this.showError('Dale un nombre!');
      }
    }
  }

  showError(msg: string) {
    this.toastr.error(msg, 'Oops!');
  }

}
