import { TestBed, inject } from '@angular/core/testing';

import { ${model?cap_first}Service } from './${model}.service';

describe('${model?cap_first}Service', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [${model?cap_first}Service]
    });
  });

  it('should be created', inject([${model?cap_first}Service], (service: ${model?cap_first}Service) => {
    expect(service).toBeTruthy();
  }));
});
