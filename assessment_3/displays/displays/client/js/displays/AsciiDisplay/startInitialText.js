import typer from 'typer-js';

const startInitialText = (duration) => {
  typer('.AsciiDisplay_InitialText', { duration: duration })
    .cursor({block: true, blink: 'hard', color: '#6BFF2D'})
    .line('sudo /etc/init.d/dbus restart')
    .line('* Starting system message bus dbus [ <span class="u--color-green">OK</span> ]')
    .line('* Starting network connection manager NetworkManager [ <span class="u--color-green">OK</span> ]')
    .line('* Starting network events dispatcher NetworkManagerDispatcher [ <span class="u--color-green">OK</span> ]')
    .line('* Starting System Tools Backends system-tools-backends [ <span class="u--color-green">OK</span> ]')
    .line('* Starting Avahi mDNS/DNS-SD Daemon avahi-daemon [<span class="u--color-red">FAIL</span>]')
    .line('* Starting DHCP D-Bus daemon dhcdbd [ <span class="u--color-green">OK</span> ]')
    .line('* Starting Hardware abstraction layer haldinvoke-rc.d: initscript hal, action "face_analysis" init ');
};

export default startInitialText;