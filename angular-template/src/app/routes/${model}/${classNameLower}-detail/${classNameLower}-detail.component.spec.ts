import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ${className}DetailComponent } from './${classNameLower}-detail.component';

describe('${className}DetailComponent', () => {
  let component: ${className}DetailComponent;
  let fixture: ComponentFixture<${className}DetailComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ${className}DetailComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(${className}DetailComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
