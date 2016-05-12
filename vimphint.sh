#!/bin/sh
#                               _
#  ___ _ __   ___ _ __ ___   __| |
# / __| '_ \ / __| '_ ` _ \ / _` |
# \__ | |_) | (__| | | | | | (_| |
# |___| .__/ \___|_| |_| |_|\__,_|
#     |_|
# Created by: spcmd
# http://spcmd.github.io
# https://github.com/spcmd

# vimphint.sh lists the custom commands
# and key maps from the .vimperatorrc
# and makes a simple html output of them

help_file=/tmp/vimphint.html

cat << 'EOF' > $help_file
<!doctype html>

<html lang="en">
<head>
  <meta charset="utf-8">
  <title>vimphint.sh > html</title>
  <style>
    body {
        background: #fff;
        color: #000;
        font-family:monospace;
        font-size:13px;
    }
    span.command { color:red; }
    span.title { color:blue; font-weight:bold; }
  </style>
</head>
<body>
<p>
<span class="title">
vimphint - key maps:<br>
======================
</span>
</p>
EOF
awk '/^nmap/' .vimperatorrc | awk '{$1=""; gsub("<", "\\&lt;", $2); gsub(">", "\\&gt;", $2); gsub("<", "\\&lt;", $NF); gsub(">", "\\&gt;", $NF); $2="<p><span class=\"command\">"$2"<\/span>"; print $0"</p>"}' >> $help_file
cat << 'EOF' >> $help_file
<p>
<span class="title">
vimphint - commands:<br>
======================
</span>
</p>
EOF
 awk '/^command!/' .vimperatorrc | awk '{$1=""; $2="<p><span class=\"command\">"$2"<\/span>"; gsub("<", "\\&lt;", $NF); gsub(">", "\\&gt;", $NF); print $0"<\/p>"}' >> $help_file
cat << 'EOF' >> $help_file && firefox $help_file
</body>
</html>
EOF
