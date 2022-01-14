#!/usr/bin/python3

import i3ipc
i3 = i3ipc.Connection()
print("starting auto gaps")

def add_gaps():    
    i3.command('gaps right current set 700')
    i3.command('gaps left current set 700')
    i3.command('gaps top current set 10')
    i3.command('gaps bottom current set 10')

def remove_gaps():
    i3.command('gaps left current set 0')
    i3.command('gaps right current set 0')
    i3.command('gaps top current set 0')
    i3.command('gaps bottom current set 0')  
   
def manage_new_close_window(self, e):
    focused = i3.get_tree().find_focused()
    workspace = focused.workspace()
    y = len(workspace.leaves())
    
    if y > 1:
        remove_gaps()
        return
    
    if workspace.rect.width <= 1920:
        remove_gaps()
        return

    add_gaps()    

i3.on('window::new', manage_new_close_window)
i3.on('window::close', manage_new_close_window)
i3.on('window::move', manage_new_close_window)
i3.on('window::focus', manage_new_close_window)
i3.on('workspace::empty', manage_new_close_window)
i3.on('workspace::init', manage_new_close_window)

i3.main()
