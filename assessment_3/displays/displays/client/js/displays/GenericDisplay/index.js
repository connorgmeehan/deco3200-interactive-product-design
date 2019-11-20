class GenericDisplay {
  type = 'GENERIC';

  constructor() {

  }

  reset(...args) {
    console.log(`Display of type ${this.type} is resettings on args...`);
    console.log(args);
  }
}

export default GenericDisplay;