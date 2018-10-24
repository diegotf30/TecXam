import { Component, OnInit, ViewContainerRef } from '@angular/core';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import { NgForm } from '@angular/forms';
import { ToastsManager } from 'ng6-toastr/ng2-toastr';

@Component({
  selector: 'add-exam-modal',
  templateUrl: './add-exam-modal.component.html',
  styleUrls: ['./add-exam-modal.component.sass']
})
export class AddExamModalComponent implements OnInit {
  type: string = null;
  upload: boolean = false;
  file: File = null;
  fileName = 'Seleccionar archivo...';

  constructor(private modal: NgbActiveModal, public toastr: ToastsManager, vcr: ViewContainerRef) {
    this.toastr.setRootViewContainerRef(vcr);
  }

  ngOnInit() {
  }

  onChange(e){
    this.type = e.value;
    if(e.value == 'Otro'){
      this.upload = true;
    }
    else{
      this.upload = false;
    }
  }

  handleBannerInput(image: FileList) {
    this.file = image.item(0);
    this.fileName = image.item(0).name;
  }

  onSubmit(f: NgForm){
    if(this.type && f.value.name){
      f.value.type = this.type;
      this.modal.close(f.value);
    }
    else{
      if(!this.type){
        this.showError('Selecciona el tipo de documento');
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
