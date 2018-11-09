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
  category: string = null;

  constructor(private modal: NgbActiveModal, public toastr: ToastsManager, vcr: ViewContainerRef) {
    this.toastr.setRootViewContainerRef(vcr);
  }

  ngOnInit() {
  }

  onSubmit(f: NgForm){
    if(!f.value.points){
      f.value.points = '0';
    }
    if(f.value.name && this.category){
      f.value.category = this.category;
      f.value.tags = f.value.tags.replace(' ', '');
      this.modal.close(f.value);
    }
    else{
      if(!f.value.name){
        this.showError('Ingresa la pregunta!');
      }
      if(!this.category){
        this.showError('Selecciona una categoría!');
      }
    }
  }

  onChange(e){
    if(e.value == 'Opción mutliple'){
      this.category = 'multiple_choice';
    }
    else if(e.value == 'Checkbox'){
      this.category = 'checkbox';
    }
    else if(e.value == 'Radio'){
      this.category = 'radio';
    }
    else if(e.value == 'Caja de Texto corto'){
      this.category = 'small_textbox';
    }
    else if(e.value == 'Caja de Texto largo'){
      this.category = 'big_textbox';
    }
    else if(e.value == 'Párrafo'){
      this.category = 'paragraph';
    }
    else if(e.value == 'Ensayo'){
      this.category = 'essay';
    }
  }

  showError(msg: string) {
    this.toastr.error(msg, 'Oops!');
  }

}
