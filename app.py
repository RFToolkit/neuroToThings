from psychopy import visual, core, event
from pyOpenBCI import OpenBCIGanglion

mywin = visual.Window([800,600],monitor="testMonitor", units="deg")

#create some stimuli
grating = visual.GratingStim(win=mywin, mask='circle', size=3, pos=[-4,0], sf=3)
fixation = visual.GratingStim(win=mywin, size=0.2, pos=[0,0], sf=0, rgb=-1)


def print_raw(sample):
    print(sample.channels_data)
    #create a window
    
    grating.setPhase(0.05, '+')#advance phase by 0.05 of a cycle
    grating.draw()
    fixation.draw()
    mywin.flip()
    if len(event.getKeys())>0:
        print(sample.__dir__)
    event.clearEvents()


board = OpenBCIGanglion(mac='E5:CE:2F:3E:D9:42')

board.start_stream(print_raw)


