import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ClassNameLowerComponent } from './${classNameLower}.component';

describe('ClassNameLowerComponent', () => {
  let component: ClassNameLowerComponent;
  let fixture: ComponentFixture<ClassNameLowerComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ClassNameLowerComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ClassNameLowerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
