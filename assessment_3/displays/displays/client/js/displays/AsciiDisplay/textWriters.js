import LineWriter from '../../helpers/Linewriter';

export const startMainFaceText = (duration, mainFaceString) => {
  const lineWriter = new LineWriter('.AsciiDisplay_MainFace', {duration});
  mainFaceString.forEach(line => {
    lineWriter.line(line);
  });
  lineWriter.start();
  return lineWriter;
};

export const startSubFaceText = (element, lines, duration) => {
  const lineWriter = new LineWriter(element, {duration}, lines);
  lineWriter.start();
  return lineWriter;
};

export const startInitialText = (duration) => {
  const displayText = [
    'sudo /etc/init.d/dbus restart',
    '* Starting system message bus dbus [ <span class="u--color-green">OK</span> ]',
    '* Starting network connection manager NetworkManager [ <span class="u--color-green">OK</span> ]',
    '* Starting network events dispatcher NetworkManagerDispatcher [ <span class="u--color-green">OK</span> ]',
    '* Starting System Tools Backends system-tools-backends [ <span class="u--color-green">OK</span> ]',
    '* Starting Avahi mDNS/DNS-SD Daemon avahi-daemon [<span class="u--color-red">FAIL</span>]',
    '* Starting DHCP D-Bus daemon dhcdbd [ <span class="u--color-green">OK</span> ]',
    '* Starting Hardware abstraction layer haldinvoke-rc.d: initscript hal, action "face_analysis" init ',
  ];
  const lineWriter = new LineWriter('.AsciiDisplay_InitialText', { duration }, displayText);
  lineWriter.start();
  return lineWriter;
};

export default {
  startInitialText,
  startMainFaceText,
  startSubFaceText
};