import { TestBed, inject } from '@angular/core/testing';

import { SuppliersService } from './suppliers.service';

describe('SuppliersService', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [SuppliersService]
    });
  });

  it('should be created', inject([SuppliersService], (service: SuppliersService) => {
    expect(service).toBeTruthy();
  }));
});
