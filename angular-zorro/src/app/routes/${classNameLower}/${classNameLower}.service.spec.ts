import { TestBed, inject } from '@angular/core/testing';

import { ${className}Service } from './${classNameLower}.service';

describe('${className}Service', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [${className}Service]
    });
  });

  it('should be created', inject([${className}Service], (service: ${className}Service) => {
    expect(service).toBeTruthy();
  }));
});
