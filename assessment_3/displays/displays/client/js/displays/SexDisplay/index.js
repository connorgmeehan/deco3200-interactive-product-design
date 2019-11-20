import GenericDisplay from '../GenericDisplay';

class SexDisplay extends GenericDisplay {
  type = 'SEX';
  
  constructor() {
    super();
    console.log('sex display');
    console.log('face points display');
    const sex = document.getElementById('sex');
    sex.classList.add('Display__Active');

  }

  reset() {

  }
}

export default SexDisplay;
