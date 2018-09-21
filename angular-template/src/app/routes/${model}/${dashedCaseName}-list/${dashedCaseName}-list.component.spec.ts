import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ${className}ListComponent } from './${dashedCaseName}-list.component';

describe('${className}ListComponent', () => {
  let component: ${className}ListComponent;
  let fixture: ComponentFixture<${className}ListComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ${className}ListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(${className}ListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
