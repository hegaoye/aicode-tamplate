import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ${className}InfoComponent } from './${classNameLower}-info.component';

describe('${className}InfoComponent', () => {
  let component: ${className}InfoComponent;
  let fixture: ComponentFixture<${className}InfoComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ${className}InfoComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(${className}InfoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
