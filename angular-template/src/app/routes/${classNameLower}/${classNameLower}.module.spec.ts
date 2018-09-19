import { ${className}Module } from './${classNameLower}.module';

describe('${className}Module', () => {
  let ${classNameLower}Module: ${className}Module;

  beforeEach(() => {
    ${classNameLower}Module = new ${className}Module();
  });

  it('should create an instance', () => {
    expect(${classNameLower}Module).toBeTruthy();
  });
});
