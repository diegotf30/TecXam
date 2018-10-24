import { Component, OnInit, Input } from '@angular/core';

@Component({
  selector: 'back-button',
  templateUrl: './back-button.component.html',
  styleUrls: ['./back-button.component.sass']
})
export class BackButtonComponent implements OnInit {
  @Input() link: string;
  @Input() title: string;

  constructor() { }

  ngOnInit() {
  }

}
