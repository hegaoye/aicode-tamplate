import { ${classNameLower?cap_first}Module } from './${classNameLower}.module';

describe('${classNameLower?cap_first}Module', () => {
  let ${classNameLower}Module: ${classNameLower?cap_first}Module;

  beforeEach(() => {
    ${classNameLower}Module = new ${classNameLower?cap_first}Module();
  });

  it('should create an instance', () => {
    expect(${classNameLower}Module).toBeTruthy();
  });
});
