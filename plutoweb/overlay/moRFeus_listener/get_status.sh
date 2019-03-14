#!/bin/sh

# Here we set the morf_toolpath variable. Adapt if you need


morf_tool=/bin/morfeus_tool_linux_armv7

function get_status () {

dummy=$($morf_tool getCurrent)
sleep 0.1

echo "
****** moRFeus status

Frequency :  $($morf_tool getFrequency)
Mode      :  $($morf_tool getFunction)
Power     :  $($morf_tool getCurrent)

$(date +%Y-%m-%d" "%H:%M:%S)

"
echo $status
export morf_tool
}


