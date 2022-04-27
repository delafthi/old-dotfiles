# Add signal groups and filters
set signals {
  {{clk & rst} {(dut(_\\w+|\\d+|).clk$|dut(_\\w+|\\d+|).rst$)}}
  {{inputs} {dut(_\\w+|\\d+|).\\w+_i(\\\[0\\\]|$)}}
  {{outputs} {dut(_\\w+|\\d+|).\\w+_o(\\\[0\\\]|$)}}
  {{misc} {dut(_\\w+|\\d+|).\\w+_(\\w|)s(\\\[0\\\]|$)}}
  {{testbench} {(_\\w+|\\d+|).\\w+_tb(\\\[0\\\]|$)}}}

# Load all signals
set nsigs [ gtkwave::getNumFacs ]

proc add_signals { groupName filter} {
    global nsigs

    set monitorSignals [list]
    for {set i 0} {$i < $nsigs } {incr i} {
        set facname [ gtkwave::getFacName $i ]
        puts $facname
        foreach f $filter {
          if {[regexp -nocase $f $facname]} {
              lappend monitorSignals "$facname"
              break
          }
        }
    }
    gtkwave::/Edit/Insert_Comment $groupName
    gtkwave::addSignalsFromList $monitorSignals
    foreach v $monitorSignals {
        set a [split $v .]
        set a [lindex $a end]
        gtkwave::highlightSignalsFromList $v
    }
    gtkwave::/Edit/Insert_Blank
    gtkwave::/Edit/UnHighlight_All
}

# Zoom all
gtkwave::/Time/Zoom/Zoom_Full

# Add signals thru filters
foreach s $signals {
    add_signals [lindex $s 0] [lindex $s 1]
}
