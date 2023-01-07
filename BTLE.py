
from pyOpenBCI import OpenBCIGanglion


def print_raw(sample):
    print(sample.channels_data)

board = OpenBCIGanglion(mac='E5:CE:2F:3E:D9:42')

board.start_stream(print_raw)