// https://angular.io/guide/styleguide#style-04-12
export function throwIfAlreadyLoaded(parentModule: any, moduleName: string) {
  if (parentModule) {
    throw new Error(`${r"${"}moduleName} 已经加载。核心模块入口是AppModule.`);
  }
}
