# Add signal groups and filters
set signals {
  {{clk & rst} {I} {^(clk|(rst|rst_n)).*$}}
  {{test_id} {^$} {test_id$}}
  {{inputs} {I} {^(?!(clk|rst|rst_n|s_axi_|m_axi_)).*$}}
  {{outputs} {O} {^(?!(s_axi_|m_axi_)).*$}}
  {{ios} {IO} {^.*$}}
  {{misc} {^$} {^(?!test_id$).*}}
  {{s_axi} {I|O} {s_axi_(?!(str_|lite_)).*$}}
  {{m_axi} {I|O} {m_axi_(?!(str_|lite_)).*$}}
  {{s_axi_str} {I|O} {s_axi_str_.*$}}
  {{m_axi_str} {I|O} {m_axi_str_.*$}}
  {{s_axi_lite} {I|O} {s_axi_lite_.*$}}
  {{m_axi_lite} {I|O} {m_axi_lite_.*$}}
}

# Load all signals
set nsigs [ gtkwave::getNumFacs ]

proc add_signals { groupName dir_filter name_filter} {
    global nsigs

    set monitorSignals [list]
    for {set i 0} {$i < $nsigs } {incr i} {
      set facdir [ gtkwave::getFacDir $i]
      if {[regexp -nocase $dir_filter $facdir]} {
        set facname [ gtkwave::getFacName $i ]
        if {[regexp -nocase $name_filter $facname]} {
          lappend monitorSignals "$facname"
        }
      }
    }
    if {[llength $monitorSignals] > 0} {
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
}

# Add signals through filters
foreach s $signals {
    add_signals [lindex $s 0] [lindex $s 1] [lindex $s 2]
}

# Zoom out
gtkwave::/Time/Zoom/Zoom_Full
