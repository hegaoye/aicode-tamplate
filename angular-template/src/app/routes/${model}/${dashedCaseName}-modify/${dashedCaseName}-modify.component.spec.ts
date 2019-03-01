import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ${className}EditComponent } from './${dashedCaseName}-modify.component';

describe('${className}EditComponent', () => {
  let component: ${className}EditComponent;
  let fixture: ComponentFixture<${className}EditComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ${className}EditComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(${className}EditComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
