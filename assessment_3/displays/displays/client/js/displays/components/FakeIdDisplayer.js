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
    const preUpdateLength = length > 2
      ? length - 2
      : length;
    const htmlLines = [ `USER.ID: <span class="FakeId_Id">${fakeId.substring(0, preUpdateLength)}</span>` ];
    if (emotion) {
      htmlLines.push(`USER.EMOTION: ${emotion}`);
    }
    if (age) {
      htmlLines.push(`USER.AGE: ${emotion}`);
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