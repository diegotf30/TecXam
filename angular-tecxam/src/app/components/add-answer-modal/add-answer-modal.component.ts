import { Component, OnInit, ViewContainerRef } from '@angular/core';
import { NgbActiveModal } from '@ng-bootstrap/ng-bootstrap';
import { NgForm } from '@angular/forms';
import { ToastsManager } from 'ng6-toastr/ng2-toastr';

@Component({
  selector: 'add-answer-modal',
  templateUrl: './add-answer-modal.component.html',
  styleUrls: ['./add-answer-modal.component.sass']
})
export class AddAnswerModalComponent implements OnInit {
  category: string = null;
  varNumber = 0;
  variables = []
  correct: boolean = false;

  constructor(private modal: NgbActiveModal, public toastr: ToastsManager, vcr: ViewContainerRef) {
    this.toastr.setRootViewContainerRef(vcr);
  }

  ngOnInit() {
  }

  onChangeVar(index, value){
    this.variables[index].var = value;
  }

  onChangeValue(index, value){
    this.variables[index].values = value;
  }

  onSubmit(f: NgForm){
    if(f.value.name && this.varNumber < 1){
      f.value.correct = this.correct;
      this.modal.close(f.value);
    }
    else if(f.value.name && this.varNumber >= 1){
      let error = false;
      for(let i in this.variables){
        if(!this.variables[i].var){
          error = true;
        }
        if(!this.variables[i].values){
          error = true;
        }
      }
      if(error){
        this.showError('Completa los campos!');
      }
      else{
        f.value.variables = this.variables;
        this.modal.close(f.value);
      }
    }
    // else{
    //   if(!f.value.name){
    //     this.showError('Ingresa la pregunta!');
    //   }
    //   if(!this.category){
    //     this.showError('Selecciona una categoría!');
    //   }
    // }
  }

  addVar(){
    this.varNumber = this.varNumber + 1;
    this.variables.push({'var':'', 'values':''});
  }


  showError(msg: string) {
    this.toastr.error(msg, 'Oops!');
  }

  onChange(e){
    this.correct = e;
  }

}
