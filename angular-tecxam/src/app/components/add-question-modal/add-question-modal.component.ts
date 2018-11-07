import { Component, OnInit, ViewContainerRef } from '@angular/core';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import { NgForm } from '@angular/forms';
import { ToastsManager } from 'ng6-toastr/ng2-toastr';

@Component({
  selector: 'add-question-modal',
  templateUrl: './add-question-modal.component.html',
  styleUrls: ['./add-question-modal.component.sass']
})
export class AddQuestionModalComponent implements OnInit {

  constructor(private modal: NgbActiveModal, public toastr: ToastsManager, vcr: ViewContainerRef) {
    this.toastr.setRootViewContainerRef(vcr);
  }

  ngOnInit() {
  }

  onSubmit(f: NgForm){
    if(f.value.acronym && f.value.name){
      this.modal.close(f.value);
    }
    else{
      if(!f.value.acronym){
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
