import typer from 'typer-js';
import { getStringArrayTotalLength } from '../../helpers/utils';

class FakeIdDisplayer {
  constructor(parent) {
    this.parent = parent;

    this.container = document.createElement('div');
    this.container.classList.add('FakeId_Container');
    this.element = document.createElement('div');
    this.element.classList.add('FakeId');
    this.container.append(this.element);
    this.parent.append(this.container);
  }

  drawId(fakeId, duration, length = 10) {
    this.element.classList.add('FakeId__Active');
    const charDuration = duration / fakeId.length;
    this.typer = typer('.FakeId')
      .line(`USERID: ${fakeId.substring(0, length)}`, {speed: charDuration});
  }

  drawUserObject(fakeId, duration, length, emotion = null, age = null, sex = null) {
    this.fakeId = fakeId;
    this.idLength = length;
    const preUpdateLength = length >= 2
      ? length - 2
      : length;
    
    const htmlLines = [
      '<span class="u--font-weight-regular">PROCESS_RESULTS</span>',
      '<span class="u--font-weight-regular" style="line-height: 0.8rem">----------------</span>',
      '<span class="u--font-weight-regular u--invisible" style="line-height: 1rem">----------------</span>',
    ];
    
    htmlLines.push(preUpdateLength === 0 
      ? [ 'USER.ID: <span class="FakeId_Id u--display-none">00</span>']
      : [ `USER.ID: <span class="FakeId_Id">${fakeId.substring(0, preUpdateLength)}</span>` ]);
    if (emotion) {
      htmlLines.push(`USER.EMOTION: ${emotion}`);
    }
    if (age) {
      htmlLines.push(`USER.AGE: ${age}`);
    }
    if (sex) {
      htmlLines.push(`USER.SEX: ${sex}`);
    }
    
    this.element.classList.add('FakeId__Active');
    const charDuration = duration / getStringArrayTotalLength(htmlLines);
    this.typer = typer('.FakeId');
    htmlLines.forEach(line => {
      this.typer.line(line, {speed: charDuration});
    });
    this.typer.run(() => {
      setTimeout(() => {
        this.updateId();
      }, 1000);
    });
  }

  updateId() {
    const idSpan = this.element.querySelector('.FakeId_Id');
    idSpan.innerHTML = this.fakeId.substring(0, this.idLength);
    idSpan.classList.add('FakeId_Id__Updating');
    idSpan.classList.forEach(className => {
      className === "u--display-none" && idSpan.classList.remove("u--display-none");
    });
    setTimeout(() => {
      idSpan.classList.remove('FakeId_Id__Updating');
    }, 300);
  }

  clear() {
    this.typer.kill();
    this.element.classList.remove('FakeId__Active');
    this.element.innerHTML = '';
  }
}

export default FakeIdDisplayer;