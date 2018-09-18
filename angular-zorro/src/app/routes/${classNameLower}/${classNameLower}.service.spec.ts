import { TestBed, inject } from '@angular/core/testing';

import { ClassNameLowerService } from './${classNameLower}.service';

describe('ClassNameLowerService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [ClassNameLowerService]
    });
  });

  it('should be created', inject([ClassNameLowerService], (service: ClassNameLowerService) => {
    expect(service).toBeTruthy();
  }));
});
